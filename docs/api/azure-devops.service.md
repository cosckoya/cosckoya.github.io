---
title: Azure DevOps
description: Azure DevOps services — Pipelines, Repos, Boards, and Artifacts for CI/CD, with YAML pipelines for API deployment
---

# :material-microsoft-azure-devops: Azure DevOps

Microsoft's end-to-end DevOps platform: Repos for source, Pipelines for CI/CD, Boards for tracking, Artifacts for packages. Heavier than GitHub Actions but built for enterprise scale with deeply integrated Azure deployments. The YAML pipelines are the modern way — skip the classic build definitions unless you're maintaining legacy work.

!!! tip "2026 Update"
    Azure DevOps is mature and stable. GitHub Actions remains the trendier choice for new projects, but Azure Pipelines still wins where Azure AD / enterprise governance and Azure-specific deployment depth matter.

---

## Quick Hits

=== ":lucide-list-check: Essential Commands"

    ```bash
    # Install the Azure DevOps CLI extension
    az extension add --name azure-devops

    # Sign in and set the org/project context
    az devops login
    az devops configure --defaults organization=https://dev.azure.com/yourorg project=YourProject

    # List pipelines
    az pipelines list

    # Run a pipeline by name
    az pipelines run --name api-deploy
    ```

    **Real talk:**
    - The CLI is fine for scripting, but most day-to-day work is in the web UI
    - `az devops configure` once per machine saves you flags everywhere
    - Classic pipelines (build/release) still exist — don't create new ones

=== ":lucide-bolt: Common Patterns"

    ```yaml
    # azure-pipelines.yml — build + deploy a Python API
    trigger:
      branches:
        include: [main]

    pool:
      vmImage: "ubuntu-latest"

    variables:
      pythonVersion: "3.14"

    steps:
      - task: UsePythonVersion@0
        inputs:
          versionSpec: "$(pythonVersion)"

      - script: |
          python -m venv venv
          source venv/bin/activate
          pip install -r requirements.txt
          pip install pytest httpx
          pytest
        displayName: "Test"

      - task: PublishBuildArtifacts@1
        inputs:
          pathToPublish: "$(Build.ArtifactStagingDirectory)"
          artifactName: "api"
    ```

    **Why this works:**
    - YAML pipelines are version-controlled alongside your code — reviewable like code
    - `UsePythonVersion@0` handles interpreter selection
    - Publish artifacts so release stages can consume the tested build

=== ":material-fire: Pro Tips & Gotchas"

    **Tips:**
    - Gate deployments with **environments** and approvals (classic release gates are legacy)
    - Use **Azure Artifacts** feeds for private packages — better cache than raw blob storage
    - Structure as one pipeline with `stages:` (build → test → deploy) instead of separate releases

    **Gotchas:**
    - Pricing: free tier gives 1,800 minutes/month; self-hosted agents are free but your problem
    - Service connections (`Azure Resource Manager`) are the auth model — set them up once, reuse everywhere
    - `vmImage: ubuntu-latest` changes under you; pin `ubuntu-24.04` if reproducibility matters

---

## Reference

**Documentation:**

- :lucide-book: [Azure DevOps Docs](https://learn.microsoft.com/en-us/azure/devops/)
- :lucide-book: [YAML Pipeline Reference](https://learn.microsoft.com/en-us/azure/devops/pipelines/yaml-schema/)
- :material-microsoft-azure: [Azure Portal](https://portal.azure.com/)

**Related:**

- :simple-fastapi: __Python API Development__ — the API these pipelines deploy
- :lucide-shield-check: __Spectral__ — add contract linting as a pipeline step

---

**Last Updated:** 2026-08-20 | **Vibe Check:** :material-microsoft-azure-devops: **Enterprise Standard** - Azure DevOps is the go-to when you're already living inside Microsoft's ecosystem.

**Tags:** devops, azure, ci-cd