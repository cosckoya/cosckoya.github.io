---
title: Prowler
description: Multi-cloud security auditing - CIS benchmarks, compliance checks, AWS/Azure/GCP/Kubernetes
---

# :octicons-shield-check-16: Prowler

Open-source cloud security tool for AWS, Azure, GCP, and Kubernetes. Industry standard for CIS benchmark compliance auditing. Generates detailed security reports with risk ratings. Command-line tool with HTML/JSON/CSV output. Python-based, actively maintained by Toni de la Fuente and community.

!!! tip "2026 Update"
    Prowler 4.x brings multi-cloud support (AWS/Azure/GCP/K8s). Dashboard UI available (self-hosted or SaaS). 400+ security checks. Integrates with CI/CD pipelines. GDPR, HIPAA, PCI-DSS compliance frameworks. Active community with monthly releases.

______________________________________________________________________

## :fontawesome-solid-bolt: Quick Hits

=== ":fontawesome-solid-list-check: Essential Commands"

    ```bash
    # Installation (Python pip)
    pip install prowler

    # Or via Homebrew (macOS/Linux)
    brew install prowler

    # Or use Docker
    docker pull prowler/prowler

    # AWS audit (uses default credentials)
    prowler aws

    # Specific AWS profile
    prowler aws --profile production

    # Specific AWS region
    prowler aws --region us-east-1

    # Azure audit
    prowler azure --sp-env-auth  # Service principal auth
    prowler azure --az-cli-auth   # Azure CLI auth

    # GCP audit
    prowler gcp --credentials-file credentials.json
    prowler gcp --project-id my-project

    # Kubernetes audit
    prowler kubernetes --kubeconfig ~/.kube/config

    # Run specific checks
    prowler aws --checks iam_user_mfa_enabled_console_access
    prowler aws --checks-file my-checks.txt

    # Exclude checks
    prowler aws --excluded-checks s3_bucket_public_access

    # Compliance frameworks
    prowler aws --compliance cis_1.5_aws  # CIS AWS Foundations Benchmark 1.5
    prowler aws --compliance pci_dss_v4.0
    prowler aws --compliance hipaa
    prowler aws --compliance gdpr

    # Output formats
    prowler aws --output-formats html json csv  # Multiple formats
    prowler aws --output-directory ./reports

    # Quiet mode (only failures)
    prowler aws --quiet

    # Severity filter (CRITICAL, HIGH, MEDIUM, LOW)
    prowler aws --severity critical high
    ```

    **Real talk:**

    - Default run scans ALL regions (takes 10-30 minutes)
    - HTML reports are readable and shareable with management
    - Use `--profile` to avoid accidentally scanning wrong account
    - Compliance frameworks filter checks to specific standards
    - CI/CD integration: exit code 0 = pass, non-zero = findings

=== ":fontawesome-solid-bolt: Common Patterns"

    ```bash
    # Daily security audit (production)
    prowler aws \
      --profile production \
      --compliance cis_1.5_aws \
      --severity critical high \
      --output-formats html json \
      --output-directory /var/reports/$(date +%Y-%m-%d)

    # Multi-account scan (AWS Organizations)
    for account in $(aws organizations list-accounts --query 'Accounts[?Status==`ACTIVE`].Id' --output text); do
      prowler aws \
        --role arn:aws:iam::$account:role/ProwlerRole \
        --output-directory ./reports/$account
    done

    # CI/CD integration (GitHub Actions example)
    name: Security Audit
    on:
      schedule:
        - cron: '0 2 * * *'  # Daily at 2 AM
    jobs:
      prowler:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v3
          - name: Run Prowler
            run: |
              pip install prowler
              prowler aws \
                --compliance cis_1.5_aws \
                --severity critical high \
                --output-formats json
          - name: Upload report
            uses: actions/upload-artifact@v3
            with:
              name: prowler-report
              path: output/

    # Docker execution (isolated environment)
    docker run --rm \
      -v ~/.aws/credentials:/root/.aws/credentials:ro \
      -v $(pwd)/reports:/output \
      prowler/prowler aws \
      --output-directory /output

    # Kubernetes security audit
    prowler kubernetes \
      --kubeconfig ~/.kube/config \
      --context production-cluster \
      --compliance cis_1.8_k8s \
      --output-formats html

    # Compare reports (track improvements)
    prowler aws --output-formats json --output-directory ./baseline
    # ... make security improvements ...
    prowler aws --output-formats json --output-directory ./current
    # Use prowler's comparison feature or custom scripts

    # Azure with service principal
    export AZURE_CLIENT_ID="xxx"
    export AZURE_CLIENT_SECRET="xxx"
    export AZURE_TENANT_ID="xxx"
    export AZURE_SUBSCRIPTION_ID="xxx"
    prowler azure --sp-env-auth --compliance cis_1.4_azure

    # GCP with project scanning
    prowler gcp \
      --credentials-file ~/gcp-credentials.json \
      --project-id my-project-123 \
      --compliance cis_1.3_gcp \
      --output-formats html json
    ```

    **Why this works:**

    - Scheduled scans catch drift from baseline
    - Multi-account scanning essential for AWS Organizations
    - Docker isolation prevents credential leakage
    - JSON output enables custom dashboards and alerting
    - Compliance frameworks map to audit requirements

