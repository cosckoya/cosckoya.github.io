# GitOps

Git as the single source of truth for your infrastructure. Because what could go wrong when your entire production environment depends on merge requests and YAML files? Turns out, quite a lot actually—but somehow still less than Jenkins pipelines and manual kubectl commands.

Declarative infrastructure that syncs itself. Kubernetes watches Git, Git watches you fuck up, and at 3 AM when everything's on fire, at least you'll know exactly which commit to blame.

______________________________________________________________________

## Quick Hits

=== "🎯 Core Principles"

    ```yaml
    # The Four Commandments (OpenGitOps v1.0.0)

    1. Declarative: Describe WHAT you want, not HOW
       - YAML manifests define desired state
       - No imperative kubectl commands
       - No "just SSH in and fix it"

    2. Versioned & Immutable: Git is the source of truth
       - Every change = Git commit
       - Full audit history forever
       - Rollback = git revert

    3. Pulled Automatically: Agents watch Git
       - No CI pushing to clusters
       - Cluster pulls from Git
       - Your Jenkins can't fuck up production anymore

    4. Continuously Reconciled: Drift detection
       - Agent syncs actual → desired state
       - Someone kubectl edited? Fixed automatically
       - Configuration drift = detected and corrected
    ```

    **Real talk:**

    - Git becomes your control plane (scary but powerful)
    - Everything in version control means everything is auditable
    - Pull-based = no cluster credentials in CI/CD
    - Reconciliation loops = self-healing infrastructure

=== "⚡ Common Patterns"

    ```bash
    # Monorepo pattern (single Git repo)
    gitops-repo/
    ├── apps/
    │   ├── frontend/
    │   │   ├── base/
    │   │   └── overlays/
    │   │       ├── dev/
    │   │       ├── staging/
    │   │       └── prod/
    │   └── backend/
    ├── infrastructure/
    │   ├── namespaces/
    │   ├── ingress/
    │   └── monitoring/
    └── clusters/
        ├── dev-cluster/
        ├── staging-cluster/
        └── prod-cluster/

    # Repo-per-environment pattern
    gitops-dev/          # Dev configs
    gitops-staging/      # Staging configs
    gitops-prod/         # Prod configs (restricted access)

    # Repo-per-team pattern
    gitops-platform/     # Platform team owns infra
    gitops-team-alpha/   # Team Alpha owns their apps
    gitops-team-beta/    # Team Beta owns their apps

    # App repo + Config repo separation
    app-source-code/     # Application code + Dockerfile
    app-gitops-config/   # K8s manifests + Helm charts
    ```

    **Repository Anti-Patterns:**

    - ❌ **Branches per environment** (dev/staging/prod branches)

        - Merge conflicts nightmare
        - Promotion = merge (but you never want ALL changes)
        - Hotfixes create permanent drift
        - Use folders/overlays instead

    - ❌ **Everything in one app repo**

        - Devs shouldn't need cluster access to ship code
        - Mixing code + config = messy CI/CD
        - Separate repos = separate lifecycles

