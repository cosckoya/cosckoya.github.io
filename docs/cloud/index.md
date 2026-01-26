---
title: Cloud
description: Cloud platforms - AWS, Azure, GCP. Infrastructure as Code, FinOps, and cloud-native everything. Rent computing power, pay-as-you-go, scale infinitely.
tags:
  - cloud
  - aws
  - azure
  - gcp
  - finops
  - terraform
  - cloud-security
---

# Cloud

Renting someone else's computer, but make it global. AWS runs half the internet, Azure powers enterprises, GCP brings Google's infrastructure to you. Master cloud platforms, optimize costs, secure workloads, automate with IaC.

!!! abstract "What You'll Find Here"
    - AWS, Azure, and GCP platform guides
    - Infrastructure as Code with Terraform
    - FinOps - Cloud cost optimization and financial management
    - Cloud security - CSPM, CWPP, CNAPP tools
    - Best practices for multi-cloud environments
    - Serverless, containers, and cloud-native patterns
    - Cost allocation, Reserved Instances, Spot instances
    - Security posture management and compliance

---

## Quick Navigation

<div class="grid cards" markdown>

- ☁️ **[AWS (Amazon Web Services)](aws/)**

    ---

    EC2, S3, Lambda, RDS - the 800-pound gorilla of cloud, 200+ services, runs half the internet

- 🔷 **[Azure (Microsoft Azure)](azure/)**

    ---

    Enterprise cloud platform, Active Directory integration, Windows workloads, hybrid cloud leader

- 🌐 **[GCP (Google Cloud Platform)](gcp/)**

    ---

    Google's infrastructure, BigQuery, Kubernetes birthplace, ML/AI powerhouse

- 💰 **[FinOps](finops.md)**

    ---

    Cloud Financial Operations - cost optimization, Reserved Instances, Spot instances, tagging strategies

- 🏗️ **[Terraform](terraform.md)**

    ---

    Infrastructure as Code - declarative config, multi-cloud, state management, modules

- 🔐 **[Cloud Security](cloud-security.md)**

    ---

    CSPM, CWPP, CNAPP - Wiz, Prisma Cloud, Prowler, Cloud Custodian, CIS benchmarks

</div>

---

## The Cloud Stack

```
┌─────────────────────────────────────┐
│     Applications & Workloads        │
├─────────────────────────────────────┤
│  Security (CSPM, CWPP, Compliance)  │
├─────────────────────────────────────┤
│  FinOps (Cost Mgmt, Optimization)   │
├─────────────────────────────────────┤
│  IaC (Terraform, CloudFormation)    │
├─────────────────────────────────────┤
│  Compute (VMs, Containers, Lambda)  │
├─────────────────────────────────────┤
│  Networking (VPC, Load Balancers)   │
├─────────────────────────────────────┤
│  Storage (Object, Block, File)      │
├─────────────────────────────────────┤
│  Cloud Platform (AWS/Azure/GCP)     │
└─────────────────────────────────────┘
```

---

## Learning Path

### Foundation (0-6 months)
1. **Pick a cloud platform** - AWS for breadth, Azure for enterprise, GCP for ML/data
2. **Core services** - Compute (EC2/VMs), storage (S3/Blob), networking (VPC)
3. **IAM fundamentals** - Users, roles, policies, principle of least privilege
4. **CLI basics** - aws-cli, az-cli, gcloud - automate from terminal
5. **Free tier exploration** - Stay within limits, experiment safely

### Intermediate (6-18 months)
1. **Infrastructure as Code** - Learn Terraform or CloudFormation
2. **Container services** - ECS/AKS/GKE, understand orchestration
3. **Serverless** - Lambda/Functions, event-driven architectures
4. **Cost optimization** - Reserved Instances, Spot instances, rightsizing
5. **Multi-region** - High availability, disaster recovery, global deployments