=== ":fontawesome-solid-fire: Pro Tips & Gotchas"

    !!! success "Best Practices"
        - **Run daily** - Security posture changes, catch issues early
        - **Baseline first** - Initial scan = your starting point
        - **Filter by severity** - Critical/High only for executive reports
        - **Compliance frameworks** - Use CIS for general security, specific for audits
        - **Multi-account** - Scan all AWS accounts in organization
        - **Store reports** - Historical data shows security improvements
        - **Automate remediation** - Parse JSON output, auto-fix low-risk issues

    !!! warning "Authentication & Permissions"
        - **AWS IAM** - ReadOnlyAccess + SecurityAudit managed policies (minimum)
        - **Azure RBAC** - Security Reader role at subscription level
        - **GCP IAM** - Security Reviewer role at project level
        - **Kubernetes** - Cluster-admin or read-only with security context access
        - **Service accounts** - Use dedicated accounts with MFA for production
        - **Credential rotation** - Rotate Prowler service account keys regularly

    !!! tip "Integration & Automation"
        - **CI/CD** - Run on infrastructure changes (Terraform apply)
        - **Slack/Teams** - Send critical findings to security channel
        - **Jira/ServiceNow** - Create tickets for findings
        - **SIEM integration** - Parse JSON, send to Splunk/ELK
        - **Dashboards** - Grafana/Kibana for trending over time
        - **Custom checks** - Write Python checks for organization-specific policies

    !!! danger "Common Gotchas"
        - **API rate limits** - AWS throttling on large accounts (use `--slow-mode`)
        - **Long scan times** - Multi-region scans take 10-30 minutes
        - **False positives** - Review and exclude checks that don't apply
        - **Credential leaks** - Never commit AWS credentials in CI/CD configs
        - **Storage costs** - Reports accumulate, implement retention policy
        - **Permissions too broad** - Prowler only needs read access, not admin
        - **Compliance drift** - One-time scan isn't enough, automate

    !!! info "Prowler vs Alternatives"
        - **vs Scout Suite** - Prowler has more checks (400+ vs 200+)
        - **vs Cloud Custodian** - Prowler audits, Custodian remediates
        - **vs Checkov** - Prowler runtime, Checkov pre-deployment (IaC)
        - **vs AWS Security Hub** - Prowler open-source and multi-cloud
        - **Use together** - Checkov (IaC) + Prowler (runtime) = full coverage

______________________________________________________________________

## :fontawesome-solid-shield-halved: Compliance Frameworks

Prowler supports major compliance standards out-of-the-box:

### Available Frameworks

| Framework | Command | Description |
|-----------|---------|-------------|
| **CIS AWS 1.5** | `--compliance cis_1.5_aws` | Industry standard security baseline |
| **CIS Azure 1.4** | `--compliance cis_1.4_azure` | Azure security best practices |
| **CIS GCP 1.3** | `--compliance cis_1.3_gcp` | GCP security baseline |
| **CIS Kubernetes 1.8** | `--compliance cis_1.8_k8s` | Kubernetes security hardening |
| **PCI-DSS v4.0** | `--compliance pci_dss_v4.0` | Payment card industry standards |
| **HIPAA** | `--compliance hipaa` | Healthcare data protection |
| **GDPR** | `--compliance gdpr` | European data privacy |
| **SOC2** | `--compliance soc2` | Service organization controls |
| **ISO 27001** | `--compliance iso27001_2013` | Information security management |
| **NIST 800-53** | `--compliance nist_800_53_rev5` | Federal security controls |

