---
title: GitHub REST API
description: Practical reference for GitHub REST API v3 — repository and organization management via gh api and Python requests.
---

# GitHub REST API

GitHub's REST API has been around since forever, has roughly 600 endpoints, and is the backbone of every automation script that's ever been written to avoid clicking around the UI. In 2026, the right way to interact with it is `gh api` — GitHub's own CLI handles auth, headers, pagination and JSON output without you babysitting curl flags. This covers repositories and organization management, the two things you'll actually automate.

______________________________________________________________________

## Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # gh api wraps everything — auth is handled by `gh auth login`
    # No tokens to export, no headers to remember, no curl flags

    # Check your auth status and current user
    gh auth status
    gh api /user --jq '{login, name, public_repos}'

    # Check rate limit
    gh api /rate_limit --jq '.rate'

    # List your repos (--jq filters inline, no external jq needed)
    gh api /user/repos --jq '.[].full_name'

    # Get a specific repo
    gh api /repos/{owner}/{repo} \
      --jq '{name, description, default_branch, visibility}'

    # List org repos — --paginate fetches ALL pages automatically
    gh api /orgs/{org}/repos --paginate --jq '.[].name'

    # List org members
    gh api /orgs/{org}/members --paginate --jq '.[].login'
    ```

    **Real talk:**

    - `gh auth login` is the only setup you need — it stores credentials securely, no `~/.netrc` or exported tokens
    - `{owner}` and `{repo}` in paths are auto-filled from the current git directory context — useful when scripting inside repo checkouts
    - `--jq` runs the filter server-side before printing — faster than piping to external `jq` for large responses
    - `--paginate` is a gift — no manual page loops, no off-by-one errors, just all the data

=== ":fontawesome-solid-bolt: Common Patterns"

    ```bash
    # --- POST: create a repo in an org ---
    # -f for strings, -F for booleans and integers
    gh api /orgs/{org}/repos \
      --method POST \
      -f name="my-new-repo" \
      -f description="Created via API" \
      -F private=true \
      -F has_issues=true \
      -F has_wiki=false \
      -F auto_init=true \
      --jq '{name, html_url, visibility}'

    # --- PATCH: update repo settings ---
    gh api /repos/{owner}/{repo} \
      --method PATCH \
      -f description="Updated description" \
      -F delete_branch_on_merge=true \
      -F allow_squash_merge=true \
      -F allow_merge_commit=false \
      --jq '{name, description}'

    # --- PUT: add member to org team ---
    # role: "member" or "maintainer"
    gh api /orgs/{org}/teams/{team_slug}/memberships/{username} \
      --method PUT \
      -f role="member" \
      --jq '{state, role}'

    # --- PUT: grant team access to a repo ---
    # permission: pull | triage | push | maintain | admin
    gh api /orgs/{org}/teams/{team_slug}/repos/{org}/{repo} \
      --method PUT \
      -f permission="push"
    # Returns empty on success (HTTP 204) — no output is good output

    # --- Create a PR ---
    gh api /repos/{owner}/{repo}/pulls \
      --method POST \
      -f title="Fix the thing" \
      -f body="This fixes the thing that was broken" \
      -f head="feature/my-branch" \
      -f base="main" \
      -F draft=false \
      --jq '{number, title, html_url}'

    # --- Collect all results across pages into a file ---
    gh api /orgs/{org}/repos --paginate --jq '.[].name' > org-repos.txt
    ```

    **Why this works:**

    - `-f` is for strings, `-F` is for raw values (booleans, integers, JSON) — mixing them up produces silent wrong behavior
    - `--method` is explicit and readable — no `-X POST` cryptic flags
    - `PUT` team and repo permission calls are idempotent — safe to re-run in provisioning scripts
    - `--paginate` + `--jq` is the pagination pattern — one line instead of a while loop

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    **Tips:**

    - Use `gh api --include` to see response headers — useful to inspect rate limit remaining (`X-RateLimit-Remaining`) and pagination (`Link`)
    - `gh api --input file.json` reads the request body from a JSON file — cleaner than multiple `-f` flags for complex payloads
    - Use `--template` with Go template syntax for formatted table output — better than `--jq` when you want human-readable columnar output
    - For org-wide automation that survives employee turnover, use GitHub Apps instead of PATs — `gh` supports app auth via `GH_APP_ID` + `GH_APP_PRIVATE_KEY`
    - Run `gh api` with `--verbose` once when debugging — you'll see the full request and response including headers

    **Gotchas:**

    - `-F` with booleans requires lowercase `true`/`false` — `True` or `TRUE` will be sent as a string, silently
    - `DELETE /repos/{owner}/{repo}` is permanent — no trash, no undo, no "are you sure" prompt
    - Secondary rate limits (abuse detection) fire on rapid sequential POSTs — add a small delay in loops creating resources
    - `--paginate` concatenates JSON arrays — if your `--jq` filter doesn't account for this, you'll get parse errors on page boundaries
    - Fine-grained PATs cannot access all org endpoints — audit log and billing still require classic PATs or GitHub Apps in 2026

______________________________________________________________________

## Repository Management

### Create, Read, Update, Delete

```bash
# Create personal repo
gh api /user/repos \
  --method POST \
  -f name="my-repo" \
  -f description="A repo" \
  -F private=true \
  -F auto_init=true \
  --jq '{name, html_url}'

