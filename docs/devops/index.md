---
title: DevOps
description: DevOps - CI/CD, automation, GitOps, and the eternal quest to automate yourself out of a job while somehow having more work than ever
tags:
  - devops
  - cicd
  - automation
  - gitops
  - ansible
---

# DevOps

You build it, you run it. Sounds great until the pager goes off at 2 AM because someone merged to main on Friday at 4:45 PM. Automate everything, then automate the automation. YAML all the way down. The intersection of development and operations where velocity meets chaos meets kubectl apply.

!!! abstract "What You'll Find Here"
    - CI/CD with GitHub Actions, GitLab CI, and Jenkins
    - GitOps - ArgoCD and FluxCD for Kubernetes delivery
    - Ansible for configuration management
    - Pre-commit hooks to catch disasters before they happen
    - Claude Code for AI-assisted chaos
    - Azure DevOps for Microsoft shops
    - Best practices from production war stories

---

## Quick Navigation

<div class="grid cards" markdown>

- 🔄 **[CI/CD](cicd.md)**

    ---

    GitHub Actions, GitLab CI, Jenkins. Build, test, deploy. The pipeline that breaks at the worst possible moment.

- 🔀 **[GitOps](gitops.md)**

    ---

    Git as single source of truth. ArgoCD, FluxCD. Because what could go wrong when production depends on merge requests?

- ⚙️ **[Ansible](ansible.md)**

    ---

    Configuration management via SSH. YAML playbooks, idempotent tasks, and the occasional "works on my inventory."

- 🪝 **[Pre-Commit](pre-commit.md)**

    ---

    Git hooks that stop you from committing secrets, broken code, and regret. Your last line of defense.

- 🤖 **[Claude Code](claude-code.md)**

    ---

    AI pair programmer that writes code faster than you can regret it. Anthropic's CLI assistant.

- 🔷 **[Azure DevOps](azure-devops.md)**

    ---

    Microsoft's all-in-one platform. Repos, pipelines, boards, artifacts. Enterprise DevOps with enterprise complexity.

</div>

---

## The DevOps Stack

```
┌─────────────────────────────────────┐
│  Monitor & Alert (When It Breaks)  │
├─────────────────────────────────────┤
│  GitOps/CD (ArgoCD, FluxCD)         │
├─────────────────────────────────────┤
│  Deploy (K8s, Cloud, Servers)       │
├─────────────────────────────────────┤
│  CI Pipeline (Build, Test, Scan)    │
├─────────────────────────────────────┤
│  Pre-Commit (Last Chance Saloon)    │
├─────────────────────────────────────┤
│  Version Control (Git)              │
├─────────────────────────────────────┤
│  Config Management (Ansible)        │
├─────────────────────────────────────┤
│  Development (IDE, Local, AI)       │
└─────────────────────────────────────┘
```

---

## Learning Path

### Foundation (0-6 months)
1. **Git mastery** - Not just commit/push. Learn rebase, interactive staging, bisect
2. **CI/CD basics** - GitHub Actions workflow, understand build → test → deploy
3. **Linux command line** - You'll live in the terminal. Get comfortable
4. **YAML syntax** - It's everywhere. Learn to love (or tolerate) indentation
5. **Docker basics** - Build images, understand layers, run containers

### Intermediate (6-18 months)
1. **Advanced CI/CD** - Matrix builds, caching strategies, secrets management
2. **GitOps patterns** - ArgoCD or FluxCD, understand pull vs push
3. **Ansible playbooks** - Server provisioning, app deployment, idempotency
4. **Kubernetes fundamentals** - Pods, services, deployments, the YAML mountain
5. **Monitoring basics** - Prometheus, Grafana, understand what "observability" means

### Advanced (18+ months)
1. **Platform engineering** - Build internal developer platforms, self-service infrastructure
2. **Multi-cluster K8s** - Fleet management, federation, the real complexity
3. **Advanced GitOps** - Progressive delivery, canary deployments, rollback strategies
4. **SRE practices** - SLIs, SLOs, error budgets, blameless post-mortems
5. **Security automation** - SAST, DAST, supply chain security, SBOM generation