### Custom Compliance Checks

```python
# Create custom check: checks/custom_check_example.py
from prowler.lib.check.models import Check, Check_Report

class custom_check_example(Check):
    def execute(self):
        findings = []
        # Your custom security logic here
        if security_issue_detected:
            findings.append(
                Check_Report(
                    status="FAIL",
                    status_extended="Security issue found",
                    resource_id="resource-id",
                    resource_arn="arn:aws:...",
                    region="us-east-1"
                )
            )
        return findings

# Use custom checks directory
prowler aws --checks-folder ./checks/custom/
```

______________________________________________________________________

## :fontawesome-solid-book: Learning Resources

### :fontawesome-solid-graduation-cap: Official Resources

- **[Prowler Documentation](https://docs.prowler.cloud/)** - Official docs
- **[GitHub Repository](https://github.com/prowler-cloud/prowler)** - Source code, issues
- **[Prowler Dashboard](https://dashboard.prowler.cloud/)** - SaaS UI (optional)
- **[YouTube Channel](https://www.youtube.com/@prowlercloud)** - Tutorials and demos

### :fontawesome-solid-code: Example Use Cases

!!! example "Daily Operations"
    - **Morning security check** - Run Prowler, review critical findings
    - **Pre-deployment audit** - Scan staging before production push
    - **Compliance reporting** - Generate monthly CIS benchmark reports
    - **Security metrics** - Track security posture improvements over time

!!! example "Incident Response"
    - **Breach investigation** - Identify misconfigurations that led to breach
    - **Post-incident** - Verify remediation, rescan affected accounts
    - **Audit trail** - Historical Prowler reports show security state at time of incident

!!! example "Enterprise Workflows"
    - **Multi-account governance** - Scan all AWS accounts daily
    - **Compliance audits** - SOC2/ISO27001 evidence collection
    - **Security KPIs** - Dashboard showing trend of critical findings
    - **DevSecOps** - Block deployments if Prowler finds critical issues

______________________________________________________________________

## :fontawesome-solid-star: Worth Checking

<div class="grid cards" markdown>

- :fontawesome-solid-book: __Official Docs__

    ______________________________________________________________________

    [Prowler Documentation](https://docs.prowler.cloud/)

    [GitHub Repository](https://github.com/prowler-cloud/prowler)

    [Checks Library](https://github.com/prowler-cloud/prowler/tree/master/prowler/providers)

- :fontawesome-solid-wrench: __Related Tools__

    ______________________________________________________________________

    [Prowler Dashboard](https://dashboard.prowler.cloud/)

    [Docker Images](https://hub.docker.com/r/prowler/prowler)

    [GitHub Actions](https://github.com/prowler-cloud/prowler-action)

- :fontawesome-solid-users: __Community__

    ______________________________________________________________________

    [Prowler Slack](https://join.slack.com/t/prowler-workspace/shared_invite/)

    [GitHub Discussions](https://github.com/prowler-cloud/prowler/discussions)

    [Twitter @prowlercloud](https://twitter.com/prowlercloud)

- :fontawesome-solid-code: __Integrations__

    ______________________________________________________________________

    [Terraform Module](https://github.com/prowler-cloud/terraform-prowler)

    [AWS Security Hub](https://docs.prowler.cloud/en/latest/tutorials/security-hub/)

    [CI/CD Examples](https://docs.prowler.cloud/en/latest/tutorials/cicd/)

</div>

______________________________________________________________________

**Last Updated:** 2026-02-02 | **Vibe Check:** :octicons-shield-check-16: **Industry Standard** - Prowler is THE tool for cloud security auditing. CIS benchmark compliance out-of-the-box. Multi-cloud support. Active development. If you're doing cloud security, you're using Prowler. Free and open-source beats expensive commercial tools.
**Tags:** prowler, security, cloud, compliance, cis
