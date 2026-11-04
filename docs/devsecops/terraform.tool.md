---
title: Terraform
description: the de-facto infrastructure-as-code standard — declare desired state in HCL and Terraform diffs it against reality; the state file is the actual job
---

# :lucide-layers: Terraform

Terraform is the de-facto infrastructure-as-code standard: declare desired state in HCL, and Terraform diffs it against reality to work out the create, update, and destroy calls. The HCL is the easy part. The actual job is state management — where the state lives, who locks it, and how badly your week goes when two engineers apply concurrently.

!!! tip "2026 Update"
    Current stable is v1.15.8 (July 8, 2026). Anything labelled 1.16.0-alpha on the downloads page is a pre-release, not stable — stop installing it by accident. HashiCorp is now an IBM company and Terraform remains BSL 1.1 licensed: free to manage your own infrastructure, restricted if you want to build a competing hosted offering. Only the two newest release lines get fixes — currently 1.15.x and 1.14.x; the 1.13 line went EOL on April 29, 2026.

---

## Quick Hits

=== ":lucide-list-check: Essential Commands"

    ```bash
    # Install mise once — one manager for every tool in this section
    curl https://mise.run | sh                                # (1)!
    mise use -g terraform@1.15.8                              # (2)!

    # Per-project pin — mise writes .mise.toml, commit it
    mise use terraform@1.15.8                                 # (3)!

    # Core workflow
    terraform fmt -recursive                                  # (4)!
    terraform init                                            # (5)!
    terraform validate
    terraform plan -out=tfplan                                # (6)!
    terraform apply tfplan                                    # (7)!
    ```

    1. Linux-first installer — lands in `~/.local/bin`, no root required; activate your shell afterwards (`mise activate zsh`).
    2. Global default lives in `~/.config/mise/config.toml`.
    3. Project-local pin replaces the old `.terraform-version` file convention — one `.mise.toml` can pin terraform AND tflint together.
    4. Normalizes formatting so style diffs never appear in code review.
    5. Downloads providers and writes `.terraform.lock.hcl` — COMMIT IT.
    6. Saves the plan so what gets applied is exactly what was reviewed.
    7. Applies the saved plan byte-for-byte instead of re-planning against a possibly changed world.

    **Real talk:**

    - Always plan before apply, and save the plan file (`-out=`) so CI applies exactly what was reviewed.
    - `.terraform.lock.hcl` pins provider checksums — commit it.
    - Run `terraform version` in CI to catch version drift early.

=== ":lucide-bolt: Common Patterns"

    Pin the core and the providers together:

    ```hcl
    terraform {
      required_version = "~> 1.15"

      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 6.0"   # AWS provider v6.x is current in 2026
        }
      }
    }
    ```

    Remote state with locking — non-negotiable for teams:

    ```hcl
    terraform {
      backend "s3" {
        bucket         = "myorg-tfstate"
        key            = "prod/network.tfstate"
        region         = "eu-west-1"
        dynamodb_table = "tf-locks"
        encrypt        = true
      }
    }
    ```

    Native tests since 1.6 — no external framework required:

    ```hcl
    # tests/naming.tftest.hcl
    run "naming_convention" {
      command = plan

      assert {
        condition     = startswith(aws_s3_bucket.logs.bucket, "myorg-")
        error_message = "Buckets must follow the myorg- naming convention"
      }
    }
    ```

    **Why this works:**

    - `~>` constraints allow patch and minor updates within a release line while blocking major-bump surprises.
    - The lockfile makes CI runs reproducible — every machine resolves identical provider versions.
    - Tests catch logic errors before plan, while fixes are still cheap.

=== ":material-fire: Pro Tips & Gotchas"

    **Tips:**

    - Keep state small — split by blast radius so one bad apply cannot take down everything at once.
    - Use ephemeral values (1.10+) and write-only arguments (1.11+) instead of shoving secrets through variables.
    - Try list resources plus `terraform query` (1.14) for cloud inventory queries without touching state.
    - 1.15 adds dynamic module sources, deprecated markers on variables/outputs, and `convert()`.

    **Gotchas:**

    - State files contain PLAINTEXT secrets — encrypt the backend bucket and restrict IAM hard.
    - State is stamped with the writer's version, older binaries REFUSE newer state, and upgrades are one-way.
    - Never edit state by hand — use `terraform state mv`, `terraform state rm`, or `import`.
    - Stacks (GA late 2025) is an HCP Terraform feature — you do not get it from the OSS binary.

