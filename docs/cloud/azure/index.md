---
title: Microsoft Azure
description: Azure reference - Microsoft's cloud, enterprise-focused, Windows-friendly, growing fast
tags:
  - azure
  - cloud
  - microsoft
---

# Microsoft Azure

Microsoft's cloud platform. Second biggest after AWS. Enterprise-friendly with strong Active Directory integration. Windows ecosystem plays nice here. Growing fast, sometimes too fast (service names change constantly).

______________________________________________________________________

## Quick Hits

=== "🎯 Essential Services"

    ```bash
    # Login (interactive)
    az login

    # Virtual Machines
    az vm create --resource-group MyRG --name MyVM --image Ubuntu2204 --size Standard_B2s

    # Storage (Blob = S3 equivalent)
    az storage blob upload --account-name mystorageacct --container-name mycontainer --file local.txt --name remote.txt

    # Functions (serverless)
    az functionapp create --resource-group MyRG --name myfuncapp --runtime python --runtime-version 3.11

    # App Service (PaaS for web apps)
    az webapp create --resource-group MyRG --name mywebapp --plan myappserviceplan

    # SQL Database
    az sql db create --resource-group MyRG --server myserver --name mydb --service-objective S0

    # AKS (Kubernetes)
    az aks create --resource-group MyRG --name myAKSCluster --node-count 3 --enable-addons monitoring

    # Identity check
    az account show
    ```

    **Real talk:**

    - Resource Groups are mandatory for EVERYTHING (annoying but organized)
    - Use `az account list` to manage multiple subscriptions
    - Azure CLI is solid but PowerShell is first-class citizen (if you're into that)
    - Portal UI changes every 6 months (Microsoft gonna Microsoft)
    - West US 2 and East US are cheapest regions usually

=== "⚡ Common Patterns"

    ```python
    from azure.storage.blob import BlobServiceClient
    from azure.identity import DefaultAzureCredential

    # Blob storage upload (S3 equivalent)
    def upload_to_blob(file_path, container_name, blob_name):
        # Use DefaultAzureCredential (handles MSI, CLI, env vars)
        credential = DefaultAzureCredential()
        blob_service = BlobServiceClient(
            account_url="https://mystorageacct.blob.core.windows.net",
            credential=credential
        )

        blob_client = blob_service.get_blob_client(
            container=container_name,
            blob=blob_name
        )

        with open(file_path, "rb") as data:
            blob_client.upload_blob(data, overwrite=True)

    # Azure Function pattern (Python)
    import azure.functions as func
    import logging

    def main(req: func.HttpRequest) -> func.HttpResponse:
        logging.info('Processing request')

        try:
            # Get request data
            req_body = req.get_json()
            name = req_body.get('name')

            # Do work
            result = process_data(name)

            return func.HttpResponse(
                result,
                status_code=200
            )
        except Exception as e:
            logging.error(f"Error: {e}")
            return func.HttpResponse(
                "Internal error",
                status_code=500
            )
    ```

    ```yaml
    # ARM Template (Infrastructure as Code)
    {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "resources": [
        {
          "type": "Microsoft.Storage/storageAccounts",
          "apiVersion": "2021-04-01",
          "name": "mystorageacct",
          "location": "eastus",
          "sku": {
            "name": "Standard_LRS"
          },
          "kind": "StorageV2"
        }
      ]
    }
    ```

    ```hcl
    # Or use Terraform (way better than ARM templates)
    resource "azurerm_storage_account" "example" {
      name                     = "mystorageacct"
      resource_group_name      = azurerm_resource_group.example.name
      location                 = "eastus"
      account_tier             = "Standard"
      account_replication_type = "LRS"
    }
    ```

=== "🔥 Pro Tips & Gotchas"

    **Cost optimization:**

    - Use Azure Reservations for predictable workloads (up to 72% savings)
    - Azure Spot VMs for batch jobs (up to 90% off)
    - Set budget alerts in Cost Management IMMEDIATELY
    - Delete unused resources (stopped VMs still cost money for storage)
    - Use Azure Advisor recommendations (free cost optimization tips)

    **Security:**

    - Use Managed Identities instead of service principals (no credential management)
    - Enable Azure Defender for Cloud (was Security Center, rebranded again)
    - Use Azure Key Vault for secrets (NOT environment variables)
    - Network Security Groups (NSGs) for firewall rules
    - Enable Azure AD MFA for all users (seriously, do it)

    **Performance:**

    - Use Azure CDN for static content
    - Azure Cache for Redis for sub-ms latency
    - Premium storage for production databases
    - Availability Zones for high availability (not all regions have them)

    **Gotchas (Microsoft's special brand of pain):**

    - Service names change constantly (Container Instances → Container Apps → ???)
    - Portal UI changes break muscle memory every quarter
    - Resource naming has strict rules (lowercase, no special chars, etc.)
    - Some services only available in certain regions (check before committing)
    - Egress (outbound) data transfer costs add up fast
    - ARM templates are verbose JSON hell (use Bicep or Terraform instead)
    - Free tier is more limited than AWS (12 months vs AWS's perpetual free tier for some services)

    **Monitoring:**

    - Azure Monitor (included, similar to CloudWatch)
    - Application Insights for app telemetry (pretty good actually)
    - Log Analytics for centralized logging

    **When NOT to use Azure:**

    - You hate Microsoft (fair)
    - No Windows/AD integration needed and AWS has better services for your use case
    - Small personal projects (portal complexity overkill)
    - Team has no Azure experience (AWS has more learning resources)

______________________________________________________________________

## Learning Paths

### 🎓 Free Resources

- **[Microsoft Learn](https://learn.microsoft.com/en-us/training/azure/)** - Official training, tons of free modules (start here)
- **[Azure Free Account](https://azure.microsoft.com/en-us/free/)** - $200 credit for 30 days + 12 months free services
- **[Azure Fundamentals Course](https://www.youtube.com/watch?v=NKEFWyqJ5XA)** - 3+ hour freeCodeCamp course
- **[Azure Documentation](https://learn.microsoft.com/en-us/azure/)** - Official docs (actually decent)
- **[Azure Tips and Tricks](https://microsoft.github.io/AzureTipsAndTricks/)** - Bite-sized tutorials
- **[Azure Citadel](https://azurecitadel.com/)** - Community-driven labs

### 🧪 Interactive Labs

- **[Microsoft Learn Sandbox](https://learn.microsoft.com/en-us/training/)** - Free Azure subscription in browser (no credit card)
- **[Azure Cloud Shell](https://shell.azure.com/)** - Browser-based CLI (Bash or PowerShell)
- **[Azure Quickstart Templates](https://azure.microsoft.com/en-us/resources/templates/)** - Deploy pre-built solutions
- **[Terraform Azure Provider Docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)** - Better than ARM templates

### 📜 Certifications Worth It

- **[AZ-900: Azure Fundamentals](https://learn.microsoft.com/en-us/certifications/azure-fundamentals/)** - $99, easiest, good if totally new to Azure
- **[AZ-104: Azure Administrator](https://learn.microsoft.com/en-us/certifications/azure-administrator/)** - $165, **most popular**, sysadmin/operations focus (this one matters)
- **[AZ-204: Azure Developer](https://learn.microsoft.com/en-us/certifications/azure-developer/)** - $165, for developers building apps on Azure
- **[AZ-305: Azure Solutions Architect](https://learn.microsoft.com/en-us/certifications/azure-solutions-architect/)** - $165, design-focused, intermediate level
- **Skip unless senior:** AZ-500 (Security), specialty certs ($165+) - overkill for most

**Reality check:**

- AZ-104 is the sweet spot for ops/infrastructure roles
- Microsoft certs expire after 1 year (AWS is 3 years) - annoying renewal requirement
- Study 1-2 months, use practice exams
- [Whizlabs](https://www.whizlabs.com/microsoft-azure-certification-courses/) and [MeasureUp](https://www.measureup.com/) for practice tests

### 🚀 Projects to Build

**Beginner (learn the basics):**

- Static website on Blob Storage + Azure CDN
- Serverless API with Azure Functions + Cosmos DB

**Intermediate (portfolio-worthy):**

- Web app with App Service + SQL Database + Redis Cache + Application Insights
- CI/CD pipeline with Azure DevOps (repos, pipelines, artifacts)
- Container app on AKS with Azure Container Registry

**Advanced (job-interview flex):**

- Multi-region app with Traffic Manager + geo-replicated SQL
- Event-driven architecture with Event Grid + Functions + Service Bus
- Infrastructure as Code with Terraform + Azure DevOps pipelines

______________________________________________________________________

## Community Pulse

### 🐦 Who to Follow

**Twitter/X:**

- [@Azure](https://twitter.com/Azure) - Official Azure updates
- [@shanselman](https://twitter.com/shanselman) - Scott Hanselman, Microsoft VP, entertaining + technical
- [@TheMSFTCloud](https://twitter.com/TheMSFTCloud) - Thomas Maurer, Azure expert
- [@jaydestro](https://twitter.com/jaydestro) - Jay Gordon, Cloud Advocate
- [@BrianBenz](https://twitter.com/BrianBenz) - Senior Cloud Advocate, Java/Python focus
- [@Azure_Status](https://twitter.com/Azure_Status) - Official status updates (when shit breaks)
- [@Michael_Collier](https://twitter.com/Michael_Collier) - Azure MVP, solid technical content

**YouTube/Streamers:**

- [Azure Friday](https://www.youtube.com/c/AzureFriday) - Weekly show, solid interviews + demos
- [John Savill's Technical Training](https://www.youtube.com/c/NTFAQGuy) - Deep technical content, certs prep
- [Microsoft Azure](https://www.youtube.com/c/MicrosoftAzure) - Official channel
- [Adam Marczak](https://www.youtube.com/c/AdamMarczakYT) - Azure Back to School series, quality tutorials

### 💬 Active Communities

- **[r/AZURE](https://reddit.com/r/AZURE)** - 100k+ members, active daily, good mix of questions + discussions
- **[Azure Community Discord](https://discord.gg/azurecommunity)** - Active community, helpful folks
- **[Dev.to #azure](https://dev.to/t/azure)** - Quality tutorials and articles
- **[Microsoft Q&A](https://learn.microsoft.com/en-us/answers/products/azure)** - Official Q&A, Microsoft staff answer
- **[Azure Tech Community](https://techcommunity.microsoft.com/t5/azure/ct-p/Azure)** - Official forums, product teams participate

### 🎙️ Podcasts & Newsletters

**Podcasts:**

- **[Azure Friday Podcast](https://azure.microsoft.com/en-us/resources/videos/azure-friday/)** - Weekly, Scott Hanselman, quality guests
- **[Cloud Native Show](https://www.youtube.com/playlist?list=PLLasX02E8BPBEXHhjmkWmQDbSaX_TwdUU)** - Kubernetes on Azure focus
- **[The Azure Podcast](http://azpodcast.azurewebsites.net/)** - Weekly Azure news + interviews

**Newsletters:**

- **[Azure Weekly](https://azureweekly.info/)** - Curated news, weekly
- **[Microsoft Azure Newsletter](https://azure.microsoft.com/en-us/newsletter/)** - Official updates
- **[Azure Developer Community Blog](https://devblogs.microsoft.com/azure-sdk/)** - SDK updates, best practices

### 🎪 Events & Conferences

- **[Microsoft Ignite](https://ignite.microsoft.com/)** - November, Microsoft's biggest conference, virtual + in-person (Seattle/Orlando)
- **[Microsoft Build](https://build.microsoft.com/)** - May, developer-focused, virtual + Seattle
- **[Azure Global Bootcamp](https://www.azureglobalbootcamp.com/)** - Free, community-organized, worldwide
- **[Azure Meetups](https://www.meetup.com/pro/azureplatform/)** - Local meetups, check your city

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- 📚 __Official Stuff__

    ______________________________________________________________________

    [Azure Docs](https://learn.microsoft.com/en-us/azure/)

    [Azure CLI Reference](https://learn.microsoft.com/en-us/cli/azure/)

    [Azure Architecture Center](https://learn.microsoft.com/en-us/azure/architecture/)

    [Well-Architected Framework](https://learn.microsoft.com/en-us/azure/well-architected/)

- 🧪 __Hands-on__

    ______________________________________________________________________

    [Azure Free Account](https://azure.microsoft.com/en-us/free/)

    [Microsoft Learn Sandbox](https://learn.microsoft.com/en-us/training/)

    [Azure Cloud Shell](https://shell.azure.com/)

    [Azure Quickstart Templates](https://azure.microsoft.com/en-us/resources/templates/)

- 💻 __Real Code__

    ______________________________________________________________________

    [Awesome Azure](https://github.com/kristofferandreasen/awesome-azure)

    [Azure Samples](https://github.com/Azure-Samples)

    [Azure Quickstart Templates](https://github.com/Azure/azure-quickstart-templates)

    [Terraform Azure Examples](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples)

- 🔥 __Deep Dives__

    ______________________________________________________________________

    [Azure Architecture Center](https://learn.microsoft.com/en-us/azure/architecture/)

    [Azure Tips and Tricks](https://microsoft.github.io/AzureTipsAndTricks/)

    [Azure Citadel](https://azurecitadel.com/)

    [Azure Charts](https://azurecharts.com/) (Service availability by region)

- 🛠️ __Tools & Extensions__

    ______________________________________________________________________

    [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/)

    [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/) (Better than ARM)

    [Azure PowerShell](https://learn.microsoft.com/en-us/powershell/azure/)

    [Azure Storage Explorer](https://azure.microsoft.com/en-us/products/storage/storage-explorer/)

    [Azure Tools (VSCode)](https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-node-azure-pack)

- 📰 __News & Updates__

    ______________________________________________________________________

    [Azure Updates](https://azure.microsoft.com/en-us/updates/)

    [Azure Blog](https://azure.microsoft.com/en-us/blog/)

    [r/AZURE](https://reddit.com/r/AZURE)

    [Azure Status](https://status.azure.com/) (When shit breaks)

</div>

______________________________________________________________________

**Last Updated:** 2026-01-13 **Vibe Check:** 📈 Growing Fast - Azure is the enterprise choice. Strong Windows/AD integration, Microsoft sales force pushing hard. Not as mature as AWS for some services, but catching up quick. Great if you're already in Microsoft ecosystem.