# Rename a repo
gh api /repos/{owner}/{repo} \
  --method PATCH \
  -f name="new-repo-name" \
  --jq '{name, html_url}'

# Archive a repo (one-way via API — no un-archive through API)
gh api /repos/{owner}/{repo} \
  --method PATCH \
  -F archived=true \
  --jq '{name, archived}'

# Transfer repo to an org
gh api /repos/{owner}/{repo}/transfer \
  --method POST \
  -f new_owner="{org}" \
  --jq '{name, full_name}'

# Delete repo — permanent, no confirmation
gh api /repos/{owner}/{repo} --method DELETE
```

### Branches and Protection Rules

```bash
# List branches
gh api /repos/{owner}/{repo}/branches \
  --paginate \
  --jq '.[] | {name, protected}'

# Get branch protection
gh api /repos/{owner}/{repo}/branches/main/protection \
  --jq '{required_status_checks, enforce_admins}'

# Set branch protection
gh api /repos/{owner}/{repo}/branches/main/protection \
  --method PUT \
  --input - <<'EOF'
{
  "required_status_checks": {
    "strict": true,
    "contexts": ["ci/build", "ci/test"]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 1,
    "dismiss_stale_reviews": true
  },
  "restrictions": null
}
EOF

# Create a branch from main's current HEAD
MAIN_SHA=$(gh api /repos/{owner}/{repo}/git/ref/heads/main --jq '.object.sha')
gh api /repos/{owner}/{repo}/git/refs \
  --method POST \
  -f ref="refs/heads/feature/new-branch" \
  -f sha="$MAIN_SHA"
```

### Issues, Pull Requests and Releases

```bash
# List open PRs
gh api /repos/{owner}/{repo}/pulls \
  --paginate \
  --jq '.[] | {number, title, draft, user: .user.login}'

# Merge a PR
gh api /repos/{owner}/{repo}/pulls/42/merge \
  --method PUT \
  -f merge_method="squash" \
  -f commit_title="feat: merge PR #42" \
  --jq '{merged, message}'

# Create an issue
gh api /repos/{owner}/{repo}/issues \
  --method POST \
  -f title="Something is broken" \
  -f body="It was working yesterday." \
  -f 'labels[]=bug' \
  -f 'assignees[]=username' \
  --jq '{number, html_url}'

# Close an issue
gh api /repos/{owner}/{repo}/issues/15 \
  --method PATCH \
  -f state="closed" \
  -f state_reason="completed"

# Create a release with auto-generated notes
gh api /repos/{owner}/{repo}/releases \
  --method POST \
  -f tag_name="v1.2.0" \
  -f name="v1.2.0" \
  -F draft=false \
  -F prerelease=false \
  -F generate_release_notes=true \
  --jq '{id, tag_name, html_url}'
