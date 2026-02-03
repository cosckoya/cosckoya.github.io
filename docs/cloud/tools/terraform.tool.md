---
title: Terraform
description: Infrastructure as Code tool - declarative configs, multi-cloud, state management headaches
---

# :fontawesome-solid-cube: Terraform

Infrastructure as Code tool that turns your infrastructure into declarative configuration files. Multi-cloud support, huge provider ecosystem, plan-before-apply workflow. State management is both its superpower and your biggest headache.

!!! tip "2026 Update"
    Terraform 1.9+ is mature and stable. OpenTofu fork is growing (post-license drama). Focus on modules, remote state, and workspace strategies. HCP Terraform (formerly Terraform Cloud) is the recommended state backend.

______________________________________________________________________

## :fontawesome-solid-bolt-lightning: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # Initialize working directory (first time setup)
    terraform init # (1)!

    # Validate configuration syntax
    terraform validate # (2)!

    # Format code (like prettier for HCL)
    terraform fmt -recursive # (3)!

    # Plan changes (dry run - ALWAYS do this)
    terraform plan -out=tfplan # (4)!

    # Apply changes (create/update infrastructure)
    terraform apply tfplan # (5)!

    # Destroy everything (dangerous!)
    terraform destroy # (6)!

    # Show current state
    terraform show # (7)!

    # List resources in state
    terraform state list # (8)!

    # Import existing resource into state
    terraform import aws_instance.example i-1234567890abcdef0 # (9)!

    # Refresh state from real infrastructure
    terraform refresh # (10)!

    # Output values from state
    terraform output # (11)!

    # Workspace management (like git branches for infrastructure)
    terraform workspace list
    terraform workspace new staging # (12)!
    terraform workspace select production
    ```

    1. Downloads providers, initializes backend - run after cloning or changing providers
    2. Checks syntax errors before plan - fast feedback loop
    3. Auto-formats all `.tf` files - use in pre-commit hooks
    4. Saves plan to file - ensures apply does exactly what plan showed
    5. Applies saved plan - never run `terraform apply` without plan file in CI/CD
    6. Deletes ALL resources in state - add `-target` to limit scope
    7. Human-readable state dump - useful for debugging
    8. Shows all resource addresses - use for targeting specific resources
    9. Brings existing infra under Terraform management - state will be modified
    10. Updates state without changes - deprecated in 1.9+, use `plan -refresh-only`
    11. Displays output variables - useful for getting IPs, ARNs, etc.
    12. Isolates state files - dev/staging/prod should use separate workspaces or backends

    **Real talk:**

    - ALWAYS run `terraform plan` before `apply` - no exceptions
    - State file is sacred - never edit manually, always use commands
    - Use remote state (S3 + DynamoDB) for teams - local state is for learning only
    - Lock your provider versions - `terraform { required_providers { aws = { version = "~> 5.0" } } }`
    - Use `.terraform.lock.hcl` in version control - reproducible builds

=== ":fontawesome-solid-bolt: Common Patterns"

    ```hcl
    # Provider configuration (AWS example)
    terraform {
      required_version = ">= 1.9.0" # (1)!

      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0" # (2)!
        }
      }

      backend "s3" { # (3)!
        bucket         = "my-terraform-state"
        key            = "prod/terraform.tfstate"
        region         = "us-east-1"
        dynamodb_table = "terraform-locks"
        encrypt        = true
      }
    }

    provider "aws" {
      region = var.aws_region

      default_tags { # (4)!
        tags = {
          Environment = var.environment
          ManagedBy   = "Terraform"
          Project     = var.project_name
        }
      }
    }

    # Variables (inputs)
    variable "environment" {
      description = "Environment name (dev, staging, prod)"
      type        = string
      validation { # (5)!
        condition     = contains(["dev", "staging", "prod"], var.environment)
        error_message = "Environment must be dev, staging, or prod."
      }
    }

    variable "instance_type" {
      description = "EC2 instance type"
      type        = string
      default     = "t3.micro" # (6)!
    }

    # Data sources (query existing resources)
    data "aws_ami" "ubuntu" { # (7)!
      most_recent = true
      owners      = ["099720109477"] # Canonical

      filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
      }
    }

    # Resources (create new infrastructure)
    resource "aws_instance" "web" { # (8)!
      ami           = data.aws_ami.ubuntu.id
      instance_type = var.instance_type

      tags = {
        Name = "${var.environment}-web-server"
      }

      lifecycle { # (9)!
        create_before_destroy = true
        prevent_destroy       = false
      }
    }

    # Outputs (export values)
    output "instance_id" { # (10)!
      description = "EC2 instance ID"
      value       = aws_instance.web.id
    }

    output "public_ip" {
      description = "Public IP address"
      value       = aws_instance.web.public_ip
      sensitive   = false # (11)!
    }
    ```

    1. Pin Terraform version - prevents breaking changes from new releases
    2. `~>` allows patch updates (5.0.x) but not minor (5.1.0) - balance stability + security
    3. Remote state with locking - S3 for storage, DynamoDB for state locks (prevents concurrent runs)
    4. Default tags applied to ALL resources - critical for cost allocation and governance
    5. Input validation catches errors early - fails fast at plan time, not apply
    6. Sensible defaults reduce boilerplate in calling code
    7. Data sources query existing infrastructure - AMIs, VPCs, security groups, etc.
    8. Resource block creates managed infrastructure - Terraform tracks in state
    9. Lifecycle rules control create/update/destroy behavior - `prevent_destroy` for production DBs
    10. Outputs export values for other modules or display to user
    11. Mark sensitive outputs to hide from console - passwords, keys, tokens

    ```hcl
    # Module usage (reusable infrastructure components)
    module "vpc" { # (1)!
      source  = "terraform-aws-modules/vpc/aws"
      version = "5.5.0"

      name = "${var.environment}-vpc"
      cidr = "10.0.0.0/16"

      azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
      private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
      public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

      enable_nat_gateway = true
      single_nat_gateway = var.environment != "prod" # (2)!

      tags = var.common_tags
    }

    # Local values (computed within module)
    locals { # (3)!
      common_tags = {
        Environment = var.environment
        ManagedBy   = "Terraform"
        CostCenter  = "engineering"
      }

      db_name = "${var.project_name}-${var.environment}-db"
    }

    # Count meta-argument (create multiple similar resources)
    resource "aws_instance" "app" { # (4)!
      count = var.instance_count

      ami           = data.aws_ami.ubuntu.id
      instance_type = var.instance_type

      tags = {
        Name = "${var.environment}-app-${count.index}"
      }
    }

    # For_each meta-argument (better than count for maps)
    resource "aws_iam_user" "developers" { # (5)!
      for_each = toset(var.developer_names)

      name = each.value
      path = "/developers/"

      tags = {
        Team = "Engineering"
      }
    }
    ```

    1. Modules are reusable infrastructure components - use Terraform Registry or build your own
    2. Conditional logic - single NAT for dev (cheaper), HA NAT for prod (reliable)
    3. Locals reduce repetition and compute derived values - DRY principle
    4. Count creates N identical resources - use for homogeneous resources (VMs, DNS records)
    5. For_each is better for heterogeneous resources - each has unique name/config

    **Why this works:**

    - Declarative syntax describes desired state, not steps to get there
    - Plan-before-apply workflow prevents surprises in production
    - State file tracks reality vs config - enables drift detection
    - Modules enable reusability - write once, use everywhere
    - Remote state + locking prevents concurrent modifications (corruption)

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Pin ALL versions** - Terraform binary, providers, modules (prevents breaking changes)
        - **Remote state is mandatory** - S3 + DynamoDB for AWS, Terraform Cloud, or HCP Terraform
        - **Use modules for reusability** - DRY principle, consistent patterns across environments
        - **Separate environments** - dev/staging/prod use different backends or workspaces
        - **Small, focused plans** - huge plans are hard to review and risky to apply
        - **Enable debug logs** - `TF_LOG=DEBUG` when troubleshooting weird issues
        - **Use `.gitignore`** - never commit `.terraform/`, `*.tfstate`, `*.tfvars` with secrets

    !!! warning "State Management"
        - **State is THE source of truth** - if state diverges from reality, you're screwed
        - **Never edit state manually** - always use `terraform state` commands
        - **State locking is critical** - prevents concurrent runs from corrupting state
        - **Backup state before major changes** - `terraform state pull > backup.tfstate`
        - **Import before creating** - if resource exists, import it (don't recreate)
        - **State file contains secrets** - encrypt at rest, restrict access, never commit
        - **Use `moved` blocks** - refactor resources without destroy/recreate (Terraform 1.1+)

    !!! tip "Performance"
        - **Parallelize with `-parallelism=N`** - default 10, increase for large applies (careful!)
        - **Target specific resources** - `terraform apply -target=resource.name` (emergency only)
        - **Use `depends_on` sparingly** - Terraform infers most dependencies automatically
        - **Split large configs** - monolithic statefile = slow plans (use workspaces or separate roots)
        - **Cache providers locally** - `terraform providers mirror` for air-gapped environments
        - **Upgrade incrementally** - don't jump from 0.12 to 1.9 in one go

    !!! danger "Common Mistakes"
        - **Running apply without plan** - you will destroy production eventually
        - **Ignoring plan output** - `-/+` means destroy + recreate (data loss!)
        - **Hardcoded values** - use variables, not literals (environment-specific configs)
        - **Circular dependencies** - plan fails with cryptic errors (refactor resource graph)
        - **Destroying without backup** - `terraform destroy` is permanent, state is gone
        - **Forgetting `-target` scope** - destroys more than intended
        - **Not using `.terraform.lock.hcl`** - inconsistent provider versions across team
        - **Importing without config** - state has resource but config doesn't (will be destroyed)

    !!! info "Debugging"
        - **Set `TF_LOG=TRACE`** - see every API call (verbose, useful for provider bugs)
        - **Use `terraform graph | dot -Tsvg > graph.svg`** - visualize resource dependencies
        - **Check `terraform show -json`** - machine-readable state for scripting
        - **Enable provider logging** - `TF_LOG_PROVIDER=DEBUG` for provider-specific issues
        - **Use `terraform console`** - REPL for testing expressions and functions
        - **Validate often** - `terraform validate` is fast, catches syntax errors early

    !!! question "When NOT to use Terraform"
        - **Mutable infrastructure** - Terraform is for immutable infra (use Ansible for config mgmt)
        - **Application deployment** - use CI/CD tools (GitHub Actions, GitLab CI), not Terraform
        - **Secrets management** - use Vault, AWS Secrets Manager, not Terraform variables
        - **Day-2 operations** - patching, log rotation, backups (use automation tools)
        - **Frequent changes** - if config changes hourly, Terraform's overhead isn't worth it

______________________________________________________________________

## :fontawesome-solid-graduation-cap: Learning Paths

### :fontawesome-solid-book-open: Free Resources

- **[Terraform Learn](https://learn.hashicorp.com/terraform)** - Official tutorials, start here (getting started track is excellent)
- **[Terraform Registry](https://registry.terraform.io/)** - Browse providers and modules (AWS/Azure/GCP providers are massive)
- **[Terraform Best Practices](https://www.terraform-best-practices.com/)** - Community-driven guide (opinionated, practical)
- **[Terraform Up & Running (book samples)](https://github.com/brikis98/terraform-up-and-running-code)** - Yevgeniy Brikman's book examples
- **[Terraform AWS Examples](https://github.com/hashicorp/terraform-provider-aws/tree/main/examples)** - Official AWS provider examples

### :fontawesome-solid-flask: Interactive Practice

- **[Terraform Tutorials](https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code)** - Hands-on labs in HashiCorp Learn
- **[Katacoda Terraform](https://www.katacoda.com/courses/terraform)** - Browser-based scenarios (free)
- **[Terraform LocalStack](https://docs.localstack.cloud/user-guide/integrations/terraform/)** - Test AWS Terraform locally (no real resources)
- **[KillerCoda Terraform](https://killercoda.com/terraform)** - Interactive Terraform scenarios

### :fontawesome-solid-certificate: Certifications

!!! success "Recommended Path"
    **HashiCorp Certified: Terraform Associate (003)** - $70, proves foundational knowledge, worth it for resume

- **[Terraform Associate](https://www.hashicorp.com/certification/terraform-associate)** - $70, 1 hour, 57 questions, 60% pass rate
- Study 1-2 months with hands-on practice
- Use [Terraform Associate Study Guide](https://learn.hashicorp.com/tutorials/terraform/associate-study)
- Practice exams: [Bryan Krausen Udemy](https://www.udemy.com/course/terraform-associate-practice-exam/)

**Reality check:**

- Certification is optional but helps with job hunting
- Hands-on experience matters more than cert
- Focus on understanding state, modules, and workflows

### :fontawesome-solid-rocket: Projects to Build

!!! example "Beginner (learn the basics)"
    - **Static website** - S3 bucket + CloudFront distribution
    - **Single EC2 instance** - VPC, security group, key pair, instance
    - **RDS database** - Subnet group, parameter group, instance

!!! example "Intermediate (portfolio-worthy)"
    - **3-tier architecture** - VPC, ALB, EC2 Auto Scaling Group, RDS
    - **EKS cluster** - Use official `terraform-aws-modules/eks/aws` module
    - **Multi-environment setup** - Dev/staging/prod with workspaces or separate backends
    - **Terraform module library** - Reusable VPC, ALB, RDS modules for your team

!!! example "Advanced (job-interview flex)"
    - **Multi-region DR setup** - Route 53, RDS cross-region replicas, automated failover
    - **GitOps workflow** - Atlantis or Terraform Cloud with GitHub Actions
    - **Dynamic credentials** - Vault provider for short-lived AWS credentials
    - **Policy as code** - Sentinel or OPA for compliance checks in Terraform Cloud

______________________________________________________________________

## :fontawesome-solid-heart-pulse: Community Pulse

### :fontawesome-solid-users: Who to Follow

**Twitter/X:**

- [@HashiCorp](https://twitter.com/HashiCorp) - Official updates, release announcements
- [@mitchellh](https://twitter.com/mitchellh) - Mitchell Hashimoto, HashiCorp co-founder
- [@brikis98](https://twitter.com/brikis98) - Yevgeniy Brikman, Gruntwork co-founder, "Terraform: Up & Running" author
- [@antonbabenko](https://twitter.com/antonbabenko) - Anton Babenko, terraform-aws-modules maintainer
- [@jen20](https://twitter.com/jen20) - James Nugent, Terraform core contributor

**YouTube/Streamers:**

- [HashiCorp](https://www.youtube.com/c/HashiCorp) - Official channel, webinars, deep dives
- [TechWorld with Nana](https://www.youtube.com/c/TechWorldwithNana) - Terraform crash course, practical tutorials
- [FreeCodeCamp Terraform](https://www.youtube.com/watch?v=SLB_c_ayRMo) - Full course, beginner-friendly
- [Cloud Posse](https://www.youtube.com/c/CloudPosse) - Terraform modules, best practices

### :fontawesome-solid-comments: Active Communities

- **[r/Terraform](https://reddit.com/r/Terraform)** - 100k+ members, active daily, helpful for troubleshooting
- **[HashiCorp Discuss](https://discuss.hashicorp.com/c/terraform-core)** - Official forums, core team responds
- **[Terraform Community Slack](https://terraform-community.slack.com/)** - Real-time help (invite via website)
- **[OpenTofu Community](https://opentofu.org/community)** - Open-source Terraform fork (post-license change)

### :fontawesome-solid-podcast: Newsletters & Blogs

- **[Terraform Weekly](https://www.terraformweekly.com/)** - Weekly curated links, tips, modules
- **[HashiCorp Blog](https://www.hashicorp.com/blog)** - Official posts, product updates
- **[Gruntwork Blog](https://blog.gruntwork.io/)** - Infrastructure patterns, best practices
- **[env0 Blog](https://www.env0.com/blog)** - IaC management, Terraform tips

### :fontawesome-solid-calendar: Events & Conferences

- **[HashiConf](https://hashiconf.com/)** - Annual conference, San Francisco + virtual, October
- **[HashiCorp User Groups](https://www.meetup.com/pro/hugs/)** - Local meetups worldwide
- **[Open Source Summit](https://events.linuxfoundation.org/)** - Often features IaC talks

______________________________________________________________________

## :fontawesome-solid-star: Worth Checking

<div class="grid cards" markdown>

- :fontawesome-solid-book: __Official Docs__

    ______________________________________________________________________

    [Terraform Documentation](https://www.terraform.io/docs)

    [Terraform Registry](https://registry.terraform.io/)

    [HashiCorp Learn](https://learn.hashicorp.com/terraform)

    [Terraform Language Docs](https://www.terraform.io/language)

- :fontawesome-solid-flask: __Hands-on Practice__

    ______________________________________________________________________

    [Terraform Tutorials](https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code)

    [Katacoda Terraform](https://www.katacoda.com/courses/terraform)

    [LocalStack + Terraform](https://docs.localstack.cloud/user-guide/integrations/terraform/)

    [KillerCoda Scenarios](https://killercoda.com/terraform)

- :fontawesome-solid-code: __Code Examples__

    ______________________________________________________________________

    [Terraform AWS Examples](https://github.com/hashicorp/terraform-provider-aws/tree/main/examples)

    [terraform-aws-modules](https://github.com/terraform-aws-modules)

    [Terraform Up & Running Code](https://github.com/brikis98/terraform-up-and-running-code)

    [Awesome Terraform](https://github.com/shuaibiyy/awesome-terraform)

- :fontawesome-solid-fire: __Advanced Topics__

    ______________________________________________________________________

    [Terraform Best Practices](https://www.terraform-best-practices.com/)

    [Gruntwork IaC Library](https://gruntwork.io/infrastructure-as-code-library/)

    [Terraform Testing (Terratest)](https://terratest.gruntwork.io/)

    [Policy as Code (Sentinel)](https://www.terraform.io/cloud-docs/policy-enforcement)

- :fontawesome-solid-screwdriver-wrench: __Tools & Extensions__

    ______________________________________________________________________

    [Terraform VSCode Extension](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)

    [tflint](https://github.com/terraform-linters/tflint) (linter)

    [tfsec](https://github.com/aquasecurity/tfsec) (security scanner)

    [Atlantis](https://www.runatlantis.io/) (GitOps for Terraform)

    [Terragrunt](https://terragrunt.gruntwork.io/) (DRY wrapper for Terraform)

    [tfenv](https://github.com/tfutils/tfenv) (version manager)

- :fontawesome-solid-rss: __News & Updates__

    ______________________________________________________________________

    [Terraform Changelog](https://github.com/hashicorp/terraform/blob/main/CHANGELOG.md)

    [HashiCorp Releases](https://www.hashicorp.com/blog/products/terraform)

    [r/Terraform](https://reddit.com/r/Terraform)

    [OpenTofu Roadmap](https://github.com/opentofu/opentofu/blob/main/ROADMAP.md)

</div>

______________________________________________________________________

**Last Updated:** 2026-01-31 | **Vibe Check:** :fontawesome-solid-fire: **Essential** - Infrastructure as Code is non-negotiable in 2026. Terraform is the industry standard. OpenTofu fork is viable alternative post-license drama. Master state management, modules, and workspaces. HCP Terraform (formerly Terraform Cloud) is worth paying for teams.
**Tags:** terraform, iac, devops, hashicorp
