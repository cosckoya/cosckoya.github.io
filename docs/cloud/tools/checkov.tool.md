---
title: Checkov
description: Infrastructure as Code security scanner - Terraform, CloudFormation, Kubernetes, Dockerfile auditing
---

# :fontawesome-solid-shield: Checkov

Static analysis tool for Infrastructure as Code (IaC). Scans Terraform, CloudFormation, Kubernetes, Dockerfile, ARM templates, Helm charts. 1000+ built-in policies. Prevents misconfigurations before deployment. Python-based, developed by Bridgecrew (acquired by Palo Alto Networks). Free and open-source.

!!! tip "2026 Update"
    Checkov 3.x brings AI-powered fix suggestions. Policy-as-code with custom Python policies. Supply chain security (SCA for Terraform modules). Secrets detection. IDE integrations (VSCode, IntelliJ). CI/CD native with exit codes. 1000+ policies covering CIS, PCI-DSS, HIPAA, SOC2.

______________________________________________________________________

## :fontawesome-solid-bolt: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # Installation (Python pip)
    pip install checkov

    # Or via Homebrew (macOS/Linux)
    brew install checkov

    # Or use Docker
    docker pull bridgecrew/checkov

    # Scan Terraform directory
    checkov --directory ./terraform

    # Scan specific file
    checkov --file main.tf

    # Scan CloudFormation
    checkov --framework cloudformation --file template.yaml

    # Scan Kubernetes manifests
    checkov --framework kubernetes --directory ./k8s

    # Scan Dockerfile
    checkov --framework dockerfile --file Dockerfile

    # Scan Helm charts
    checkov --framework helm --directory ./charts

    # Multiple frameworks
    checkov --framework terraform kubernetes dockerfile --directory .

    # Specific checks only
    checkov --check CKV_AWS_20,CKV_AWS_21 --directory .

    # Skip specific checks
    checkov --skip-check CKV_AWS_20 --directory .

    # Output formats
    checkov --directory . --output json
    checkov --directory . --output junitxml  # For CI/CD
    checkov --directory . --output sarif     # GitHub Code Scanning

    # Soft fail mode (warnings only, exit 0)
    checkov --directory . --soft-fail

    # Compact output (summary only)
    checkov --directory . --compact

    # Show suppressed checks
    checkov --directory . --show-suppressed

    # Baseline file (suppress existing issues)
    checkov --directory . --baseline baseline.json
    ```

    **Real talk:**

    - Run Checkov BEFORE `terraform apply` to catch issues early
    - Exit code 1 = failures found (use in CI/CD pipelines)
    - `--soft-fail` useful during initial adoption (don't block)
    - JSON output enables custom dashboards and reporting
    - Baseline files prevent legacy code from blocking new PRs

=== ":fontawesome-solid-bolt: Common Patterns"

    ```bash
    # Pre-commit hook integration
    # .pre-commit-config.yaml
    repos:
      - repo: https://github.com/bridgecrewio/checkov
        rev: 3.0.0
        hooks:
          - id: checkov
            args: [--quiet, --compact]

    # GitHub Actions workflow
    name: IaC Security Scan
    on: [push, pull_request]
    jobs:
      checkov:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v3
          - name: Run Checkov
            uses: bridgecrewio/checkov-action@master
            with:
              directory: terraform/
              framework: terraform
              output_format: sarif
              soft_fail: false  # Block on failures
          - name: Upload results to GitHub
            uses: github/codeql-action/upload-sarif@v2
            if: always()
            with:
              sarif_file: results.sarif

    # GitLab CI integration
    checkov:
      stage: security
      image: bridgecrew/checkov:latest
      script:
        - checkov --directory terraform/ --output junitxml > checkov-report.xml
      artifacts:
        reports:
          junit: checkov-report.xml
      allow_failure: false

    # Terraform workflow (local development)
    # 1. Write Terraform
    # 2. Run Checkov
    checkov --directory .

    # 3. Fix issues or suppress with inline comments
    # main.tf
    resource "aws_s3_bucket" "example" {
      # checkov:skip=CKV_AWS_20:Bucket is private, public access not needed
      bucket = "my-bucket"
    }

    # 4. Terraform plan and apply
    terraform plan
    terraform apply

    # CI/CD pipeline (Jenkins example)
    stage('Security Scan') {
      steps {
        sh 'pip install checkov'
        sh 'checkov --directory terraform/ --output junitxml > checkov.xml'
        junit 'checkov.xml'
      }
    }

    # Docker scan workflow
    # Scan Dockerfile before building image
    checkov --framework dockerfile --file Dockerfile
    docker build -t myapp:latest .

    # Kubernetes manifest validation
    checkov --framework kubernetes --directory k8s/ --compact
    kubectl apply -f k8s/

    # Multi-cloud IaC scan
    checkov \
      --framework terraform \
      --directory . \
      --check CKV_AWS_*,CKV_AZURE_*,CKV_GCP_* \
      --output json \
      --output-file-path results.json

    # Generate baseline (first-time adoption)
    checkov --directory . --output json > baseline.json
    # Edit baseline.json to suppress known issues
    checkov --directory . --baseline baseline.json
    ```

    **Why this works:**

    - Pre-commit hooks catch issues before commit
    - CI/CD integration blocks insecure code from merging
    - Inline suppressions with justifications (audit trail)
    - Baseline files enable gradual security improvements
    - SARIF format integrates with GitHub Security tab

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Run locally first** - Catch issues before CI/CD
        - **Pre-commit hooks** - Prevent bad code from being committed
        - **Inline suppressions** - Document why check is skipped
        - **Custom policies** - Write organization-specific checks (Python)
        - **Baseline files** - Don't block on legacy code, fix incrementally
        - **CI/CD gates** - Block PRs with security issues
        - **IDE integration** - Real-time feedback in VSCode/IntelliJ

    !!! warning "Security Coverage"
        - **Checks available:**
            - AWS: 300+ checks
            - Azure: 200+ checks
            - GCP: 150+ checks
            - Kubernetes: 100+ checks
            - Dockerfile: 50+ checks
        - **What Checkov catches:**
            - Public S3 buckets
            - Unencrypted resources
            - Overly permissive IAM policies
            - Missing security groups
            - Hardcoded secrets
            - Container vulnerabilities
        - **What Checkov misses:**
            - Runtime issues (use Prowler)
            - Application code vulnerabilities (use Snyk/SonarQube)
            - Network traffic analysis (use runtime tools)

    !!! tip "Custom Policies"
        ```python
        # checks/custom_policy.py
        from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck
        from checkov.common.models.enums import CheckResult, CheckCategories

        class CustomS3Check(BaseResourceCheck):
            def __init__(self):
                name = "Ensure S3 bucket has custom tag"
                id = "CKV_AWS_CUSTOM_1"
                supported_resources = ['aws_s3_bucket']
                categories = [CheckCategories.GENERAL_SECURITY]
                super().__init__(name=name, id=id, categories=categories,
                                supported_resources=supported_resources)

            def scan_resource_conf(self, conf):
                tags = conf.get('tags')
                if tags and isinstance(tags, list):
                    tag_dict = tags[0]
                    if 'Environment' in tag_dict:
                        return CheckResult.PASSED
                return CheckResult.FAILED

        # Use custom policy
        checkov --external-checks-dir ./checks --directory .
        ```

    !!! danger "Common Gotchas"
        - **False positives** - Some checks are opinionated, suppress if needed
        - **Performance** - Large Terraform codebases take 1-5 minutes
        - **Module scanning** - External modules not scanned (security blind spot)
        - **Secrets detection** - Basic, use dedicated tools (TruffleHog, GitGuardian)
        - **Cloud provider drift** - New services may lack checks initially
        - **CI/CD blocking** - Use `--soft-fail` during initial rollout
        - **Suppression abuse** - Audit suppressed checks regularly

    !!! info "Checkov vs Alternatives"
        - **vs Terraform Validate** - Checkov = security, validate = syntax
        - **vs Tfsec** - Checkov multi-framework, tfsec Terraform-only
        - **vs Prowler** - Checkov pre-deployment, Prowler post-deployment
        - **vs Snyk IaC** - Checkov open-source, Snyk commercial with SCA
        - **Use together** - Checkov (IaC) + Prowler (runtime) = full coverage

______________________________________________________________________

## :fontawesome-solid-code: Policy Examples

### Common Security Checks

```hcl
# FAIL: Public S3 bucket (CKV_AWS_18)
resource "aws_s3_bucket_acl" "bad" {
  bucket = aws_s3_bucket.example.id
  acl    = "public-read"  # Insecure!
}

