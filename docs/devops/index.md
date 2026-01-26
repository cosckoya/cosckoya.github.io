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

______________________________________________________________________

## Quick Navigation

<div class="grid cards" markdown>

- 🔄 **[CI/CD](cicd.md)**

    ______________________________________________________________________

    GitHub Actions, GitLab CI, Jenkins. Build, test, deploy. The pipeline that breaks at the worst possible moment.

- 🔀 **[GitOps](gitops.md)**

    ______________________________________________________________________

    Git as single source of truth. ArgoCD, FluxCD. Because what could go wrong when production depends on merge requests?

- ⚙️ **[Ansible](ansible.md)**

    ______________________________________________________________________

    Configuration management via SSH. YAML playbooks, idempotent tasks, and the occasional "works on my inventory."

- 🪝 **[Pre-Commit](pre-commit.md)**

    ______________________________________________________________________

    Git hooks that stop you from committing secrets, broken code, and regret. Your last line of defense.

- 🤖 **[Claude Code](claude-code.md)**

    ______________________________________________________________________

    AI pair programmer that writes code faster than you can regret it. Anthropic's CLI assistant.

- 🔷 **[Azure DevOps](azure-devops.md)**

    ______________________________________________________________________

    Microsoft's all-in-one platform. Repos, pipelines, boards, artifacts. Enterprise DevOps with enterprise complexity.

</div>

______________________________________________________________________

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

______________________________________________________________________

## Learning Path

### Foundation (0-6 months)

1. **Git mastery** - Not just commit/push. Learn rebase, interactive staging, bisect
1. **CI/CD basics** - GitHub Actions workflow, understand build → test → deploy
1. **Linux command line** - You'll live in the terminal. Get comfortable
1. **YAML syntax** - It's everywhere. Learn to love (or tolerate) indentation
1. **Docker basics** - Build images, understand layers, run containers

### Intermediate (6-18 months)

1. **Advanced CI/CD** - Matrix builds, caching strategies, secrets management
1. **GitOps patterns** - ArgoCD or FluxCD, understand pull vs push
1. **Ansible playbooks** - Server provisioning, app deployment, idempotency
1. **Kubernetes fundamentals** - Pods, services, deployments, the YAML mountain
1. **Monitoring basics** - Prometheus, Grafana, understand what "observability" means

### Advanced (18+ months)

1. **Platform engineering** - Build internal developer platforms, self-service infrastructure
1. **Multi-cluster K8s** - Fleet management, federation, the real complexity
1. **Advanced GitOps** - Progressive delivery, canary deployments, rollback strategies
1. **SRE practices** - SLIs, SLOs, error budgets, blameless post-mortems
1. **Security automation** - SAST, DAST, supply chain security, SBOM generation

______________________________________________________________________

## Tool Comparison

| Category               | Popular Choice | Alternative      | Legacy/Enterprise | Reality Check                                                                    |
| ---------------------- | -------------- | ---------------- | ----------------- | -------------------------------------------------------------------------------- |
| **CI/CD**              | GitHub Actions | GitLab CI        | Jenkins           | Actions if you're on GitHub, GitLab CI is underrated, Jenkins haunts enterprises |
| **GitOps**             | ArgoCD         | FluxCD           | Spinnaker         | ArgoCD has the UI, Flux is lighter, both beat traditional CD                     |
| **Config Mgmt**        | Ansible        | Terraform        | Puppet/Chef       | Ansible for servers, Terraform for cloud, Puppet still exists somehow            |
| **Container Registry** | GitHub CR      | Docker Hub       | Harbor            | GitHub CR is free and fast, Docker Hub rate limits, Harbor for self-hosted       |
| **Monitoring**         | Prometheus     | Datadog          | New Relic         | Prometheus is standard, Datadog if you have budget, New Relic for legacy         |
| **Secrets**            | Sealed Secrets | External Secrets | HashiCorp Vault   | Sealed Secrets is simplest, External Secrets most flexible, Vault most complex   |

______________________________________________________________________

## Related Sections

!!! info "Expand Your Skills"

    - **[Containerization](../containerization/)** - Docker and Kubernetes, where your pipelines deploy to
    - **[Cloud](../cloud/)** - AWS, Azure, GCP - the infrastructure you automate
    - **[Security](../security/)** - Security in CI/CD, supply chain attacks, secrets in Git
    - **[Tools](../tools/)** - Automation and productivity tools

______________________________________________________________________

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

______________________________________________________________________

## Best Practices

!!! success "Core Principles"

    1. **Automate ruthlessly** - Do it twice, script it. Do it three times, pipeline it
    1. **Shift left on everything** - Security, testing, quality - catch it before prod
    1. **Trunk-based development** - Short-lived branches, frequent merges, less pain
    1. **Fast feedback loops** - CI should finish in minutes, not hours
    1. **Immutable infrastructure** - Build containers, not snowflake servers
    1. **Everything as code** - Infrastructure, configuration, policies, documentation
    1. **Secret management** - Never commit secrets. Use vaults, OIDC, or cry later
    1. **Monitor your pipelines** - Track build times, failure rates, flaky tests
    1. **Progressive delivery** - Canary releases, not YOLO to production
    1. **Blameless post-mortems** - Learn from failures, improve systems, not blame people

______________________________________________________________________

**Last Updated:** 2026-01-14 **Vibe Check:** 🌍 **Mainstream** - DevOps is the default now. Everyone's hiring, tools keep improving. GitHub Actions dominates greenfield, Jenkins haunts enterprises. GitOps is the new standard for K8s. Platform engineering is DevOps 2.0. The pager still goes off at 2 AM. Some things never change.
