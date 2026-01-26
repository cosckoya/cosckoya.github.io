# Azure DevOps

Microsoft's comprehensive DevOps platform providing services for the entire application lifecycle.

______________________________________________________________________

## Overview

### What is Azure DevOps?

Azure DevOps is Microsoft's cloud-based DevOps platform offering integrated services for planning, developing, delivering, and operating applications. It provides both cloud-hosted (Azure DevOps Services) and on-premises (Azure DevOps Server) options.

**Key Services:**

- 📋 **Azure Boards** - Work tracking with Kanban boards, backlogs, and sprints
- 📦 **Azure Repos** - Git repositories with pull requests and code review
- 🔧 **Azure Pipelines** - CI/CD with support for any platform, language, or cloud
- 🧪 **Azure Test Plans** - Manual and exploratory testing tools
- 📦 **Azure Artifacts** - Package management (NuGet, npm, Maven, Python)

### Why Use Azure DevOps?

- ✅ **Complete Platform** - All DevOps services in one place
- ✅ **Enterprise Ready** - Security, compliance, and scalability
- ✅ **Flexible Pricing** - Free tier for small teams (up to 5 users)
- ✅ **Hybrid Deployment** - Cloud or on-premises
- ✅ **Azure Integration** - Native integration with Azure services
- ✅ **Any Platform** - Windows, Linux, macOS, containers

______________________________________________________________________

## Getting Started

### Essential Guides

**Quick Starts:**

