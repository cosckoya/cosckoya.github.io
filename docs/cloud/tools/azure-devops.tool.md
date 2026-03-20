---
title: Azure DevOps
description: Microsoft's DevOps platform - pipelines, repos, boards, artifacts, test plans, enterprise focus
---

# :fontawesome-brands-microsoft: Azure DevOps

Microsoft's enterprise DevOps platform. Pipelines for CI/CD, Repos for git, Boards for work tracking, Artifacts for packages, Test Plans for QA. Better for Windows/.NET shops, more features than GitHub for enterprise workflows.

!!! tip "2026 Update"
    Azure Pipelines supports GitHub integration natively. Multi-stage YAML pipelines are standard. Artifact feeds now include npm, NuGet, Maven, Python. Boards integrate with Microsoft Teams. Free tier includes 1800 pipeline minutes/month.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # Azure DevOps CLI (az devops)
    az devops configure --defaults organization=https://dev.azure.com/myorg project=MyProject

    # Pipelines
    az pipelines create --name MyPipeline --yml-path azure-pipelines.yml  # (1)!
    az pipelines list
    az pipelines run --name MyPipeline
    az pipelines runs list
    az pipelines show --id 123

    # Repos
    az repos list
    az repos create --name MyRepo
    az repos policy list --branch main  # (2)!

    # Pull requests
    az repos pr create --title "Feature" --source-branch feature --target-branch main
    az repos pr list
    az repos pr update --id 456 --status completed

    # Boards (work items)
    az boards work-item create --title "Bug fix" --type Bug
    az boards work-item show --id 789
    az boards work-item update --id 789 --state Resolved

    # Artifacts (package feeds)
    az artifacts universal publish \
      --organization https://dev.azure.com/myorg \
      --project MyProject \
      --scope project \
      --feed MyFeed \
      --name MyPackage \
      --version 1.0.0 \
      --path ./dist  # (3)!

    # Service connections (for deployments)
    az devops service-endpoint create \
      --service-endpoint-type azurerm \
      --name MyAzureConnection
    ```

    1. Creates pipeline from YAML file in repo
    2. Branch policies enforce PR reviews, build validation
    3. Universal packages for any file type (not just npm/nuget)

    **Real talk:**

    - Azure Pipelines beats GitHub Actions for complex enterprise workflows
    - Free tier: 1 parallel job, 1800 minutes/month (more generous than GitHub)
    - Self-hosted agents avoid cloud costs (Linux, Windows, macOS)
    - Boards integration with work items better than GitHub Projects
    - YAML pipelines required (classic UI pipelines deprecated)

=== ":fontawesome-solid-bolt: Common Patterns"

    ```yaml
    # Azure Pipelines YAML (azure-pipelines.yml)
    trigger:
      branches:
        include:
          - main
          - develop
      paths:
        exclude:
          - docs/*  # (1)!

    pool:
      vmImage: 'ubuntu-latest'  # (2)!

    variables:
      buildConfiguration: 'Release'

    stages:
      - stage: Build
        jobs:
          - job: BuildJob
            steps:
              - task: UseDotNet@2
                inputs:
                  version: '8.x'

              - task: DotNetCoreCLI@2
                displayName: 'dotnet restore'
                inputs:
                  command: restore
                  projects: '**/*.csproj'

              - task: DotNetCoreCLI@2
                displayName: 'dotnet build'
                inputs:
                  command: build
                  projects: '**/*.csproj'
                  arguments: '--configuration $(buildConfiguration)'

              - task: DotNetCoreCLI@2
                displayName: 'dotnet test'
                inputs:
                  command: test
                  projects: '**/*Tests.csproj'
                  arguments: '--configuration $(buildConfiguration) --collect:"XPlat Code Coverage"'

              - task: PublishCodeCoverageResults@1  # (3)!
                inputs:
                  codeCoverageTool: 'Cobertura'
                  summaryFileLocation: '$(Agent.TempDirectory)/**/*.cobertura.xml'

              - task: DotNetCoreCLI@2
                displayName: 'dotnet publish'
                inputs:
                  command: publish
                  publishWebProjects: true
                  arguments: '--configuration $(buildConfiguration) --output $(Build.ArtifactStagingDirectory)'

              - publish: $(Build.ArtifactStagingDirectory)  # (4)!
                artifact: drop

      - stage: Deploy
        dependsOn: Build
        condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))  # (5)!
        jobs:
          - deployment: DeployJob
            environment: 'Production'  # (6)!
            strategy:
              runOnce:
                deploy:
                  steps:
                    - download: current
                      artifact: drop

                    - task: AzureWebApp@1
                      inputs:
                        azureSubscription: 'MyAzureConnection'
                        appName: 'my-web-app'
                        package: '$(Pipeline.Workspace)/drop/**/*.zip'
    ```

    1. Skip CI builds for documentation changes
    2. Microsoft-hosted agents: ubuntu-latest, windows-latest, macos-latest
    3. Code coverage reports integrated into Azure DevOps UI
    4. Publish artifacts for use in deployment stages
    5. Deploy only on main branch after successful build
    6. Environment with approval gates and deployment history

    ```yaml
    # Multi-stage pipeline with templates
    # File: azure-pipelines.yml
    trigger:
      - main

    stages:
      - template: templates/build.yml
        parameters:
          buildConfiguration: 'Release'

      - template: templates/deploy.yml
        parameters:
          environment: 'Staging'

      - template: templates/deploy.yml
        parameters:
          environment: 'Production'

    # File: templates/build.yml
    parameters:
      - name: buildConfiguration
        type: string
        default: 'Release'

    stages:
      - stage: Build
        jobs:
          - job: BuildJob
            steps:
              - script: echo "Building with ${{ parameters.buildConfiguration }}"
              # ... build steps
    ```

    **Why this works:**

    - Multi-stage pipelines with approval gates for production
    - Templates reduce duplication across pipelines
    - Artifacts persist between stages (build once, deploy many)
    - Environment tracking shows deployment history
    - Integration with Azure services (App Service, AKS, Functions)

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **YAML pipelines only** - Classic UI pipelines deprecated
        - **Pipeline templates** - Reuse common steps across pipelines
        - **Variable groups** - Share secrets across multiple pipelines
        - **Service connections** - Scoped credentials for Azure/AWS/K8s
        - **Environments** - Approval gates, deployment history
        - **Branch policies** - Require PR reviews, build validation, work item linking
        - **Artifact feeds** - Upstream sources (npmjs, nuget.org) with caching

    !!! warning "Security"
        - **Service connections** - Limit scope to specific resource groups
        - **Variable groups** - Mark sensitive values as secret
        - **Branch protection** - Require PR reviews, prevent force-push
        - **Pipeline permissions** - Limit which pipelines can use service connections
        - **Agent pools** - Self-hosted agents need security hardening
        - **Audit logs** - Track who changed what in organization settings

    !!! tip "Performance"
        - **Self-hosted agents** - Faster for large repos, avoid queue time
        - **Parallel jobs** - Free tier: 1 parallel job, paid: unlimited
        - **Artifact caching** - Cache npm/nuget packages between runs
        - **Shallow clone** - Reduce checkout time with `fetchDepth: 1`
        - **Matrix strategy** - Test multiple configurations in parallel

    !!! danger "Gotchas"
        - **YAML syntax** - Indentation errors common (use VS Code extension)
        - **Pipeline minutes** - 1800 free/month, then $40/parallel job/month
        - **Service connection expiry** - Azure service principals expire (renew annually)
        - **Classic pipelines** - Don't use (deprecated, YAML only)
        - **Work item linking** - Required by default in branch policies (configure exceptions)
        - **Artifact retention** - Default 30 days, configure longer for releases
        - **Cross-org PRs** - Not supported (unlike GitHub forks)

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Resources

### :fontawesome-solid-book-open: Official Docs

- **[Azure DevOps Documentation](https://docs.microsoft.com/en-us/azure/devops/)** - Complete reference
- **[Azure Pipelines YAML Schema](https://docs.microsoft.com/en-us/azure/devops/pipelines/yaml-schema)** - Syntax reference
- **[Azure DevOps CLI](https://docs.microsoft.com/en-us/azure/devops/cli/)** - Command-line reference

### :fontawesome-solid-rocket: Key Components

- **Azure Pipelines** - CI/CD with YAML or classic (use YAML)
- **Azure Repos** - Git repositories with branch policies
- **Azure Boards** - Work tracking (Agile, Scrum, CMMI templates)
- **Azure Artifacts** - Package feeds (npm, NuGet, Maven, Python, universal)
- **Azure Test Plans** - Manual and exploratory testing (requires paid license)

______________________________________________________________________

## :fontawesome-solid-star: Related Tools

- **[Azure CLI with DevOps extension](https://docs.microsoft.com/en-us/azure/devops/cli/)** - Command-line automation
- **[Azure Pipelines VS Code extension](https://marketplace.visualstudio.com/items?itemName=ms-azure-devops.azure-pipelines)** - YAML IntelliSense
- **[Azure Repos VS Code extension](https://marketplace.visualstudio.com/items?itemName=ms-vsts.team)** - Git integration

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-building: **Enterprise Choice** - Better than GitHub for large organizations with complex workflows. Strong Azure integration. Boards more powerful than GitHub Projects. Free tier generous. UI less polished than GitHub.

**Tags:** azure-devops, devops, ci-cd, microsoft, pipelines