```

______________________________________________________________________

## Organization Management

### Members and Invitations

```bash
# List all org members
gh api /orgs/{org}/members --paginate --jq '.[].login'

# Check membership and role
gh api /orgs/{org}/memberships/{username} --jq '{role, state}'

# Invite by email
gh api /orgs/{org}/invitations \
  --method POST \
  -f email="person@company.com" \
  -f role="direct_member" \
  --jq '{id, email, role}'

# List pending invitations
gh api /orgs/{org}/invitations \
  --jq '.[] | {login, email, role, created_at}'

# Cancel invitation
gh api /orgs/{org}/invitations/{invitation_id} --method DELETE

# Remove org member (also removes from all teams)
gh api /orgs/{org}/members/{username} --method DELETE
```

### Teams

```bash
# List all teams
gh api /orgs/{org}/teams \
  --paginate \
  --jq '.[] | {name, slug, privacy, members_count, repos_count}'

# Create a team
gh api /orgs/{org}/teams \
  --method POST \
  -f name="backend-devs" \
  -f description="Backend engineering team" \
  -f privacy="closed" \
  --jq '{id, name, slug}'

# List team members
gh api /orgs/{org}/teams/{team_slug}/members \
  --paginate \
  --jq '.[].login'

# Add member to team
gh api /orgs/{org}/teams/{team_slug}/memberships/{username} \
  --method PUT \
  -f role="member" \
  --jq '{state, role}'

# Remove member from team
gh api /orgs/{org}/teams/{team_slug}/memberships/{username} \
  --method DELETE

# List repos a team can access
gh api /orgs/{org}/teams/{team_slug}/repos \
  --paginate \
  --jq '.[] | {name, permissions}'

# Grant team access to a repo
gh api /orgs/{org}/teams/{team_slug}/repos/{org}/{repo} \
  --method PUT \
  -f permission="push"

# Remove team repo access
gh api /orgs/{org}/teams/{team_slug}/repos/{org}/{repo} \
  --method DELETE
```

### Org Settings and Audit

```bash
# Get org details
gh api /orgs/{org} \
  --jq '{login, name, public_repos, total_private_repos, members_can_create_repositories}'

# Disable member repo creation
gh api /orgs/{org} \
  --method PATCH \
  -F members_can_create_repositories=false \
  -F members_can_create_public_repositories=false \
  --jq '{login, members_can_create_repositories}'

# List outside collaborators
gh api /orgs/{org}/outside_collaborators \
  --paginate \
  --jq '.[].login'

# Remove outside collaborator from all org repos
gh api /orgs/{org}/outside_collaborators/{username} --method DELETE

# Audit log (requires GitHub Teams/Enterprise + admin:org scope)
gh api /orgs/{org}/audit-log \
  --paginate \
  --jq '.[] | {action, actor, created_at, repo}'

# Check Actions billing
gh api /orgs/{org}/settings/billing/actions \
  --jq '{total_minutes_used, total_paid_minutes_used, included_minutes}'
```

______________________________________________________________________

## Python: requests

When `gh api` isn't enough — scripting complex logic, building integrations, or running in environments without the GitHub CLI installed.

```python
import os
import requests

# --- Session setup: do this once ---
BASE_URL = "https://api.github.com"

session = requests.Session()
session.headers.update({
    "Authorization": f"Bearer {os.environ['GH_TOKEN']}",
    "Accept": "application/vnd.github+json",
    "X-GitHub-Api-Version": "2022-11-28",
})


def gh_get(path: str, **params) -> dict | list:
    """Simple GET — raises on non-2xx."""
    r = session.get(f"{BASE_URL}{path}", params=params)
    r.raise_for_status()
    return r.json()


def gh_post(path: str, payload: dict) -> dict:
    r = session.post(f"{BASE_URL}{path}", json=payload)
    r.raise_for_status()
    return r.json()


def gh_patch(path: str, payload: dict) -> dict:
    r = session.patch(f"{BASE_URL}{path}", json=payload)
    r.raise_for_status()
    return r.json()


