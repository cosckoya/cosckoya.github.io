---
title: Terraform
description: Infrastructure as Code from HashiCorp - declare your infrastructure, version it, deploy it anywhere
tags:
  - terraform
  - iac
  - infrastructure-as-code
  - hashicorp
  - cloud
---

# Terraform

Infrastructure as Code from HashiCorp. Declare your cloud infrastructure in HCL, version it in Git, deploy anywhere. Cloud-agnostic, powerful, sometimes frustrating. Beats ClickOps every time.

______________________________________________________________________

## Quick Hits

=== "🎯 Essential Commands"

    ```bash
    # Initialize (download providers)
    terraform init

    # Plan (preview changes)
    terraform plan

    # Apply (create/update resources)
    terraform apply

    # Destroy (tear down everything)
    terraform destroy

    # Format code
    terraform fmt

    # Validate syntax
    terraform validate

    # Show current state
    terraform show

    # List resources in state
    terraform state list

    # Import existing resource
    terraform import aws_instance.example i-abcd1234

    # Refresh state
    terraform refresh
    ```

    **Real talk:**

    - Always run `plan` before `apply`
    - State file is critical - back it up, use remote state
    - Use workspaces or separate directories for environments
    - Lock state during operations (S3 + DynamoDB for AWS)

=== "⚡ Common Patterns"

    ```hcl
    # Basic AWS EC2 instance
    terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0"
        }
      }
      backend "s3" {
        bucket         = "my-terraform-state"
        key            = "prod/terraform.tfstate"
        region         = "us-east-1"
        dynamodb_table = "terraform-locks"
      }
    }

    provider "aws" {
      region = var.aws_region
    }

    resource "aws_instance" "web" {
      ami           = var.ami_id
      instance_type = var.instance_type

      tags = {
        Name        = "web-server"
        Environment = var.environment
        ManagedBy   = "terraform"
      }
    }

    # Variables
    variable "aws_region" {
      description = "AWS region"
      type        = string
      default     = "us-east-1"
    }

    # Outputs
    output "instance_ip" {
      value = aws_instance.web.public_ip
    }

    # Modules (reusable components)
    module "vpc" {
      source  = "terraform-aws-modules/vpc/aws"
      version = "5.0.0"

      name = "my-vpc"
      cidr = "10.0.0.0/16"

      azs             = ["us-east-1a", "us-east-1b"]
      private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
      public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

      enable_nat_gateway = true
      single_nat_gateway = true
    }
    ```

=== "🔥 Pro Tips & Gotchas"

    - **State management:** Use remote state (S3, Terraform Cloud), never commit state to Git
    - **Modules:** DRY - create modules for repeated patterns
    - **Variables:** Use `.tfvars` files for environment-specific values
    - **Secrets:** Never hardcode, use AWS Secrets Manager or environment variables
    - **Dependencies:** Terraform figures most out, use `depends_on` when needed
    - **Data sources:** Query existing resources without managing them
    - **Workspaces:** Good for simple env separation, modules better for complex
    - **Import:** Can import existing resources, but tedious
    - **Destroy:** Be careful - it actually destroys (use `prevent_destroy` lifecycle)
    - **State drift:** Run `plan` regularly to detect manual changes
    - **When NOT to use:** Simple static sites (Vercel/Netlify easier), very dynamic infrastructure

______________________________________________________________________

## Learning Paths

### 🎓 Free Resources

