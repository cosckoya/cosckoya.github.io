---
title: Cloud Security
description: CSPM, CWPP, CNAPP - Cloud security posture management, workload protection, and the tools that find your misconfigurations
tags:
  - cloud-security
  - cspm
  - cwpp
  - wiz
  - security
---

# Cloud Security

Cloud Security Posture Management (CSPM), Cloud Workload Protection (CWPP), and Cloud-Native Application Protection (CNAPP). Tools that scan your cloud for misconfigurations, vulnerabilities, and compliance issues. Because manual audits don't scale.

______________________________________________________________________

## Quick Hits

=== "🎯 Essential Concepts"

    **CSPM (Cloud Security Posture Management):**

    - Scans cloud config for misconfigurations
    - Compliance checks (CIS, PCI-DSS, HIPAA)
    - Asset inventory and visibility
    - Examples: Wiz, Prisma Cloud, AWS Security Hub

    **CWPP (Cloud Workload Protection Platform):**

    - Runtime protection for VMs, containers
    - Vulnerability scanning
    - Malware detection
    - Examples: Aqua, Sysdig, Trend Micro

    **CNAPP (Cloud-Native Application Protection Platform):**

    - CSPM + CWPP + more
    - Full stack cloud security
    - Dev to runtime protection
    - Examples: Wiz, Palo Alto Prisma, Lacework

    **Real talk:**

    - Public S3 buckets = most common breach
    - Over-permissive IAM roles everywhere
    - Most companies fail CIS benchmarks
    - These tools find issues fast, fixing takes time

=== "⚡ Common Issues Found"

    **Storage Misconfigurations:**

    - Public S3/Blob/GCS buckets
    - Unencrypted storage
    - No versioning or backup
    - Overly broad access policies

    **IAM/Access Issues:**

    - Admin privileges to service accounts
    - No MFA on root accounts
    - Unused IAM users/roles
    - Keys in code repositories

    **Network Exposure:**

    - Security groups allowing 0.0.0.0/0
    - Databases exposed to internet
    - Unencrypted traffic
    - No network segmentation

    **Compliance Failures:**

    - Missing encryption at rest
    - No audit logging
    - Weak password policies
    - Non-compliant regions (GDPR)

=== "🔥 Pro Tips & Gotchas"

    - **Start with free tools:** AWS Security Hub, Azure Defender, GCP Security Command Center
    - **Prioritize:** Not all findings are critical, focus on high/critical first
    - **Automate remediation:** Use Cloud Custodian, AWS Config Rules
    - **Shift left:** Scan IaC (Terraform, CloudFormation) before deploy
    - **Runtime protection:** CSPM finds config issues, CWPP protects running workloads
    - **Alert fatigue:** Too many alerts = ignored alerts, tune carefully
    - **Cost:** Enterprise CSPM tools are expensive ($100k+/year)
    - **False positives:** Expect them, especially in dev environments
    - **When NOT to use:** Pre-revenue startups (free tier tools enough)

______________________________________________________________________

## Learning Paths

### 🎓 Free Resources