def gh_delete(path: str) -> None:
    r = session.delete(f"{BASE_URL}{path}")
    r.raise_for_status()


def paginate(path: str, **params) -> list:
    """Fetch all pages, return flat list."""
    params.setdefault("per_page", 100)
    results = []
    url = f"{BASE_URL}{path}"
    while url:
        r = session.get(url, params=params)
        r.raise_for_status()
        results.extend(r.json())
        # Follow Link header for next page
        url = r.links.get("next", {}).get("url")
        params = {}  # params are already in the next URL
    return results
```

### Repository operations

```python
org = "my-org"
repo = "my-repo"
user = "my-username"

# Get repo info
data = gh_get(f"/repos/{user}/{repo}")
print(data["full_name"], data["visibility"])

# Create repo in org
new_repo = gh_post(f"/orgs/{org}/repos", {
    "name": "new-repo",
    "description": "Created via Python",
    "private": True,
    "auto_init": True,
    "delete_branch_on_merge": True,
})
print(new_repo["html_url"])

# Update repo settings
gh_patch(f"/repos/{org}/{repo}", {
    "description": "Updated via API",
    "allow_squash_merge": True,
    "allow_merge_commit": False,
})

# List all org repos with pagination
repos = paginate(f"/orgs/{org}/repos", type="all")
for r in repos:
    print(r["name"], r["visibility"])

# Create an issue
issue = gh_post(f"/repos/{org}/{repo}/issues", {
    "title": "Something is broken",
    "body": "It was working yesterday.",
    "labels": ["bug"],
    "assignees": [user],
})
print(issue["html_url"])

# Create a release
release = gh_post(f"/repos/{org}/{repo}/releases", {
    "tag_name": "v2.0.0",
    "name": "v2.0.0",
    "draft": False,
    "prerelease": False,
    "generate_release_notes": True,
})
print(release["html_url"])
```

### Organization operations

```python
# List all org members
members = paginate(f"/orgs/{org}/members")
logins = [m["login"] for m in members]

# Invite someone by email
gh_post(f"/orgs/{org}/invitations", {
    "email": "person@company.com",
    "role": "direct_member",
})

# Create a team
team = gh_post(f"/orgs/{org}/teams", {
    "name": "platform-team",
    "description": "Platform engineering",
    "privacy": "closed",
})
team_slug = team["slug"]

# Add member to team
session.put(
    f"{BASE_URL}/orgs/{org}/teams/{team_slug}/memberships/username",
    json={"role": "member"},
).raise_for_status()

# Grant team access to repo
session.put(
    f"{BASE_URL}/orgs/{org}/teams/{team_slug}/repos/{org}/{repo}",
    json={"permission": "push"},
).raise_for_status()

# Fetch audit log (Enterprise/Teams plan required)
events = paginate(f"/orgs/{org}/audit-log", include="all")
for e in events:
    print(e.get("action"), e.get("actor"), e.get("created_at"))
```

!!! tip "Use a session, not bare requests.get()"
    `requests.Session()` reuses the underlying TCP connection across calls.
    On large org audits with hundreds of API calls, this saves meaningful time.
    It also keeps headers DRY — set once, used everywhere.

______________________________________________________________________

## Reference

**Documentation:**

- :fontawesome-solid-book: [GitHub REST API Reference](https://docs.github.com/en/rest)
- :fontawesome-solid-terminal: [gh api command reference](https://cli.github.com/manual/gh_api)
- :fontawesome-solid-shield: [Fine-grained PATs Guide](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)

**Related:**

- :fontawesome-solid-building: __GitHub Apps — replace PATs for org-level automation that survives employee turnover__
- :fontawesome-solid-code: __PyGithub — higher-level Python client if you want ORM-style access over raw requests__
- :fontawesome-solid-key: __`gh auth login` — the only setup step you need before using `gh api`__

______________________________________________________________________

**Last Updated:** 2026-03-20
**Tags:** github, rest-api, gh-cli, python, repository-management, organization-management, automation