### Advanced (18+ months)
1. **Cloud security** - CSPM tools, CIS benchmarks, compliance automation
2. **FinOps practices** - Chargeback models, automated cost optimization
3. **Multi-cloud strategy** - When and how to use multiple providers
4. **Advanced networking** - Transit Gateway, peering, hybrid cloud
5. **Cloud architecture** - Well-Architected frameworks, design patterns

---

## Cloud Platform Comparison

| Feature | AWS | Azure | GCP |
|---------|-----|-------|-----|
| **Market Share** | ~32% (Leader) | ~23% (Second) | ~10% (Third) |
| **Services** | 200+ | 200+ | 100+ |
| **Strengths** | Breadth, maturity | Enterprise, hybrid | ML/AI, BigQuery |
| **Best For** | Startups, general | Enterprises, .NET | Data/analytics |
| **Free Tier** | 12 months | 12 months | Always free tier |
| **Compute** | EC2 | Virtual Machines | Compute Engine |
| **Storage** | S3 | Blob Storage | Cloud Storage |
| **Serverless** | Lambda | Functions | Cloud Functions |
| **Kubernetes** | EKS | AKS | GKE (Best K8s) |
| **Pricing** | Pay-as-you-go | Pay-as-you-go | Per-second billing |

---

## Related Sections

!!! info "Expand Your Skills"
    - **[DevOps](../devops/)** - CI/CD for cloud deployments, GitOps patterns
    - **[Containerization](../containerization/)** - Docker, Kubernetes for cloud-native apps
    - **[Security](../security/)** - Cloud security testing, pentesting cloud infrastructure
    - **[Tools](../tools/)** - CLI tools for cloud automation and management

---

## Community & Resources

### 🐦 Follow These
- **r/aws** - 200k+ members, AWS discussions and tips
- **r/azure** - 100k+ members, Azure community
- **r/googlecloud** - 50k+ members, GCP discussions
- **Cloud Architecture Community** - Multi-cloud architecture patterns

### 📚 Essential Reading
- **Cloud FinOps (O'Reilly)** - Cost optimization bible
- **Terraform: Up & Running** - Yevgeniy Brikman, IaC best practices
- **AWS Well-Architected Framework** - Free, AWS design principles
- **Cloud Security Alliance** - Cloud security best practices

### 🎙️ Podcasts & Newsletters
- **Screaming in the Cloud** - Corey Quinn, AWS cost focus (hilarious)
- **Last Week in AWS** - Newsletter, weekly AWS news
- **Cloud Security Podcast** - Google-hosted, weekly
- **Azure Podcast** - Weekly Azure updates

### 🎓 Certifications Worth It
- **AWS Solutions Architect Associate** ($150) - Most popular, resume booster
- **Azure Administrator Associate** ($165) - Good for enterprise roles
- **Terraform Associate** ($70) - Hands-on, vendor-neutral
- **CCSP (Certified Cloud Security Professional)** ($600) - Security-focused, respected

---

## Best Practices

!!! success "Core Principles"
    1. **Automate everything** - IaC for infrastructure, never ClickOps in prod
    2. **Cost optimization** - Tag resources, use Reserved Instances, monitor spend
    3. **Security first** - Least privilege IAM, encrypt at rest/transit, MFA everywhere
    4. **Multi-region HA** - Plan for failures, automate disaster recovery
    5. **Immutable infrastructure** - Build once, deploy everywhere, no SSH changes
    6. **Observability** - Metrics, logs, traces - you can't fix what you can't see
    7. **GitOps workflow** - Infrastructure changes via Git, peer review, rollback
    8. **Resource tagging** - Environment, Owner, Project, CostCenter - enforce it
    9. **Backup strategy** - Automate backups, test restores, plan retention
    10. **Keep learning** - Cloud changes weekly, new services constantly

---

**Last Updated:** 2026-01-14
**Vibe Check:** 🌍 **Mainstream** - Cloud is the default. On-prem is legacy. AWS dominates but multi-cloud is growing. Serverless and containers are standard. FinOps is exploding as bills spiral. Security is still everyone's nightmare.