---

## Terraform vs OpenTofu (2026)

In August 2023 HashiCorp relicensed Terraform from MPL 2.0 to BSL 1.1; the community forked the last-MPL code into OpenTofu under the Linux Foundation, and both have shipped since. Three years later the split is boring in the good way:

| Aspect | Terraform | OpenTofu |
|--------|-----------|----------|
| License | BSL 1.1 | MPL 2.0 |
| Governance | IBM / HashiCorp | Linux Foundation |
| State encryption | Backend-side only | Native client-side encryption built-in |
| Registry | registry.terraform.io | registry.opentofu.org + TF-compatible |
| Orchestration extras | Stacks (GA late 2025) — HCP-only | None — use Terragrunt and friends |
| Binary name | terraform | tofu |

Both support ephemeral resources through independent implementations, and the provider ecosystem is largely shared — AWS provider v6.x works with both. For typical configs, migration amounts to renaming the binary in CI.

Choosing between them:

- Need Stacks, HCP Terraform, Sentinel, or commercial support → Terraform.
- Need an OSI-approved license, client-side state encryption (regulated industries), or vendor independence → OpenTofu.
- Everyone else → either works. Pick once, document it, move on.

---


---

## tflint

=== ":lucide-list-check: Essential Commands"

    ```bash
    # Install via mise
    mise use -g tflint@0.64                              # (1)!

    # Download plugins declared in .tflint.hcl
    tflint --init                                        # (2)!

    # Lint the current directory
    tflint                                               # (3)!

    # Provider-aware checks — run AFTER terraform init so schemas load
    terraform init && tflint                             # (4)!

    # SARIF output for GitHub Code Scanning
    tflint --format sarif                                # (5)!
    ```

    1. mise resolves the release binary through its aqua backend — no system package manager involved.
    2. Nothing downloads until you ask — plugins are declared in config, fetched by `--init`.
    3. Generic core rules run without plugins or cloud access.
    4. Provider plugins resolve real schemas from the initialized environment — this catches invalid instance types and malformed ARNs.
    5. Formats available: default, compact, json, checkstyle, junit, sarif.

    **Real talk:**

    - Provider-aware checks require `terraform init` first; opt-in deep checks additionally need `deep_check = true` in the plugin block plus credentials.
    - Core rules alone catch generic HCL issues; the provider plugins catch everything interesting.
    - Verify downloaded binaries with `gh attestation verify` — cosign verification is dead as of 2026.

=== ":lucide-bolt: Common Patterns"

    A working `.tflint.hcl` — plugin plus rule tuning:

    ```hcl
    # .tflint.hcl
    plugin "aws" {
      enabled = true
      version = "0.x"     # pin an exact version — floating breaks builds
      source  = "github.com/terraform-linters/tflint-ruleset-aws"

      # deep_check = true  # opt-in API validation; requires AWS credentials
    }

    rule "terraform_deprecated_syntax" {
      enabled = true
    }

    rule "aws_instance_previous_type" {
      enabled = false     # legacy t2 fleet; re-enable after migration
    }
    ```

    Monorepo? Lint every module in one pass:

    ```bash
    tflint --recursive
    ```

    CI with SARIF upload to GitHub Code Scanning:

    ```yaml
    # .github/workflows/tflint.yml (excerpt)
    steps:
      - uses: terraform-linters/setup-tflint@v6   # official action (v6.x line)

      - run: tflint --init
      - name: Lint all modules
        run: tflint --recursive --format sarif > tflint.sarif

      # Upload tflint.sarif via github/codeql-action/upload-sarif
      # so findings land in the Security tab
    ```

    **Why this works:**

    - Plugin declarations make the toolchain explicit and auditable — no surprise downloads mid-build.
    - Rule blocks kill noise at the source instead of ignoring findings one by one.
    - `--recursive` replaces per-directory shell loops; module linting stays consistent across the tree.
    - Uploading SARIF via `github/codeql-action/upload-sarif` puts lint findings next to CodeQL results where triage already happens.