# PASS: Private S3 bucket
resource "aws_s3_bucket_acl" "good" {
  bucket = aws_s3_bucket.example.id
  acl    = "private"
}

# FAIL: Unencrypted EBS volume (CKV_AWS_3)
resource "aws_ebs_volume" "bad" {
  availability_zone = "us-west-2a"
  size              = 40
  # Missing: encrypted = true
}

# PASS: Encrypted EBS volume
resource "aws_ebs_volume" "good" {
  availability_zone = "us-west-2a"
  size              = 40
  encrypted         = true
  kms_key_id        = aws_kms_key.example.arn
}

# FAIL: Security group allows all inbound (CKV_AWS_24)
resource "aws_security_group" "bad" {
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Open to world!
  }
}

# PASS: Restricted security group
resource "aws_security_group" "good" {
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]  # Internal only
  }
}

# Suppress check with justification
resource "aws_s3_bucket" "logs" {
  # checkov:skip=CKV_AWS_18:Log bucket requires public read for CloudFront
  bucket = "public-logs"
  acl    = "public-read"
}
```

### Kubernetes Security

```yaml
# FAIL: Container runs as root (CKV_K8S_23)
apiVersion: v1
kind: Pod
metadata:
  name: bad-pod
spec:
  containers:
  - name: nginx
    image: nginx
    # Missing securityContext