- **[Azure DevOps Overview](https://learn.microsoft.com/azure/devops/user-guide/what-is-azure-devops)** - Platform introduction
- **[Sign up for Azure DevOps](https://learn.microsoft.com/azure/devops/user-guide/sign-up-invite-teammates)** - Create free account
- **[Quick Start Guide](https://learn.microsoft.com/azure/devops/get-started/)** - Get started fast

**Service-Specific:**

- **[Azure Boards Quickstart](https://learn.microsoft.com/azure/devops/boards/get-started/)** - Start tracking work
- **[Azure Repos Quickstart](https://learn.microsoft.com/azure/devops/repos/get-started/)** - Set up Git repos
- **[Azure Pipelines Quickstart](https://learn.microsoft.com/azure/devops/pipelines/get-started/)** - Create first pipeline

______________________________________________________________________

## Core Services

### Azure Boards

Work tracking and project management:

- **[Azure Boards Documentation](https://learn.microsoft.com/azure/devops/boards/)** - Complete guide
- **[Backlogs](https://learn.microsoft.com/azure/devops/boards/backlogs/)** - Prioritize work
- **[Sprints](https://learn.microsoft.com/azure/devops/boards/sprints/)** - Sprint planning
- **[Kanban Boards](https://learn.microsoft.com/azure/devops/boards/boards/)** - Visualize workflow
- **[Queries](https://learn.microsoft.com/azure/devops/boards/queries/)** - Custom work item queries

### Azure Repos

Git version control:

- **[Azure Repos Documentation](https://learn.microsoft.com/azure/devops/repos/)** - Complete guide
- **[Git Repos](https://learn.microsoft.com/azure/devops/repos/git/)** - Git workflows
- **[Pull Requests](https://learn.microsoft.com/azure/devops/repos/git/pull-requests)** - Code review
- **[Branch Policies](https://learn.microsoft.com/azure/devops/repos/git/branch-policies)** - Protect branches
- **[TFVC](https://learn.microsoft.com/azure/devops/repos/tfvc/)** - Team Foundation Version Control (legacy)

### Azure Pipelines

CI/CD automation:

- **[Azure Pipelines Documentation](https://learn.microsoft.com/azure/devops/pipelines/)** - Complete guide
- **[YAML Schema](https://learn.microsoft.com/azure/devops/pipelines/yaml-schema/)** - Pipeline syntax
- **[Build Pipelines](https://learn.microsoft.com/azure/devops/pipelines/create-first-pipeline)** - CI workflows
- **[Release Pipelines](https://learn.microsoft.com/azure/devops/pipelines/release/)** - CD workflows
- **[Agents](https://learn.microsoft.com/azure/devops/pipelines/agents/agents)** - Microsoft-hosted and self-hosted
- **[Templates](https://learn.microsoft.com/azure/devops/pipelines/process/templates)** - Reusable pipelines

### Azure Test Plans

Testing tools:

- **[Azure Test Plans Documentation](https://learn.microsoft.com/azure/devops/test/)** - Complete guide
- **[Manual Testing](https://learn.microsoft.com/azure/devops/test/manual-test)** - Exploratory testing
- **[Test Plans](https://learn.microsoft.com/azure/devops/test/create-a-test-plan)** - Organize tests
- **[Test Cases](https://learn.microsoft.com/azure/devops/test/create-test-cases)** - Define test scenarios

### Azure Artifacts

Package management:

- **[Azure Artifacts Documentation](https://learn.microsoft.com/azure/devops/artifacts/)** - Complete guide
- **[Feeds](https://learn.microsoft.com/azure/devops/artifacts/concepts/feeds)** - Package repositories
- **[Supported Packages](https://learn.microsoft.com/azure/devops/artifacts/start-using-azure-artifacts)** - NuGet, npm, Maven, Python, Universal
- **[Upstream Sources](https://learn.microsoft.com/azure/devops/artifacts/concepts/upstream-sources)** - Public registries proxy

______________________________________________________________________

## Key Features

### Integrations

**Azure Services:**

- Azure App Service, Azure Functions, AKS
- Azure Key Vault (secrets management)
- Azure Monitor (observability)

**Third-Party:**

- **[GitHub Integration](https://learn.microsoft.com/azure/devops/pipelines/repos/github)** - Build from GitHub repos
- **[Slack](https://learn.microsoft.com/azure/devops/service-hooks/services/slack)** - Notifications
- **[Teams](https://learn.microsoft.com/azure/devops/boards/integrations/boards-teams)** - Microsoft Teams integration
- **[Marketplace](https://marketplace.visualstudio.com/azuredevops)** - Extensions and integrations

### Security & Compliance

- **[Security Overview](https://learn.microsoft.com/azure/devops/organizations/security/)** - Security features
- **[Permissions](https://learn.microsoft.com/azure/devops/organizations/security/permissions)** - Access control
- **[Service Connections](https://learn.microsoft.com/azure/devops/pipelines/library/service-endpoints)** - Secure connections
- **[Audit Logs](https://learn.microsoft.com/azure/devops/organizations/audit/azure-devops-auditing)** - Track changes

______________________________________________________________________

## Azure CLI & REST API

### Azure DevOps CLI

Command-line interface:

```bash
# Install Azure CLI extension
az extension add --name azure-devops

# Login
az login

# Set default organization and project
az devops configure --defaults organization=https://dev.azure.com/myorg project=myproject
```

**Documentation:**

- **[Azure DevOps CLI](https://learn.microsoft.com/cli/azure/devops)** - CLI reference
- **[az pipelines](https://learn.microsoft.com/cli/azure/pipelines)** - Pipeline commands
- **[az repos](https://learn.microsoft.com/cli/azure/repos)** - Repository commands

### REST API

Programmatic access:

- **[REST API Reference](https://learn.microsoft.com/rest/api/azure/devops/)** - Complete API docs
- **[Authentication](https://learn.microsoft.com/azure/devops/integrate/get-started/authentication/authentication-guidance)** - API authentication
- **[PAT Tokens](https://learn.microsoft.com/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate)** - Personal access tokens

______________________________________________________________________

## Best Practices

**Project Organization:**

- Use organizations for company-wide management
- Create projects for related work
- Structure repos by application/service
- Use shared pipelines via templates

**CI/CD:**

- Use YAML pipelines (infrastructure as code)
- Implement branch policies for main branches
- Use environment approvals for production
- Cache dependencies to speed up builds
- Use self-hosted agents for special requirements

**Security:**

- Enable branch policies with required reviewers
- Use service connections for external resources
- Store secrets in Azure Key Vault
- Regular audit log reviews
- Least privilege access model

**Learn More:**

- **[Best Practices Guide](https://learn.microsoft.com/azure/devops/pipelines/build/best-practices)** - Official recommendations

______________________________________________________________________

## Resources & Links

### 🏠 Official

- **[Azure DevOps](https://azure.microsoft.com/services/devops/)** - Product page
- **[Azure DevOps Services](https://dev.azure.com/)** - Cloud platform
- **[Documentation](https://learn.microsoft.com/azure/devops/)** - Complete docs
- **[Blog](https://devblogs.microsoft.com/devops/)** - Official blog
- **[Roadmap](https://learn.microsoft.com/azure/devops/release-notes/)** - Release notes
- **[Status Page](https://status.dev.azure.com/)** - Service status

### 📚 Documentation

- **[Get Started Guide](https://learn.microsoft.com/azure/devops/get-started/)** - Quick start
- **[Azure Boards](https://learn.microsoft.com/azure/devops/boards/)** - Work tracking
- **[Azure Repos](https://learn.microsoft.com/azure/devops/repos/)** - Version control
- **[Azure Pipelines](https://learn.microsoft.com/azure/devops/pipelines/)** - CI/CD
- **[Azure Test Plans](https://learn.microsoft.com/azure/devops/test/)** - Testing
- **[Azure Artifacts](https://learn.microsoft.com/azure/devops/artifacts/)** - Packages
- **[Security Guide](https://learn.microsoft.com/azure/devops/organizations/security/)** - Security features

### 🎓 Learning

- **[Azure DevOps Labs](https://azuredevopslabs.com/)** - Hands-on labs
- **[Microsoft Learn](https://learn.microsoft.com/training/browse/?products=azure-devops)** - Free courses
- **[Pluralsight](https://www.pluralsight.com/paths/azure-devops-engineer)** - Learning paths
- **[LinkedIn Learning](https://www.linkedin.com/learning/search?keywords=azure%20devops)** - Video courses

### 💻 Tools & CLI

- **[Azure DevOps CLI](https://learn.microsoft.com/cli/azure/devops)** - Command-line interface
- **[REST API](https://learn.microsoft.com/rest/api/azure/devops/)** - API reference
- **[VS Code Extension](https://marketplace.visualstudio.com/items?itemName=ms-azure-devops.azure-pipelines)** - IDE integration
- **[Power BI Integration](https://learn.microsoft.com/azure/devops/report/powerbi/)** - Analytics

### 👥 Community

- **[Developer Community](https://developercommunity.visualstudio.com/spaces/21/index.html)** - Q&A forum
- **[Stack Overflow](https://stackoverflow.com/questions/tagged/azure-devops)** - Q&A with azure-devops tag
- **[r/azuredevops](https://reddit.com/r/azuredevops)** - Reddit community
- **[Twitter](https://twitter.com/azuredevops)** - Official updates

### 🛠️ Marketplace

- **[Azure DevOps Marketplace](https://marketplace.visualstudio.com/azuredevops)** - Extensions
- **[Pipeline Tasks](https://marketplace.visualstudio.com/search?target=AzureDevOps&category=Azure%20Pipelines&sortBy=Installs)** - CI/CD tasks
- **[Widgets](https://marketplace.visualstudio.com/search?target=AzureDevOps&category=Azure%20Boards&sortBy=Installs)** - Dashboard widgets

______________________________________________________________________

## Related Topics

- **[GitHub](github.md)** - Alternative platform with similar features
- **[GitHub Actions](github-actions.md)** - GitHub's CI/CD solution
- **[Azure Kubernetes Service](../cloud/azure/)** - Deploy to AKS from pipelines

______________________________________________________________________

**Last Updated:** 2026-01-13 **Status:** Active **Maintained by:** DocMaster Agent v2.0