- **[Terraform Docs](https://www.terraform.io/docs)** - Official documentation, comprehensive
- **[HashiCorp Learn](https://learn.hashicorp.com/terraform)** - Official tutorials, hands-on
- **[Terraform Best Practices](https://www.terraform-best-practices.com/)** - Community guide
- **[Awesome Terraform](https://github.com/shuaibiyy/awesome-terraform)** - Curated modules, tools, tutorials
- **[freeCodeCamp Terraform Course](https://www.youtube.com/watch?v=SLB_c_ayRMo)** - 2+ hour crash course

### 🧪 Interactive Labs

- **[Terraform Cloud Free Tier](https://app.terraform.io/)** - Remote state, collaboration, free for small teams
- **[Killercoda Terraform](https://killercoda.com/terraform)** - Browser-based scenarios
- **[LocalStack](https://localstack.cloud/)** - Local AWS cloud emulation for testing

### 📜 Certifications Worth It

- **[Terraform Associate](https://www.hashicorp.com/certification/terraform-associate)** - $70, hands-on, worth it
- **Skip**: Advanced certs - learn by doing, not testing

### 🚀 Projects to Build

- **Beginner:** Deploy a static website to S3 + CloudFront with Terraform
- **Intermediate:** Create reusable VPC module with public/private subnets, NAT
- **Advanced:** Build multi-environment (dev/staging/prod) EKS cluster with GitOps

______________________________________________________________________

## Community Pulse

### 🐦 Who to Follow

**Twitter/X:**

- [@HashiCorp](https://twitter.com/HashiCorp) - Official updates
- [@mitchellh](https://twitter.com/mitchellh) - Terraform creator
- [@brikis98](https://twitter.com/brikis98) - Author of "Terraform: Up & Running"
- [@antonbabenko](https://twitter.com/antonbabenko) - Terraform modules maintainer
- [@gruntwork_io](https://twitter.com/gruntwork_io) - Terraform consulting/training

**YouTube:**

- [HashiCorp](https://www.youtube.com/c/HashiCorp) - Official channel, HashiConf talks
- [TechWorld with Nana](https://www.youtube.com/c/TechWorldwithNana) - Terraform tutorials
- [Anton Babenko](https://www.youtube.com/c/AntonBabenko) - Weekly Terraform updates

### 💬 Active Communities

- **[Terraform Community Slack](https://terraform-community-slack.herokuapp.com/)** - Active discussions
- **[r/terraform](https://reddit.com/r/terraform)** - 50k+ members, questions and best practices
- **[HashiCorp Discuss](https://discuss.hashicorp.com/c/terraform-core/)** - Official forum
- **[Stack Overflow: terraform](https://stackoverflow.com/questions/tagged/terraform)** - Technical Q&A

### 🎙️ Podcasts & Newsletters

- **[HashiCorp Blog](https://www.hashicorp.com/blog)** - Product updates, case studies
- **[Terraform Weekly](https://terraform-weekly.com/)** - Newsletter, curated news
- **[CloudSkills.fm](https://cloudskills.fm/)** - Cloud and IaC topics

### 🎪 Events & Conferences

- **[HashiConf](https://hashiconf.com/)** - Annual, virtual + in-person, worth it for heavy users
- **[HashiCorp User Groups](https://www.meetup.com/pro/hugs/)** - Local meetups worldwide

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- 📚 __Official Stuff__

    ______________________________________________________________________

    [Terraform Docs](https://www.terraform.io/docs)

    [HashiCorp Learn](https://learn.hashicorp.com/terraform)

    [Terraform Registry](https://registry.terraform.io/)

    [Terraform GitHub](https://github.com/hashicorp/terraform)

- 🧪 __Hands-on__

    ______________________________________________________________________

    [Terraform Cloud Free](https://app.terraform.io/)

    [Killercoda Terraform](https://killercoda.com/terraform)

    [Terraform Tutorials](https://learn.hashicorp.com/terraform)

- 💻 __Modules & Code__

    ______________________________________________________________________

    [Terraform AWS Modules](https://github.com/terraform-aws-modules)

    [Gruntwork Modules](https://gruntwork.io/infrastructure-as-code-library/)

    [Awesome Terraform](https://github.com/shuaibiyy/awesome-terraform)

- 🔥 __Best Practices__

    ______________________________________________________________________

    [Terraform Best Practices](https://www.terraform-best-practices.com/)

    [Gruntwork Blog](https://blog.gruntwork.io/)

    [Terraform Up & Running](https://www.terraformupandrunning.com/)

- 🛠️ __Tools & Extensions__

    ______________________________________________________________________

    [Terragrunt](https://terragrunt.gruntwork.io/)

    [Infracost](https://www.infracost.io/)

    [tfsec](https://github.com/aquasecurity/tfsec)

    [terraform-docs](https://github.com/terraform-docs/terraform-docs)

- 📰 __News & Updates__

    ______________________________________________________________________

    [Terraform Changelog](https://github.com/hashicorp/terraform/blob/main/CHANGELOG.md)

    [r/terraform](https://reddit.com/r/terraform)

    [Terraform Weekly](https://terraform-weekly.com/)

</div>

______________________________________________________________________

## Project Structure

```
.
├── main.tf              # Main resources
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── terraform.tfvars     # Variable values (gitignored if secrets)
├── versions.tf          # Provider versions
├── backend.tf           # Remote state config
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ec2/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/
    ├── dev/
    │   ├── main.tf
    │   └── terraform.tfvars
    ├── staging/
    │   ├── main.tf
    │   └── terraform.tfvars
    └── prod/
        ├── main.tf
        └── terraform.tfvars
```

______________________________________________________________________

## Remote State Configuration

### AWS S3 Backend

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
    kms_key_id     = "arn:aws:kms:..."
  }
}
```

**Setup:**

```bash
# Create S3 bucket
aws s3 mb s3://my-terraform-state --region us-east-1

# Enable versioning
aws s3api put-bucket-versioning \
  --bucket my-terraform-state \
  --versioning-configuration Status=Enabled

# Create DynamoDB table for locks
aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

### Terraform Cloud Backend

```hcl
terraform {
  cloud {
    organization = "my-org"

    workspaces {
      name = "my-workspace"
    }
  }
}
```

______________________________________________________________________

## Common Workflows

### 1. New Infrastructure

```bash
# Initialize
terraform init

# Format code
terraform fmt -recursive

# Validate
terraform validate

# Plan
terraform plan -out=tfplan

# Apply
terraform apply tfplan
```

### 2. Import Existing Resources

```bash
# Write resource block in .tf file (without values)
resource "aws_instance" "imported" {
  # Leave empty initially
}

# Import
terraform import aws_instance.imported i-abcd1234

# Show imported state
terraform show

# Update .tf file with actual values from state
# Run plan to verify
terraform plan
```

### 3. State Management

```bash
# List resources
terraform state list

# Show specific resource
terraform state show aws_instance.web

# Move resource (rename)
terraform state mv aws_instance.old aws_instance.new

# Remove from state (not cloud)
terraform state rm aws_instance.web

# Pull remote state
terraform state pull
```

### 4. CI/CD Integration

```yaml
# GitHub Actions example
name: Terraform
on:
  push:
    branches: [main]
  pull_request:

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: hashicorp/setup-terraform@v2
        with:
          terraform_version: 1.6.0

      - name: Terraform Init
        run: terraform init
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

      - name: Terraform Plan
        run: terraform plan -no-color

      - name: Terraform Apply
        if: github.ref == 'refs/heads/main'
        run: terraform apply -auto-approve
```

______________________________________________________________________

## Security Best Practices

### 1. Secret Management

```hcl
# Bad - hardcoded
resource "aws_db_instance" "db" {
  password = "SuperSecret123" # NO!
}

# Good - from AWS Secrets Manager
data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "db-password"
}

resource "aws_db_instance" "db" {
  password = data.aws_secretsmanager_secret_version.db_password.secret_string
}

# Or use environment variables
# TF_VAR_db_password=xxx terraform apply
```

### 2. State File Security

```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-state"
    encrypt        = true        # Encrypt at rest
    kms_key_id     = "arn:..."  # Use KMS
    dynamodb_table = "tf-locks"  # State locking
  }
}
```

### 3. Security Scanning

```bash
# tfsec - security scanner
tfsec .

# Checkov - policy-as-code
checkov -d .

# Infracost - cost estimation
infracost breakdown --path .
```

______________________________________________________________________

**Last Updated:** 2026-01-14 **Vibe Check:** 🌍 **Mainstream** - Terraform is the IaC standard. Not perfect (state management pain, complex debugging), but nothing else comes close. CloudFormation is AWS-only, Pulumi is growing but smaller ecosystem.
