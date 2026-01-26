# AWS Documentation Template Usage Guide

**Created:** January 26, 2026 **MkDocs Material Expert** :octicons-heart-16:

______________________________________________________________________

## :octicons-file-16: Available Templates

### 1. AWS_SERVICE_TEMPLATE.md

**Purpose:** Blank template for any AWS service documentation

**Use for:** EC2, Lambda, RDS, CloudFront, IAM, etc.

**Features:**

- Complete structure with all sections
- Placeholders marked with `[BRACKETS]`
- Material theme features (tabs, admonitions, icons)
- Code blocks with annotations
- Progressive disclosure (collapsible advanced sections)

______________________________________________________________________

### 2. AWS_S3_EXAMPLE.md

**Purpose:** Fully filled-in example using S3

**Use for:**

- Reference implementation
- Understand how to fill template
- Copy sections for similar services

**Features:**

- Real S3 commands and code
- Practical examples
- Working Terraform configurations
- Production-ready patterns

______________________________________________________________________

## :octicons-zap-16: Quick Start

### Step 1: Copy Template

```bash
# Copy blank template
cp .claude/skills/mkdocs-material-expert/templates/AWS_SERVICE_TEMPLATE.md \
   docs/cloud/aws/ec2.md

# Or copy S3 example as starting point
cp .claude/skills/mkdocs-material-expert/templates/AWS_S3_EXAMPLE.md \
   docs/cloud/aws/s3.md
```

### Step 2: Replace Placeholders

Search for these patterns and replace:

| Placeholder              | Example                 | Description                                 |
| ------------------------ | ----------------------- | ------------------------------------------- |
| `[SERVICE_NAME]`         | `EC2`                   | AWS service name (uppercase)                |
| `[service-name]`         | `ec2`                   | Service name (lowercase)                    |
| `[service-category]`     | `compute`               | Category (compute, storage, database, etc.) |
| `[ONE_LINE_DESCRIPTION]` | `Elastic Compute Cloud` | Full service name                           |
| `[service]`              | `ec2`                   | CLI command prefix (`aws ec2...`)           |

**Quick find & replace:**

```bash
# In your editor:
:%s/\[SERVICE_NAME\]/EC2/g
:%s/\[service-name\]/ec2/g
:%s/\[service-category\]/compute/g
```

### Step 3: Fill Content Sections

Work through sections in order:

1. **Quick Start** - Most common commands
1. **Core Concepts** - 2-3 key concepts to understand
1. **Common Use Cases** - 3-5 real-world scenarios
1. **Configuration & Best Practices** - Security, performance, cost
1. **Advanced Patterns** - Optional, for power users
1. **Troubleshooting** - Common issues and fixes

### Step 4: Add to Navigation

```markdown
# docs/cloud/aws/SUMMARY.md
- [AWS Overview](index.md)
- [EC2](ec2.md)          # Add your new page
- [S3](s3.md)
- [Lambda](lambda.md)
```

### Step 5: Test Locally

```bash
make serve
# Visit http://localhost:8000/cloud/aws/ec2/
```

______________________________________________________________________

## :octicons-paintbrush-16: Template Features

### Octicons Throughout :octicons-heart-16:

The template uses octicons extensively (user's favorite!):

```markdown
# :octicons-cloud-16: Service Name
## :octicons-zap-16: Quick Start
## :octicons-book-16: Core Concepts
## :octicons-checklist-16: Common Use Cases
## :octicons-gear-16: Configuration
## :octicons-tools-16: Advanced Patterns
## :octicons-alert-16: Troubleshooting
```

**Icon Reference:**

- `:octicons-cloud-16:` - Cloud/AWS
- `:octicons-zap-16:` - Quick/Fast
- `:octicons-book-16:` - Documentation
- `:octicons-checklist-16:` - Tasks/Steps
- `:octicons-gear-16:` - Configuration
- `:octicons-shield-check-16:` - Security
- `:octicons-rocket-16:` - Performance
- `:octicons-credit-card-16:` - Costs
- `:octicons-tools-16:` - Advanced
- `:octicons-alert-16:` - Problems
- `:octicons-bug-16:` - Debugging
- `:octicons-law-16:` - Limits
- `:octicons-link-16:` - Integrations
- `:octicons-mortar-board-16:` - Learning

[Full octicons list](https://primer.style/foundations/icons)

### Tabbed Content

Used for showing multiple approaches (CLI, Python, Terraform):

````markdown
=== "CLI"
    ```bash
    aws service command
    ```

=== "Python"
    ```python
    boto3 code
    ```

=== "Terraform"
    ```hcl
    resource configuration
    ```
````

### Code Annotations

Explain code inline:

````markdown
```bash
aws s3 cp file.txt s3://bucket/  # (1)!
aws s3 sync ./dir s3://bucket/   # (2)!
```

1. :octicons-info-16: Explanation of command 1
2. :octicons-info-16: Explanation of command 2
````

### Admonitions

Visual callouts for important info:

```markdown
!!! tip "Real Talk :octicons-light-bulb-16:"
    - Key insight 1
    - Key insight 2

!!! warning "Common Mistake :octicons-alert-16:"
    Description of what to avoid

!!! danger "Critical Security :octicons-stop-16:"
    Security-critical information

!!! info "Pricing Model :octicons-info-16:"
    Cost information
```

### Collapsible Advanced Sections

Keep page scannable:

````markdown
??? example "Pattern 1: Advanced Technique :octicons-code-16:"
    **When to use:** Scenario description

    ```python
    # Complete code example
    ```

    **Benefits:**
    - Benefit 1
    - Benefit 2
````

______________________________________________________________________

## :octicons-checklist-16: Content Checklist

Before publishing, verify:

- [ ] All `[PLACEHOLDERS]` replaced
- [ ] Code examples tested and working
- [ ] CLI commands use correct service prefix
- [ ] Tags added to frontmatter
- [ ] Links to related pages work
- [ ] Octicons display correctly
- [ ] `make serve` renders properly
- [ ] `make build` passes (strict mode)
- [ ] Added to SUMMARY.md navigation

______________________________________________________________________

## :octicons-sparkle-16: Style Guidelines

### Tone

Match the existing style:

- **Practical** - Real commands that work
- **Direct** - No corporate marketing speak
- **Honest** - Call out gotchas and costs
- **Experienced** - "Real talk" sections with insider knowledge

**Good examples:**

- "S3 is AWS's foundational storage service—think of it as an infinitely scalable hard drive"
- "Bucket names are globally unique—`my-bucket` is taken, use `company-project-env-bucket-uuid`"
- "IAM is hell, but you MUST learn it—security nightmare otherwise"

**Bad examples:**

- "Leverage the power of AWS's industry-leading cloud infrastructure"
- "Best-in-class solution for enterprise-grade deployments"
- "Seamlessly integrate with your existing workflows"

### Code Examples

**Always include:**

- Working commands (tested)
- Comments explaining parameters
- Error handling
- Real-world context

**Good example:**

```python
def upload_to_s3(file_path, bucket, key):
    """Upload file with proper error handling"""
    s3 = boto3.client('s3')
    try:
        s3.upload_file(
            file_path,
            bucket,
            key,
            ExtraArgs={'ACL': 'private'}  # Don't leak shit
        )
        return True
    except ClientError as e:
        print(f"Upload failed: {e}")
        return False
```

**Bad example:**

```python
s3.upload_file(file, bucket, key)  # Upload file
```

### Section Length

- **Quick Start** - 3-5 essential commands
- **Core Concepts** - 2-3 key concepts (not encyclopedia)
- **Use Cases** - 3-5 real scenarios (not 20)
- **Troubleshooting** - 3-5 common issues (not every edge case)

Keep it **practical and scannable**. Users should find what they need in 30 seconds.

______________________________________________________________________

## :octicons-rocket-16: Advanced Customization

### Add Custom CSS

For service-specific styling:

```css
/* docs/stylesheets/aws-custom.css */

/* Highlight AWS service names */
.md-typeset .aws-service {
  color: var(--md-accent-fg-color);
  font-weight: 600;
}

/* Cost callout boxes */
.md-typeset .cost-info {
  background-color: rgba(255, 193, 7, 0.1);
  border-left: 4px solid #ffc107;
  padding: 12px 16px;
  border-radius: 4px;
  margin: 1rem 0;
}
```

Register in `mkdocs.yml`:

```yaml
extra_css:
  - stylesheets/aws-custom.css
```

### Add Diagrams

Use Mermaid for architecture diagrams:

````markdown
```mermaid
graph LR
    A[User] --> B[CloudFront]
    B --> C[S3 Bucket]
    B --> D[Lambda@Edge]
```
````

### Add Custom Metadata

For better SEO and search:

```yaml
---
title: AWS EC2 - Elastic Compute Cloud
description: Complete EC2 reference with examples, best practices, and troubleshooting
tags:
  - aws
  - compute
  - ec2
  - virtual-machines
icon: octicons/server-16
social:
  cards_layout: aws-service
---
```

______________________________________________________________________

## :octicons-file-directory-16: Template Structure Explained

### Why This Structure?

1. **Quick Start First** - Users need commands NOW
1. **Concepts Second** - Understanding follows doing
1. **Use Cases Third** - Real scenarios show value
1. **Config Fourth** - Deep dive for production
1. **Advanced Last** - Progressive disclosure
1. **Troubleshooting Always** - Debug when stuck

### Section Purposes

| Section            | Purpose                  | Audience     |
| ------------------ | ------------------------ | ------------ |
| Quick Start        | Get running in 5 minutes | Everyone     |
| Core Concepts      | Understand how it works  | Beginners    |
| Use Cases          | See real applications    | Everyone     |
| Configuration      | Production-ready setup   | Intermediate |
| Advanced Patterns  | Optimize and scale       | Advanced     |
| Troubleshooting    | Fix common issues        | Everyone     |
| Limits & Quotas    | Know boundaries          | Architects   |
| Integration        | Connect services         | Architects   |
| Learning Resources | Go deeper                | Everyone     |

______________________________________________________________________

## :octicons-git-branch-16: Workflow

### 1. Research Phase

Before writing:

- Read AWS official docs
- Test commands in real account
- Check pricing page
- Search for common issues on Stack Overflow

### 2. Writing Phase

Follow template sections:

- Start with Quick Start (most impact)
- Add Core Concepts (foundation)
- Document 3-5 Use Cases (practical value)
- Fill Configuration (production-ready)
- Add Advanced if relevant (optional)
- Document Troubleshooting (from experience)

### 3. Review Phase

Before committing:

```bash
# Test locally
make serve

# Validate build
make build

# Check links
grep -r "](.*md)" docs/cloud/aws/yourfile.md

# Spell check (if pre-commit available)
codespell docs/cloud/aws/yourfile.md
```

### 4. Publish Phase

```bash
# Add to navigation
vim docs/cloud/aws/SUMMARY.md

# Stage changes
git add docs/cloud/aws/yourfile.md
git add docs/cloud/aws/SUMMARY.md

# Commit
git commit -m "docs: add AWS [SERVICE] reference

Complete documentation for AWS [SERVICE] including:
- Quick start commands and examples
- Core concepts and architecture
- Common use cases with code
- Security and cost optimization
- Troubleshooting guide

Co-Authored-By: Claude <noreply@anthropic.com>"
```

______________________________________________________________________

## :octicons-people-16: Getting Help

### From MkDocs Material Expert

```bash
/mkdocs-material-expert help with AWS template
/mkdocs-material-expert review my AWS doc
/mkdocs-material-expert add feature to template
```

### Resources

- **Template Files**:

    - `.claude/skills/mkdocs-material-expert/templates/AWS_SERVICE_TEMPLATE.md`
    - `.claude/skills/mkdocs-material-expert/templates/AWS_S3_EXAMPLE.md`
    - `.claude/skills/mkdocs-material-expert/templates/TEMPLATE_USAGE.md` (this file)

- **Material Theme Docs**: [squidfunk.github.io/mkdocs-material](https://squidfunk.github.io/mkdocs-material/)

- **Octicons**: [primer.style/foundations/icons](https://primer.style/foundations/icons)

- **AWS Docs**: [docs.aws.amazon.com](https://docs.aws.amazon.com/)

______________________________________________________________________

## :octicons-star-16: Examples in the Wild

Your project already has great examples:

- `docs/cloud/aws/index.md` - AWS overview page
- `docs/devops/index.md` - DevOps section structure
- `docs/containerization/kubernetes.md` - Technical deep-dive

**Copy patterns from these** for consistency!

______________________________________________________________________

## :octicons-note-16: Tips & Tricks

!!! tip "Pro Tips :octicons-light-bulb-16:"

    1. **Start with S3 example** - Copy and modify instead of blank template
    1. **Use real commands** - Test everything in AWS console first
    1. **Include costs** - Users ALWAYS care about pricing
    1. **Show Terraform** - Infrastructure-as-code is expected
    1. **Link related pages** - Create web of knowledge
    1. **Update regularly** - AWS changes fast, docs need maintenance

!!! warning "Common Mistakes :octicons-alert-16:"

    - Forgetting to test code examples
    - Using generic descriptions ("AWS service for compute")
    - Skipping security best practices section
    - Not linking to related services
    - Forgetting to add to SUMMARY.md navigation

______________________________________________________________________

**Created with** :octicons-heart-16: **by MkDocs Material Expert** **Version:** 2026.01
