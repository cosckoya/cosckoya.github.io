---
title: Infrastructure as Code (IaC)
description: Comprehensive guide to Infrastructure as Code tools including Terraform, CloudFormation, and Pulumi for cloud-agnostic infrastructure provisioning
tags:
  - iac
  - terraform
  - cloudformation
  - pulumi
  - devops
---

# Infrastructure as Code (IaC)

Infrastructure as Code (IaC) enables you to manage and provision infrastructure through code rather than manual processes. This approach brings version control, consistency, and automation to infrastructure management.

!!! abstract "Core IaC Concepts"
    - **Declarative**: Define desired state, not steps to achieve it
    - **Version Control**: Infrastructure definitions stored in Git
    - **Idempotency**: Apply the same configuration multiple times safely
    - **Multi-Cloud**: Support for AWS, Azure, GCP, and other providers

---

## Why Infrastructure as Code?

**Traditional Infrastructure Management Problems**:

- Manual, error-prone configuration
- Inconsistent environments (dev vs. production drift)
- No audit trail of changes
- Difficult to replicate environments
- Time-consuming disaster recovery

**IaC Benefits**:

- **Speed**: Provision environments in minutes, not days
- **Consistency**: Same code produces identical infrastructure
- **Version Control**: Track all infrastructure changes in Git
- **Automation**: Integrate with CI/CD pipelines
- **Documentation**: Code serves as living documentation
- **Cost Management**: Easily tear down unused resources

---

## Terraform

**Cloud-agnostic** infrastructure provisioning using HashiCorp Configuration Language (HCL).

### Core Concepts

**Providers**: Plugins that interact with cloud providers (AWS, Azure, GCP), SaaS platforms, or other APIs.

**Resources**: Infrastructure components (VMs, networks, databases) defined in configuration files.

**State**: Terraform tracks real-world resources in a state file to detect drift and plan changes.

**Workflow**:

1. **Write**: Define infrastructure in `.tf` files
2. **Init**: Initialize providers and modules
3. **Plan**: Preview changes before applying
4. **Apply**: Create/update infrastructure
5. **Destroy**: Clean up resources when done

### Example: AWS EC2 Instance

```hcl
# Configure AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "main-vpc"
    Environment = "production"
  }
}

# Create a subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet"
  }
}

# Create an EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id

  tags = {
    Name        = "WebServer"
    Environment = "Production"
  }
}

# Output the instance public IP
output "instance_ip" {
  value       = aws_instance.web.public_ip
  description = "The public IP of the web server"
}
```

### Terraform Commands

```bash
# Initialize Terraform (download providers)
terraform init

# Format code
terraform fmt

# Validate configuration
terraform validate

# Plan changes (dry run)
terraform plan

# Apply changes
terraform apply

# Show current state
terraform show

# Destroy all resources
terraform destroy

# Import existing resource into state
terraform import aws_instance.web i-1234567890abcdef0
```

### Terraform Best Practices

=== "State Management"
    **Remote State**: Store state in remote backends (S3, Terraform Cloud, Azure Storage) for team collaboration.

    ```hcl
    terraform {
      backend "s3" {
        bucket         = "my-terraform-state"
        key            = "prod/terraform.tfstate"
        region         = "us-east-1"
        encrypt        = true
        dynamodb_table = "terraform-locks"
      }
    }
    ```

    **State Locking**: Use DynamoDB (AWS) or similar to prevent concurrent modifications.

=== "Modules"
    **Reusable Components**: Create modules for commonly used infrastructure patterns.

    ```hcl
    # modules/vpc/main.tf
    resource "aws_vpc" "this" {
      cidr_block = var.cidr_block

      tags = {
        Name = var.name
      }
    }

    # Use the module
    module "production_vpc" {
      source     = "./modules/vpc"
      cidr_block = "10.0.0.0/16"
      name       = "prod-vpc"
    }
    ```

=== "Workspaces"
    **Environment Separation**: Use workspaces for dev, staging, production.

    ```bash
    terraform workspace new dev
    terraform workspace select dev
    terraform workspace list
    ```

=== "Secrets Management"
    **Never Commit Secrets**: Use environment variables, AWS Secrets Manager, or HashiCorp Vault.

    ```hcl
    # Bad - hardcoded
    db_password = "super_secret_password"

    # Good - from variable
    variable "db_password" {
      type      = string
      sensitive = true
    }

    # Pass via environment variable
    export TF_VAR_db_password="super_secret_password"
    ```