---

## Tool Comparison

| Category | Popular Choice | Alternative | Legacy/Enterprise | Reality Check |
|----------|---------------|-------------|-------------------|---------------|
| **CI/CD** | GitHub Actions | GitLab CI | Jenkins | Actions if you're on GitHub, GitLab CI is underrated, Jenkins haunts enterprises |
| **GitOps** | ArgoCD | FluxCD | Spinnaker | ArgoCD has the UI, Flux is lighter, both beat traditional CD |
| **Config Mgmt** | Ansible | Terraform | Puppet/Chef | Ansible for servers, Terraform for cloud, Puppet still exists somehow |
| **Container Registry** | GitHub CR | Docker Hub | Harbor | GitHub CR is free and fast, Docker Hub rate limits, Harbor for self-hosted |
| **Monitoring** | Prometheus | Datadog | New Relic | Prometheus is standard, Datadog if you have budget, New Relic for legacy |
| **Secrets** | Sealed Secrets | External Secrets | HashiCorp Vault | Sealed Secrets is simplest, External Secrets most flexible, Vault most complex |

---

## Related Sections

!!! info "Expand Your Skills"
    - **[Containerization](../containerization/)** - Docker and Kubernetes, where your pipelines deploy to
    - **[Cloud](../cloud/)** - AWS, Azure, GCP - the infrastructure you automate
    - **[Security](../security/)** - Security in CI/CD, supply chain attacks, secrets in Git
    - **[Tools](../tools/)** - Automation and productivity tools

---

## Community & Resources

### 🐦 Follow These
- **r/devops** - 300k+ members, war stories and "it works on my machine"
- **CNCF Slack** - #gitops, #argo, #flux channels
- **DevOps Discord servers** - Active real-time discussions
- **Dev.to #devops** - Tutorials that may or may not work

### 📚 Essential Reading
- **The Phoenix Project** - DevOps as a novel. Actually good
- **The DevOps Handbook** - Comprehensive but dry
- **Site Reliability Engineering** - Google's SRE book, free online
- **Accelerate** - Research-backed DevOps metrics (DORA)

### 🎙️ Podcasts & Newsletters
- **DevOps Weekly** - Newsletter, curated news
- **GitOps Working Group** - CNCF updates
- **Kubernetes Podcast** - Weekly K8s and cloud-native news
- **The Changelog** - Developer tools and workflows

### 🎓 Certifications Worth It
- **GitHub Actions Certification** - Free, worth it if you use Actions
- **CKA (Kubernetes Administrator)** ($395) - Hands-on, respected
- **Terraform Associate** ($70) - Good for IaC roles
- **Skip**: Most vendor DevOps certs unless employer pays

---

## Best Practices

!!! success "Core Principles"
    1. **Automate ruthlessly** - Do it twice, script it. Do it three times, pipeline it
    2. **Shift left on everything** - Security, testing, quality - catch it before prod
    3. **Trunk-based development** - Short-lived branches, frequent merges, less pain
    4. **Fast feedback loops** - CI should finish in minutes, not hours
    5. **Immutable infrastructure** - Build containers, not snowflake servers
    6. **Everything as code** - Infrastructure, configuration, policies, documentation
    7. **Secret management** - Never commit secrets. Use vaults, OIDC, or cry later
    8. **Monitor your pipelines** - Track build times, failure rates, flaky tests
    9. **Progressive delivery** - Canary releases, not YOLO to production
    10. **Blameless post-mortems** - Learn from failures, improve systems, not blame people

---

**Last Updated:** 2026-01-14
**Vibe Check:** 🌍 **Mainstream** - DevOps is the default now. Everyone's hiring, tools keep improving. GitHub Actions dominates greenfield, Jenkins haunts enterprises. GitOps is the new standard for K8s. Platform engineering is DevOps 2.0. The pager still goes off at 2 AM. Some things never change.