=== "🔥 GitOps vs Traditional CD"

    **Traditional CD (Push Model):**

    ```mermaid
    CI/CD Pipeline → kubectl apply → Cluster
    ```

    - CI has cluster credentials (security risk)
    - Push-based = no drift detection
    - Failed deploys = manual intervention
    - Audit trail = parsing CI logs

    **GitOps (Pull Model):**

    ```mermaid
    Git Repo ← Agent (running in cluster) → Cluster
    ```

    - No cluster credentials outside cluster
    - Pull-based = automatic drift detection
    - Failed deploys = reconciliation retries
    - Audit trail = git log

    **GitOps Wins:**

    - ✅ Security: No cluster creds in CI
    - ✅ Auditability: Git log > CI logs
    - ✅ Rollback: `git revert` > praying
    - ✅ Drift detection: Free
    - ✅ Self-healing: Automatic
    - ✅ Disaster recovery: Re-sync from Git

    **GitOps Pain Points:**

    - ❌ Secrets in Git (don't, use sealed secrets/external secrets)
    - ❌ Initial complexity (learning curve is steep)
    - ❌ Merge conflicts with auto-updates
    - ❌ Repository explosion at scale
    - ❌ Image updates = commits (noisy Git history)

    **When NOT to use GitOps:**

    - Small projects (Vercel/Netlify easier)
    - Non-Kubernetes environments (Terraform better)
    - Immature Git practices (fix your workflow first)
    - Need instant deploys (Git sync delay 1-3min)
    - Compliance forbids infra-as-code

______________________________________________________________________

## The Tools

### ArgoCD - The Popular Kid

**What it is:** Declarative GitOps CD tool with a slick UI. 21.7k GitHub stars, 6.7k forks, used everywhere.

**Why it's popular:**

- Web UI that doesn't suck
- Multi-cluster support out of the box
- SSO integration (SAML, OIDC, LDAP)
- App-of-apps pattern (GitOps managing GitOps)
- Health status visualization
- Rollback with a button click
- Sync waves for orchestration

**The good:**

```bash
# Install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f \
  https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Access UI
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Get admin password
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d

# Create application
argocd app create my-app \
  --repo https://github.com/user/repo \
  --path manifests \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace default \
  --sync-policy automated \
  --auto-prune
```

**The bad:**

- Initial admin secret expires (change it fast)
- RBAC config is verbose as hell
- UI can be slow with 100+ apps
- Resource-heavy for large clusters
- Sync can be slow with big repos

**Common gotchas:**

- Default sync timeout = 5min (adjust for large apps)
- Requires namespace to exist (create first)
- SSO misconfiguration = lockout (keep admin access)
- App-of-apps = circular dependency hell
- PreSync/PostSync hooks require RBAC

### FluxCD - The CNCF Graduate

**What it is:** Kubernetes-native GitOps with GitOps Toolkit controllers. 7.8k stars, CNCF graduated (the real deal).

**Why it's solid:**

- True Kubernetes-native (CRDs everywhere)
- Smaller resource footprint than Argo
- Multi-tenancy built-in
- Progressive delivery with Flagger
- Helm + Kustomize native support
- OCI artifact support
- No UI (CLI + kubectl only)

**The good:**

```bash
# Install Flux CLI
curl -s https://fluxcd.io/install.sh | sudo bash

# Bootstrap Flux on cluster
flux bootstrap github \
  --owner=your-org \
  --repository=fleet-infra \
  --branch=main \
  --path=clusters/prod \
  --personal

# Create GitRepository source
flux create source git webapp \
  --url=https://github.com/user/webapp \
  --branch=main \
  --interval=1m

# Create Kustomization
flux create kustomization webapp \
  --source=webapp \
  --path="./kustomize" \
  --prune=true \
  --interval=10m

# Monitor reconciliation
flux get kustomizations --watch
```

**The bad:**

- No UI (for some this is a feature)
- CRD soup (Source, Kustomization, HelmRelease, etc.)
- Learning curve steeper than Argo
- Multi-repo setup = more CRDs
- Documentation scattered

**Common gotchas:**

- Bootstrap creates repo structure (understand it first)
- Image automation = separate controller
- HelmRelease failures can be cryptic
- Dependency ordering requires explicit config
- Flux reconciles at intervals (not instant)

### The Alternatives

**Jenkins X** - "CI/CD platform for K8s with GitOps"

- Died and resurrected multiple times
- Preview environments are cool
- Complexity level: Expert
- Skip unless you love Jenkins pain

**Weave GitOps OSS** - "Simple GitOps for people without K8s expertise"

- Built on Flux
- Adds web UI to Flux
- Free tier limited
- Good for Flux + UI combo

**Atlantis** - "Terraform PR automation"

- Not Kubernetes-focused
- GitOps for Terraform
- PR comments trigger plans
- Perfect for infra code review

**PipeCD** - "CD for K8s, serverless, infrastructure"

- Unified control plane
- Multi-cloud support
- Less mature ecosystem
- Worth watching

______________________________________________________________________

## Learning Paths

### 🎓 Free Resources

- **[OpenGitOps Principles](https://opengitops.dev/)** - The official spec, read this first
- **[ArgoCD Getting Started](https://argo-cd.readthedocs.io/en/stable/getting_started/)** - Official docs, actually good
- **[Flux Docs](https://fluxcd.io/flux/)** - Comprehensive guides and tutorials
- **[GitOps Guide by Codefresh](https://codefresh.io/learn/gitops/)** - Deep dive into concepts and tools
- **[Awesome GitOps](https://github.com/weaveworks/awesome-gitops)** - Curated list of everything GitOps

### 🧪 Interactive Labs

- **[Argo Rollouts Playground](https://rollouts-demo.argoproj.io/)** - Try canary deployments in browser
- **[Killercoda ArgoCD](https://killercoda.com/argoproj)** - Interactive ArgoCD scenarios
- **[Flux Get Started](https://fluxcd.io/flux/get-started/)** - Hands-on bootstrap guide

### 📜 Certifications Worth It

- **[CKAD - Certified Kubernetes Application Developer](https://www.cncf.io/certification/ckad/)** - $395, GitOps patterns covered
- **[GitOps at Scale Certification (Codefresh)](https://codefresh.io/gitops-certification/)** - Free, vendor-specific but practical
- **Skip:** No dedicated "GitOps Certification" exists yet (it's just K8s + Git knowledge)

### 🚀 Projects to Build

- **Beginner:** Deploy a simple app with ArgoCD (nginx + manifests)
- **Intermediate:** Multi-environment setup with Kustomize overlays + automated image updates
- **Advanced:** Multi-cluster platform with app-of-apps pattern, sealed secrets, progressive delivery

______________________________________________________________________

## Community Pulse

### 🐦 Who to Follow

**Twitter/X:**

- [@argoproj](https://twitter.com/argoproj) - ArgoCD updates and announcements
- [@fluxcd](https://twitter.com/fluxcd) - Flux project news
- [@OpenGitOps](https://twitter.com/OpenGitOps) - GitOps standards and working group
- [@alexellisuk](https://twitter.com/alexellisuk) - OpenFaaS creator, GitOps advocate
- [@weaveworks](https://twitter.com/weaveworks) - Flux creators, GitOps pioneers

**Real practitioners** (search "#gitops" for war stories and gotchas)

### 💬 Active Communities

- **[ArgoCD GitHub Discussions](https://github.com/argoproj/argo-cd/discussions)** - 1k+ discussions, active daily, core team responds
- **[CNCF Slack - #argo-cd](https://cloud-native.slack.com/)** - 10k+ members, fast responses
- **[CNCF Slack - #flux](https://cloud-native.slack.com/)** - Active Flux community, helpful maintainers
- **[r/kubernetes](https://reddit.com/r/kubernetes)** - GitOps discussions mixed with K8s general content
- **[Dev.to #gitops](https://dev.to/t/gitops)** - Tutorials and case studies

### 🎙️ Podcasts & Newsletters

- **[Kubernetes Podcast](https://kubernetespodcast.com/)** - Weekly, GitOps topics covered regularly
- **[The New Stack](https://thenewstack.io/gitops/)** - GitOps articles and analysis
- **[Last Week in AWS](https://www.lastweekinaws.com/)** - Corey Quinn roasts EKS + GitOps combos

### 🎪 Events & Conferences

- **[ArgoCon](https://events.linuxfoundation.org/argocon/)** - Annual ArgoCD conference
- **[GitOpsCon](https://events.linuxfoundation.org/gitopscon-north-america/)** - North America & Europe, part of KubeCon
- **[KubeCon + CloudNativeCon](https://www.cncf.io/kubecon-cloudnativecon-events/)** - Major GitOps track every year
- **[Flux Community Meetings](https://fluxcd.io/community/)** - Monthly online, open to all

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- 📚 __Official Stuff__

    ______________________________________________________________________

    [OpenGitOps Principles](https://opengitops.dev/)

    [ArgoCD Docs](https://argo-cd.readthedocs.io/)

    [Flux Docs](https://fluxcd.io/flux/)

    [CNCF GitOps WG](https://github.com/cncf/tag-app-delivery)

- 🧪 __Hands-on__

    ______________________________________________________________________

    [ArgoCD Playground](https://killercoda.com/argoproj)

    [Flux Get Started](https://fluxcd.io/flux/get-started/)

    [Argo Rollouts Demo](https://rollouts-demo.argoproj.io/)

- 💻 __Real Code__

    ______________________________________________________________________

    [Awesome GitOps](https://github.com/weaveworks/awesome-gitops)

    [ArgoCD Examples](https://github.com/argoproj/argocd-example-apps)

    [Flux Examples](https://github.com/fluxcd/flux2-kustomize-helm-example)

    [ArgoCD Autopilot](https://github.com/argoproj-labs/argocd-autopilot)

- 🔥 __Deep Dives__

    ______________________________________________________________________

    [GitOps Guide (Codefresh)](https://codefresh.io/learn/gitops/)

    [Akuity Blog](https://akuity.io/blog/)

    [Weaveworks Blog](https://www.weave.works/blog/)

    [Flux Repository Patterns](https://fluxcd.io/flux/guides/repository-structure/)

- 🛠️ __Tools & Extensions__

    ______________________________________________________________________

    [Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets)

    [External Secrets](https://external-secrets.io/)

    [Flagger (Progressive Delivery)](https://flagger.app/)

    [Argo Rollouts](https://argoproj.github.io/argo-rollouts/)

    [ArgoCD Image Updater](https://argocd-image-updater.readthedocs.io/)

- 📰 __News & Updates__

    ______________________________________________________________________

    [ArgoCD Releases](https://github.com/argoproj/argo-cd/releases)

    [Flux Releases](https://github.com/fluxcd/flux2/releases)

    [CNCF Blog #gitops](https://www.cncf.io/blog/)

    [The New Stack GitOps](https://thenewstack.io/gitops/)

</div>

______________________________________________________________________

## Best Practices (That Actually Matter)

### Security

**Secrets Management:**

```bash
# ❌ NEVER commit plain secrets
apiVersion: v1
kind: Secret
data:
  password: cGFzc3dvcmQxMjM=  # base64 != encryption

# ✅ Use Sealed Secrets (encrypted at rest)
apiVersion: bitnami.com/v1alpha1
kind: SealedSecret
metadata:
  name: mysecret
spec:
  encryptedData:
    password: AgBi8... # Actually encrypted

# ✅ Or External Secrets (fetch from vault)
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: example
spec:
  secretStoreRef:
    name: vault-backend
  target:
    name: mysecret
  data:
  - secretKey: password
    remoteRef:
      key: secret/data/myapp
      property: password
```

**RBAC:**

- Principle of least privilege (always)
- ArgoCD Projects for multi-tenancy
- Flux impersonation for true RBAC
- Separate repos = separate access control

**Repository Security:**

- Private repos only (public = leaked configs)
- Branch protection on main
- Signed commits (optional but recommended)
- Webhook secrets for repo access

### Repository Structure

**Monorepo (recommended for small/medium):**

- Single source of truth
- Easy to manage
- Folders for environments
- Kustomize overlays for DRY

**Multi-repo (needed for large/enterprise):**

- Separate platform/apps repos
- Team boundaries = repo boundaries
- More granular access control
- More complex to orchestrate

**Anti-patterns:**

- Using Git branches for environments (folders instead)
- Mixing application code + K8s manifests (separate repos)
- No separation of concerns (organize by lifecycle)

### Deployment Strategies

**Progressive Delivery:**

```yaml
# Argo Rollouts - Canary with analysis
apiVersion: argoproj.io/v1alpha1
kind: Rollout
spec:
  strategy:
    canary:
      steps:
      - setWeight: 20
      - pause: {duration: 5m}
      - setWeight: 50
      - pause: {duration: 5m}
      - analysis:
          templates:
          - templateName: success-rate
      - setWeight: 80
      - pause: {duration: 5m}
```

**Blue-Green:**

- Full environment swap
- Zero-downtime deployments
- Easy rollback (flip traffic back)
- 2x resource cost (temporarily)

**Canary:**

- Gradual traffic shift
- Metrics-driven progression
- Automatic rollback on errors
- Lower risk than big bang

### Operations

**Monitoring & Alerts:**

- Sync status alerts (ArgoCD/Flux)
- Git commit → deployment latency
- Failed reconciliation alerts
- Drift detection notifications

**Disaster Recovery:**

```bash
# Rebuild cluster from Git (the beauty of GitOps)
# 1. Fresh cluster
# 2. Install ArgoCD/Flux
# 3. Point to Git repo
# 4. Wait for sync
# 5. Everything's back

# ArgoCD bootstrap
kubectl apply -n argocd -f bootstrap-app.yaml

# Flux bootstrap
flux bootstrap github --owner=org --repository=fleet-infra
```

**Image Updates:**

- Automated image updates = noisy Git history
- Use ArgoCD Image Updater or Flux Image Automation
- Tag patterns (semver, regex)
- Separate PR for each update (reviewable)

______________________________________________________________________

## When NOT to Use GitOps

**Real talk scenarios:**

❌ **You're not on Kubernetes**

- GitOps shines with K8s reconciliation loops
- Terraform + Atlantis better for cloud infra
- VM deployments = traditional CD simpler

❌ **Your team doesn't do code review**

- GitOps = every change reviewed in Git
- No PR discipline = no GitOps benefits
- Fix your Git workflow first

❌ **Compliance requires manual approval gates**

- GitOps = automatic sync
- Manual approval = human in the loop
- Some orgs mandate this (can't GitOps around it)

❌ **You need instant deployments**

- GitOps sync delay: 1-3 minutes
- Not instant like kubectl apply
- For emergency hotfixes, manual override acceptable

❌ **Small project / prototype**

- Vercel, Netlify, Railway easier
- GitOps overhead not worth it
- Save it for production systems

❌ **Secret management is unsolved**

- Don't GitOps until secrets sorted
- Sealed Secrets or External Secrets first
- Never commit plain secrets (seriously)

______________________________________________________________________

## The Real Vibe

**What works:**

- Declarative everything (no kubectl cowboys)
- Audit trail for free (git log)
- Self-healing clusters (drift correction)
- Disaster recovery = git clone
- Security win (no CI cluster access)

**What sucks:**

- Initial complexity (learning curve)
- Repository structure bikeshedding
- Merge conflicts with automation
- Secrets management (external tools required)
- Sync delays (not instant)

**The truth:** GitOps is the best worst way to manage Kubernetes. It forces discipline (good), creates Git noise (annoying), and makes your infra auditable (priceless). The 3 AM production incident is still going to happen, but at least you'll know exactly which commit caused it and can `git revert` your way out.

Once you go GitOps, you can't go back. Manual kubectl feels like cowboy coding. CI/CD pushing to prod feels reckless. And when everything's in Git, the paranoia of "what if GitHub goes down" kicks in (they have 99.99% SLA, you're probably fine).

______________________________________________________________________

**Last Updated:** 2026-01-14 **Vibe Check:** 🔥 Hyped - GitOps is the current best practice for K8s CD. ArgoCD and Flux dominate. Every cloud-native shop either uses it or plans to. The hype is justified—declarative infra + Git audit trail + automatic reconciliation solves real problems. But the learning curve is real, and if you fuck up RBAC you'll lock yourself out. 10/10 would GitOps again.