=== ":material-fire: Pro Tips & Gotchas"

    **Tips:**

    - Pin plugin versions in `.tflint.hcl` — unpinned plugins upgrade out from under CI without warning.
    - Run `--recursive` in monorepos instead of looping over directories with shell scripts.
    - Wire TFLint into pre-commit AND CI: pre-commit catches it locally, CI catches everyone who bypassed the hooks.

    **Gotchas:**

    - TFLint is a linter, not a security scanner — pair it with checkov or Trivy for policy and compliance findings.
    - Deep checks call the cloud API with your provider credentials — scope them read-only and plan auth for CI.
    - Plugin SDK mismatches break old custom plugins — anything built on the SDK v0.25 era needs rebuilding against the current SDK.

---

---

## checkov

=== ":lucide-list-check: Essential Commands"

    ```bash
    # Install via mise
    mise use -g checkov@latest                           # (1)!

    # Scan the whole repo — auto-detects frameworks
    checkov -d .                                         # (2)!

    # Scan one framework only
    checkov -d . --framework terraform                   # (3)!

    # CI gate — fail the build on HIGH severity and above
    checkov -d . --hard-fail-on HIGH                     # (4)!

    # Report-only pass while baselining
    checkov -d . --soft-fail

    # SARIF output for GitHub Code Scanning
    checkov -d . --output sarif > checkov.sarif
    ```

    1. mise installs it in an isolated environment — no venv juggling; the bridgecrew/checkov image remains the container option.
    2. Auto-detection is convenient; expect noise until suppressions are triaged.
    3. Cuts scan time and noise on single-framework repos.
    4. Start with `--soft-fail` for a sprint, then flip to hard-failing once the backlog is clean.

    **Real talk:**

    - Suppressions live inline in code: `# checkov:skip=CKV_AWS_20:<reason>` — greppable, reviewable, attributable.
    - Output formats cover CLI table, JSON, JUnit, CycloneDX SBOM, and SARIF for the Security tab.
    - Graph-based checks evaluate cross-resource relationships: a public S3 bucket attached to public-facing compute gets flagged as a compound finding, not two unrelated hits.

=== ":lucide-bolt: Common Patterns"

    Suppression lives where the finding does:

    ```hcl
    resource "aws_s3_bucket" "public_assets" { # checkov:skip=CKV_AWS_20:The bucket is public on purpose
      bucket = "my-cdn-assets"
    }
    ```

    Custom policies come in declarative YAML or Python classes:

    ```yaml
    metadata:
      id: CUSTOM_AWS_001
      name: S3 buckets must use customer-managed KMS keys
      category: ENCRYPTION
      severity: HIGH
    definition:
      cond_type: attribute
      resource_types:
        - aws_s3_bucket_server_side_encryption_configuration
      attribute: rule.apply_server_side_encryption_by_default.sse_algorithm
      operator: equals
      value: aws:kms
    ```

    **The 2026 open-source IaC scanner field** (all three support OpenTofu):

    | Scanner | Rules | Custom Policies | Best For |
    |---------|-------|-----------------|----------|
    | **Checkov** | ~1,400 | Python / YAML | Depth + graph-based compound checks |
    | **Trivy** (config mode) | ~1,000 | Rego | tfsec successor; fastest; broadest multi-mode |
    | **KICS** | ~2,400 | Rego | Widest format coverage incl Pulumi/Crossplane; noisiest |

    **Why this works:**

    - Inline skips appear in PR diffs with author and reason attached — no mystery suppressions.
    - Declarative YAML covers most org policies; drop to Python classes when logic gets complicated.
    - Graph checks catch compound exposure that per-resource scanners wave through.
    - Trivy and KICS are fine tools too — pick on rule depth versus noise tolerance, not hype.

=== ":material-fire: Pro Tips & Gotchas"

    **Tips:**

    - Baseline with `--soft-fail` for one sprint, then enforce with `--hard-fail-on HIGH` once the backlog is triaged.
    - Upload SARIF so findings land in the GitHub Security tab next to CodeQL — one triage queue instead of two.
    - Ship AI workloads? Add the AWS Bedrock, GCP Vertex AI, and Azure OpenAI policy packs (~47 AI-infrastructure checks added across 2025–2026).

    **Gotchas:**

    - The regex-based secrets scanner misses non-patterned credentials — pair it with trufflehog or gitleaks for verified detection.
    - Cross-module data flow analysis is weak; checks stay module-local, so exposures spanning modules slip past graph evaluation.
    - Pin bridgecrewio/checkov-action to a full commit SHA — the 2026 TeamPCP attack hit unpinned IaC-scanner actions.
    - tfsec ignores are NOT auto-migrated into Trivy or Checkov — re-triage every old suppression by hand.