### Terraform Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Registry](https://registry.terraform.io/) - Module and provider registry
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [Learn Terraform](https://learn.hashicorp.com/terraform)

---

## AWS CloudFormation

**AWS-native** infrastructure as code using JSON or YAML templates.

### CloudFormation Strengths

- Deep AWS integration
- Native support for all AWS services
- Stack management (create, update, delete as a unit)
- Drift detection
- No additional agents or state management

### Example: CloudFormation Template

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: Simple EC2 instance with VPC

Parameters:
  InstanceType:
    Description: EC2 instance type
    Type: String
    Default: t2.micro
    AllowedValues:
      - t2.micro
      - t2.small
      - t2.medium

Resources:
  VPC:
    Type: AWS::EC2::VPC
    Properties:
      CidrBlock: 10.0.0.0/16
      EnableDnsHostnames: true
      Tags:
        - Key: Name
          Value: !Sub ${AWS::StackName}-VPC

  PublicSubnet:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.0.1.0/24
      AvailabilityZone: !Select [0, !GetAZs '']
      MapPublicIpOnLaunch: true

  WebServerInstance:
    Type: AWS::EC2::Instance
    Properties:
      ImageId: ami-0c55b159cbfafe1f0
      InstanceType: !Ref InstanceType
      SubnetId: !Ref PublicSubnet
      Tags:
        - Key: Name
          Value: !Sub ${AWS::StackName}-WebServer

Outputs:
  InstanceId:
    Description: Instance ID
    Value: !Ref WebServerInstance
  PublicIP:
    Description: Public IP address
    Value: !GetAtt WebServerInstance.PublicIp
```

### CloudFormation Commands

```bash
# Create stack
aws cloudformation create-stack \
  --stack-name my-stack \
  --template-body file://template.yaml \
  --parameters ParameterKey=InstanceType,ParameterValue=t2.micro

# Update stack
aws cloudformation update-stack \
  --stack-name my-stack \
  --template-body file://template.yaml

# Delete stack
aws cloudformation delete-stack --stack-name my-stack

# Describe stack
aws cloudformation describe-stacks --stack-name my-stack

# Detect drift
aws cloudformation detect-stack-drift --stack-name my-stack
```

### CloudFormation Resources

- [AWS CloudFormation Documentation](https://docs.aws.amazon.com/cloudformation/)
- [CloudFormation Template Reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-reference.html)

---

## Pulumi

**Multi-cloud** IaC using real programming languages (TypeScript, Python, Go, C#, Java).

### Pulumi Strengths

- Use familiar programming languages
- Full IDE support (autocomplete, type checking)
- Leverage existing package ecosystems (npm, PyPI)
- Test with standard testing frameworks
- Imperative and declarative approaches

### Example: Pulumi with TypeScript

```typescript
import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";

// Create a VPC
const vpc = new aws.ec2.Vpc("main-vpc", {
    cidrBlock: "10.0.0.0/16",
    tags: {
        Name: "main-vpc",
        Environment: "production",
    },
});

// Create a subnet
const subnet = new aws.ec2.Subnet("public-subnet", {
    vpcId: vpc.id,
    cidrBlock: "10.0.1.0/24",
    availabilityZone: "us-east-1a",
    tags: {
        Name: "public-subnet",
    },
});

// Create an EC2 instance
const instance = new aws.ec2.Instance("web-server", {
    ami: "ami-0c55b159cbfafe1f0",
    instanceType: "t2.micro",
    subnetId: subnet.id,
    tags: {
        Name: "WebServer",
        Environment: "Production",
    },
});

// Export the instance's public IP
export const instanceIp = instance.publicIp;
```

### Example: Pulumi with Python

```python
import pulumi
import pulumi_aws as aws

# Create a VPC
vpc = aws.ec2.Vpc("main-vpc",
    cidr_block="10.0.0.0/16",
    tags={
        "Name": "main-vpc",
        "Environment": "production",
    }
)

# Create a subnet
subnet = aws.ec2.Subnet("public-subnet",
    vpc_id=vpc.id,
    cidr_block="10.0.1.0/24",
    availability_zone="us-east-1a",
    tags={"Name": "public-subnet"}
)

# Create an EC2 instance
instance = aws.ec2.Instance("web-server",
    ami="ami-0c55b159cbfafe1f0",
    instance_type="t2.micro",
    subnet_id=subnet.id,
    tags={
        "Name": "WebServer",
        "Environment": "Production",
    }
)

# Export the instance's public IP
pulumi.export("instance_ip", instance.public_ip)
```

### Pulumi Commands

```bash
# Initialize a new project
pulumi new aws-typescript

# Preview changes
pulumi preview

# Deploy infrastructure
pulumi up

# Show current stack outputs
pulumi stack output

# Destroy infrastructure
pulumi destroy
```

### Pulumi Resources

- [Pulumi Documentation](https://www.pulumi.com/docs/)
- [Pulumi Examples](https://github.com/pulumi/examples)

---

## Choosing the Right IaC Tool

| Tool | Best For | Strengths | Considerations |
|------|----------|-----------|----------------|
| **Terraform** | Multi-cloud, mature projects | Large ecosystem, HCL syntax, state management | Separate state management needed |
| **CloudFormation** | AWS-only projects | Native AWS integration, no state files | AWS-specific, YAML/JSON verbosity |
| **Pulumi** | Teams with strong dev background | Real programming languages, testing | Newer tool, smaller community |

---

## IaC Best Practices

=== "Version Control"
    - **Store everything in Git**: All IaC code, modules, and configurations
    - **Branching strategy**: Use feature branches, PR reviews
    - **Commit messages**: Clear, descriptive commit messages
    - **`.gitignore`**: Never commit state files, secrets, or sensitive data

    ```gitignore
    # Terraform
    .terraform/
    *.tfstate
    *.tfstate.backup
    .terraform.lock.hcl

    # Environment files
    .env
    *.secret
    credentials.json
    ```

=== "Modularization"
    - **DRY Principle**: Create reusable modules for common patterns
    - **Composition**: Build complex infrastructure from simple modules
    - **Versioning**: Tag module versions for stability
    - **Documentation**: Document module inputs, outputs, and usage

=== "Testing"
    - **Static Analysis**: Use `terraform validate`, linters (tflint)
    - **Plan Review**: Always review `terraform plan` before applying
    - **Automated Testing**: Test infrastructure code with tools like Terratest
    - **Drift Detection**: Regularly check for configuration drift

=== "State Management"
    - **Remote Backend**: Never store state locally in production
    - **State Locking**: Prevent concurrent modifications
    - **Encryption**: Encrypt state at rest and in transit
    - **Backups**: Regular state backups for disaster recovery

=== "Secrets Management"
    - **Never commit secrets**: Use secret management services
    - **Environment Variables**: Pass secrets via environment variables
    - **Secrets Services**: AWS Secrets Manager, Azure Key Vault, HashiCorp Vault
    - **Encryption**: Encrypt sensitive values in state

    ```hcl
    # Use AWS Secrets Manager
    data "aws_secretsmanager_secret_version" "db_password" {
      secret_id = "production/db/password"
    }

    resource "aws_db_instance" "main" {
      password = data.aws_secretsmanager_secret_version.db_password.secret_string
    }
    ```

=== "Documentation"
    - **README files**: Explain purpose, usage, and prerequisites
    - **Inline comments**: Document complex logic and decisions
    - **Architecture diagrams**: Visualize infrastructure topology
    - **Runbooks**: Document operational procedures

=== "CI/CD Integration"
    - **Automated Validation**: Validate and lint on every commit
    - **Plan on PR**: Show plan output in pull requests
    - **Apply on Merge**: Auto-apply to environments after merge
    - **Approvals**: Require manual approval for production changes

---

## Learning Path

### Beginner

1. **Start with Terraform**: Most popular, great learning resources
2. **Simple Projects**: Create VPC, EC2 instances, S3 buckets
3. **Learn HCL Syntax**: Variables, outputs, data sources, resources
4. **Practice Locally**: Use `terraform plan` extensively

### Intermediate

1. **Modules**: Create reusable infrastructure modules
2. **Remote State**: Set up S3 backend with state locking
3. **Multi-Environment**: Use workspaces or separate state files
4. **CI/CD Integration**: Automate with GitHub Actions or GitLab CI

### Advanced

1. **Multi-Cloud**: Manage AWS, Azure, GCP together
2. **Custom Providers**: Write custom Terraform providers
3. **Advanced Patterns**: Blue-green deployments, canary releases
4. **Policy as Code**: Implement OPA (Open Policy Agent) for governance

---

## Related Topics

- [Configuration Management](../configuration-management/) - Ansible, Puppet, Chef for server configuration
- [CI/CD](../ci-cd/) - Integrate IaC into deployment pipelines
- [Cloud](../../cloud/) - Cloud platforms for infrastructure deployment
- [DevSecOps](../devsecops/) - Security in infrastructure code