# PASS: Non-root container
apiVersion: v1
kind: Pod
metadata:
  name: good-pod
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
  containers:
  - name: nginx
    image: nginx
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
```

______________________________________________________________________

## :fontawesome-solid-book: Learning Resources

### :fontawesome-solid-graduation-cap: Official Resources

- **[Checkov Documentation](https://www.checkov.io/documentation)** - Official docs
- **[GitHub Repository](https://github.com/bridgecrewio/checkov)** - Source code, policies
- **[Policy Index](https://www.checkov.io/5.Policy%20Index/terraform.html)** - All built-in checks
- **[Bridgecrew Blog](https://bridgecrew.io/blog/)** - Tutorials and use cases

### :fontawesome-solid-code: Example Use Cases

!!! example "Development Workflow"
    - **Local scanning** - Run Checkov before committing code
    - **PR validation** - GitHub Actions scan on every pull request
    - **Terraform Cloud** - Run checks as part of plan workflow
    - **Security gates** - Block merges if critical issues found

!!! example "Compliance"
    - **CIS benchmarks** - Filter checks by CIS framework
    - **PCI-DSS** - Validate payment card compliance
    - **HIPAA** - Healthcare data protection validation
    - **SOC2** - Service organization controls audit prep

!!! example "Enterprise Adoption"
    - **Baseline creation** - Scan existing infrastructure, create baseline
    - **Gradual rollout** - Start with `--soft-fail`, tighten over time
    - **Custom policies** - Organization-specific security requirements
    - **Metrics dashboard** - Track security posture improvements

______________________________________________________________________

## :fontawesome-solid-star: Worth Checking

<div class="grid cards" markdown>

- :fontawesome-solid-book: __Official Docs__

    ______________________________________________________________________

    [Checkov Documentation](https://www.checkov.io/documentation)

    [GitHub Repository](https://github.com/bridgecrewio/checkov)

    [Policy Index](https://www.checkov.io/5.Policy%20Index/terraform.html)

- :fontawesome-solid-wrench: __Integrations__

    ______________________________________________________________________

    [VSCode Extension](https://marketplace.visualstudio.com/items?itemName=Bridgecrew.checkov)

    [GitHub Action](https://github.com/marketplace/actions/checkov-github-action)

    [Pre-commit Hook](https://github.com/bridgecrewio/checkov#pre-commit)

- :fontawesome-solid-users: __Community__

    ______________________________________________________________________

    [Bridgecrew Community](https://community.bridgecrew.io/)

    [GitHub Discussions](https://github.com/bridgecrewio/checkov/discussions)

    [Slack Channel](https://slack.bridgecrew.io/)

- :fontawesome-solid-code: __Learning__

    ______________________________________________________________________

    [Checkov Tutorial](https://www.checkov.io/1.Welcome/Quick%20Start.html)

    [Custom Policies Guide](https://www.checkov.io/3.Custom%20Policies/Python%20Custom%20Policies.html)

    [CI/CD Examples](https://www.checkov.io/4.Integrations/pre-commit.html)

</div>

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :fontawesome-solid-shield: **Essential DevSecOps** - Checkov is mandatory for modern IaC workflows. Catches security issues before deployment. 1000+ built-in policies. Free and open-source. Integrates seamlessly with CI/CD. If you're writing Terraform, you're running Checkov.
**Tags:** checkov, security, iac, terraform, kubernetes