---

---

## terraform-docs

=== ":lucide-list-check: Essential Commands"

    ```bash
    # Install via mise
    mise use -g terraform-docs@0.24

    # Generate straight to stdout
    terraform-docs markdown table ./modules/vpc          # (1)!

    # Inject docs between HTML markers in the README
    terraform-docs markdown table \
      --output-file README.md \
      --output-mode inject ./modules/vpc                 # (2)!
    ```

    1. Formats: markdown table/document, AsciiDoc, JSON/YAML/XML/TOML, pretty, tfvars hcl
    2. Inject mode writes between marker comments — everything outside them stays untouched

    Inject mode looks for these markers in the target file:

    ```markdown
    <!-- BEGIN_TF_DOCS -->
    Generated content lands here — never hand-edit it
    <!-- END_TF_DOCS -->
    ```

    **Real talk:**

    - The config file is `.terraform-docs.yml`, searched in module root, then `.config/`, then cwd, then `$HOME/.tfdocs.d/`.
    - `formatter:` is the one REQUIRED key — everything else has sane defaults.
    - Header content comes from description comments in main.tf via `header-from`; write descriptions once per variable and stop duplicating them.

=== ":lucide-bolt: Common Patterns"

    Minimal config — enough for most modules:

    ```yaml
    # .terraform-docs.yml
    formatter: markdown table        # required key

    output:
      file: README.md
      mode: inject

    sort:
      enabled: true
      by: name

    sections:
      hide: []
    ```

    Enforce it locally with pre-commit:

    ```yaml
    # .pre-commit-config.yaml
    repos:
      - repo: https://github.com/terraform-docs/terraform-docs
        rev: "v0.24.0"
        hooks:
          - id: terraform-docs-go
    ```

    Backstop contributors who skipped hooks — regenerate and push docs on every PR:

    ```yaml
    # .github/workflows/docs.yml
    name: terraform-docs
    on:
      pull_request:

    permissions:
      contents: write                # git-push needs a token with write access

    jobs:
      docs:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v5            # pin to a commit SHA in production
          - uses: terraform-docs/gh-actions@v1   # pin to a commit SHA in production
            with:
              working-dir: modules/vpc
              output-file: README.md
              output-method: inject
              git-push: "true"
    ```

    **Why this works:**

    - Docs regenerate from source, so they cannot drift — reviewers see doc diffs in the same PR that changed the module.
    - Inject mode preserves hand-written prose around the markers; automation touches only its own section.
    - Pre-commit keeps local clones fresh, and the workflow catches everyone who used `--no-verify`.

=== ":material-fire: Pro Tips & Gotchas"

    **Tips:**

    - Document-as-you-go: generated tables beat hand-written input lists that rot within two sprints.
    - Write each variable description once in source — `header-from` pulls description comments into the generated header.
    - Use recursive mode for monorepo module trees: one command documents every module underneath.

    **Gotchas:**

    - Never hand-edit content between BEGIN_TF_DOCS / END_TF_DOCS markers — the next run clobbers it without asking.
    - Broken or removed markers fail silently: inject changes nothing and exits fine. Check the diff.
    - Commit the generated docs — docs-as-code means reviewers actually see documentation changes in PRs instead of trusting a wiki.
    - The gh-action's `git-push: "true"` needs a token with write permissions, otherwise the job exits green having pushed nothing.

---


## Reference

**Documentation:**

- :lucide-book: [Terraform Docs](https://developer.hashicorp.com/terraform)
- :simple-github: [hashicorp/terraform](https://github.com/hashicorp/terraform)
- :lucide-book: [Release Archives](https://releases.hashicorp.com/terraform/)
- :lucide-book: [OpenTofu](https://opentofu.org)
- :lucide-book: [endoflife.date/terraform](https://endoflife.date/terraform)

**Related:**

- :lucide-wrench: [tflint](#tflint)
- :lucide-wrench: [checkov](#checkov)
- :lucide-wrench: [terraform-docs](#terraform-docs)

---

**Last Updated:** 2026-08-22 | **Vibe Check:** :lucide-globe: **Industry Standard** - still the default IaC choice; just mind the license and the EOL window.

**Tags:** iac, devsecops, terraform