- **[AWS Security Best Practices](https://aws.amazon.com/architecture/security-identity-compliance/)** - Official AWS guide
- **[Azure Security Benchmark](https://learn.microsoft.com/en-us/security/benchmark/azure/)** - Microsoft's best practices
- **[GCP Security Best Practices](https://cloud.google.com/security/best-practices)** - Google's recommendations
- **[CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks)** - Industry standards (free download)
- **[OWASP Cloud Security](https://owasp.org/www-project-cloud-security/)** - Cloud security project

### 🧪 Interactive Labs

- **[AWS Security Workshops](https://workshops.aws/categories/Security)** - Hands-on security scenarios
- **[Azure Security Labs](https://azuresecuritylab.com/)** - Practice environments
- **[CloudGoat](https://github.com/RhinoSecurityLabs/cloudgoat)** - Vulnerable AWS environment

### 📜 Certifications Worth It

- **[AWS Security Specialty](https://aws.amazon.com/certification/certified-security-specialty/)** - $300, worth it for security-focused roles
- **[CCSP (Certified Cloud Security Professional)](https://www.isc2.org/Certifications/CCSP)** - $600, vendor-neutral, respected
- **Skip**: Cloud provider security associate certs - learn by doing

### 🚀 Projects to Build

- **Beginner:** Run CIS benchmark scan on your AWS account, fix top 10 issues
- **Intermediate:** Implement automated remediation with Cloud Custodian
- **Advanced:** Build multi-cloud security dashboard aggregating AWS/Azure/GCP findings

______________________________________________________________________

## Community Pulse

### 🐦 Who to Follow

**Twitter/X:**

- [@wiz_io](https://twitter.com/wiz_io) - Wiz official, cloud security platform
- [@CloudSecGuy](https://twitter.com/CloudSecGuy) - Chris Hughes, cloud security expert
- **[@ramimac](https://twitter.com/ramimac)** - Rami McCarthy, AWS security
- [@Scott_Piper](https://twitter.com/Scott_Piper) - Cloud security researcher
- [@0xdabbad00](https://twitter.com/0xdabbad00) - Scott Piper (Duo Security)

**YouTube:**

- [Cloud Security Podcast](https://www.youtube.com/@cloudsecuritypodcast) - Weekly cloud security news
- [AWS Security](https://www.youtube.com/awssecurityinfo) - Official AWS security content
- [fwd:cloudsec](https://www.youtube.com/c/fwdcloudsec) - Cloud security conference talks

### 💬 Active Communities

- **[r/cloudsecurity](https://reddit.com/r/cloudsecurity)** - 20k+ cloud security discussions
- **[Cloud Security Alliance](https://cloudsecurityalliance.org/)** - Industry organization
- **[AWS Security Community](https://discord.gg/aws)** - #security channel
- **[OWASP Slack](https://owasp.org/slack/invite)** - #cloud-security channel

### 🎙️ Podcasts & Newsletters

- **[Cloud Security Podcast](https://cloudsecuritypodcast.tv/)** - Weekly, Google-hosted
- **[Darknet Diaries](https://darknetdiaries.com/)** - Security stories (some cloud)
- **[tl;dr sec](https://tldrsec.com/)** - Security newsletter, cloud section
- **[Wiz Blog](https://www.wiz.io/blog)** - Cloud security research

### 🎪 Events & Conferences

- **[fwd:cloudsec](https://fwdcloudsec.org/)** - Annual cloud security conference, free
- **[AWS re:Inforce](https://reinforce.awsevents.com/)** - AWS security conference
- **[RSA Conference](https://www.rsaconference.com/)** - Major security event, cloud track

______________________________________________________________________

## Worth Checking

<div class="grid cards" markdown>

- 📚 __Official Stuff__

    ______________________________________________________________________

    [AWS Security Hub](https://aws.amazon.com/security-hub/)

    [Azure Defender](https://azure.microsoft.com/en-us/services/defender-for-cloud/)

    [GCP Security Command Center](https://cloud.google.com/security-command-center)

    [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks)

- 🧪 __Hands-on__

    ______________________________________________________________________

    [CloudGoat](https://github.com/RhinoSecurityLabs/cloudgoat)

    [AWS Security Workshops](https://workshops.aws/categories/Security)

    [ScoutSuite](https://github.com/nccgroup/ScoutSuite)

- 💻 __CSPM Tools__

    ______________________________________________________________________

    [Wiz](https://www.wiz.io/)

    [Prisma Cloud (Palo Alto)](https://www.paloaltonetworks.com/prisma/cloud)

    [Lacework](https://www.lacework.com/)

    [Orca Security](https://orca.security/)

- 🔥 __Open Source Tools__

    ______________________________________________________________________

    [Cloud Custodian](https://cloudcustodian.io/)

    [Prowler](https://github.com/prowler-cloud/prowler)

    [ScoutSuite](https://github.com/nccgroup/ScoutSuite)

    [Cloudsploit](https://github.com/aquasecurity/cloudsploit)

- 🛠️ __IaC Security__

    ______________________________________________________________________

    [tfsec](https://github.com/aquasecurity/tfsec)

    [Checkov](https://www.checkov.io/)

    [Terrascan](https://github.com/tenable/terrascan)

    [Snyk IaC](https://snyk.io/product/infrastructure-as-code-security/)

- 📰 __News & Research__

    ______________________________________________________________________

    [Wiz Blog](https://www.wiz.io/blog)

    [Cloud Security Alliance](https://cloudsecurityalliance.org/research/)

    [r/cloudsecurity](https://reddit.com/r/cloudsecurity)

</div>

______________________________________________________________________

## CSPM Tools Comparison

| Tool                 | Type  | Pricing | Best For                                |
| -------------------- | ----- | ------- | --------------------------------------- |
| **Wiz**              | CNAPP | $$$$    | Enterprises, agentless, comprehensive   |
| **Prisma Cloud**     | CNAPP | $$$$    | Palo Alto customers, multi-cloud        |
| **Lacework**         | CNAPP | $$$$    | Runtime protection, anomaly detection   |
| **Orca Security**    | CNAPP | $$$$    | Agentless, fast deployment              |
| **AWS Security Hub** | CSPM  | $$/Free | AWS-only, native integration            |
| **Azure Defender**   | CNAPP | $$      | Azure-focused, good for Microsoft shops |
| **GCP SCC**          | CSPM  | $/Free  | GCP-only, included with GCP             |
| **Prowler**          | CSPM  | Free    | Open-source, AWS/Azure/GCP              |
| **ScoutSuite**       | CSPM  | Free    | Multi-cloud, lightweight                |

______________________________________________________________________

## Open Source Security Tools

### Prowler (AWS/Azure/GCP/Kubernetes)

```bash
# Install
pip3 install prowler

# Scan AWS
prowler aws

# Scan specific checks
prowler aws --checks iam_user_mfa_enabled,s3_bucket_public_access

# Generate HTML report
prowler aws --output-formats html

# Multi-account scanning
prowler aws --profile prod
```

**What it finds:**

- CIS benchmark violations
- IAM misconfigurations
- Public resources
- Encryption issues
- Logging gaps

### Cloud Custodian (Policy as Code)

```yaml
# policies.yml
policies:
  - name: stop-untagged-instances
    resource: ec2
    filters:
      - "tag:Owner": absent
    actions:
      - stop

  - name: encrypt-unencrypted-s3
    resource: s3
    filters:
      - type: bucket-encryption
        state: false
    actions:
      - type: encrypt
        key: aws/s3

  - name: require-mfa-delete
    resource: s3
    filters:
      - type: bucket-versioning
        status: Enabled
      - type: bucket-versioning
        mfa-delete: Disabled
    actions:
      - type: notify
        template: default
        to:
          - security@company.com
```

```bash
# Run policies
custodian run -s out policies.yml

# Dry run (no actions)
custodian run --dryrun -s out policies.yml
```

### tfsec (Terraform Security Scanner)

```bash
# Install
brew install tfsec

# Scan current directory
tfsec .

# Scan with sarif output (for CI/CD)
tfsec . --format sarif > tfsec-results.sarif

# Exclude checks
tfsec . --exclude-check aws-s3-enable-versioning
```

**Example finding:**

```
Result: aws-s3-enable-bucket-encryption
────────────────────────────────────────
Bucket does not have encryption enabled

  main.tf:10-14

   7 | resource "aws_s3_bucket" "example" {
   8 |   bucket = "my-bucket"
   9 |
  10 |   # No encryption block
  11 | }
```

______________________________________________________________________

## CIS Benchmark Checks

### Top 10 Critical Checks

1. **IAM - MFA on root account**

    ```bash
    aws iam get-account-summary | grep AccountMFAEnabled
    ```

1. **IAM - No access keys for root**

    ```bash
    aws iam get-account-summary | grep AccountAccessKeysPresent
    ```

1. **S3 - Block public access**

    ```bash
    aws s3api get-public-access-block --bucket BUCKET_NAME
    ```

1. **EC2 - No security group allows 0.0.0.0/0 on port 22/3389**

    ```bash
    aws ec2 describe-security-groups \
      --filters Name=ip-permission.cidr,Values='0.0.0.0/0'
    ```

1. **CloudTrail - Enabled in all regions**

    ```bash
    aws cloudtrail describe-trails
    ```

1. **S3 - Bucket logging enabled**

    ```bash
    aws s3api get-bucket-logging --bucket BUCKET_NAME
    ```

1. **VPC - Flow logs enabled**

    ```bash
    aws ec2 describe-flow-logs
    ```

1. **IAM - Password policy enforced**

    ```bash
    aws iam get-account-password-policy
    ```

1. **KMS - Key rotation enabled**

    ```bash
    aws kms get-key-rotation-status --key-id KEY_ID
    ```

1. **Config - Enabled in all regions**

    ```bash
    aws configservice describe-configuration-recorders
    ```

______________________________________________________________________

## Automated Remediation

### AWS Config Rules (Auto-Remediate)

```yaml
# Automated remediation example
ConfigRule:
  Type: AWS::Config::ConfigRule
  Properties:
    ConfigRuleName: s3-bucket-public-read-prohibited
    Source:
      Owner: AWS
      SourceIdentifier: S3_BUCKET_PUBLIC_READ_PROHIBITED

RemediationConfiguration:
  Type: AWS::Config::RemediationConfiguration
  Properties:
    ConfigRuleName: s3-bucket-public-read-prohibited
    Automatic: true
    MaximumAutomaticAttempts: 5
    RetryAttemptSeconds: 60
    TargetType: SSM_DOCUMENT
    TargetIdentifier: AWS-PublishSNSNotification
```

### Cloud Custodian Auto-Remediation

```yaml
# Stop instances missing required tags after 7 days
policies:
  - name: tag-compliance-terminate
    resource: ec2
    filters:
      - "tag:Owner": absent
      - type: marked-for-op
        op: terminate
        skew: 7
    actions:
      - type: mark-for-op
        op: terminate
        days: 7
      - type: notify
        template: default
        subject: "Instance {{ resource.id }} will be terminated in 7 days"
```

______________________________________________________________________

**Last Updated:** 2026-01-14 **Vibe Check:** 🔥 **Hyped** - Cloud security is exploding. Wiz raised $1B+, every cloud breach makes headlines. CSPM/CNAPP tools going mainstream. Still expensive, but ROI is clear after first breach prevented.
