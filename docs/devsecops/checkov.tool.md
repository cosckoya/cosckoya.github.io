---
title: Checkov
description: Open-source IaC scanner with ~1,400 built-in policies across Terraform, Kubernetes, CloudFormation and friends — plus secrets scanning and SCA
---

# :lucide-shield-check: Checkov

Checkov scans your Infrastructure-as-Code for misconfigurations before the cloud finds out about them. Roughly 1,400 built-in policies cover Terraform, OpenTofu, CloudFormation, Kubernetes, Helm, ARM/Bicep, serverless, and Dockerfiles — plus secrets scanning and SCA on top. Apache 2.0, built by Bridgecrew, maintained by Palo Alto Networks under Prisma Cloud. It is thorough, occasionally noisy, and still the cheapest security win in most pipelines.

!!! tip "2026 Update"
    tfsec is end-of-life: absorbed into Trivy's IaC scanner back in 2024, final release May 2025, zero new features since. If you are still running tfsec, migrate now. Worse: the March/April 2026 TeamPCP supply-chain attack compromised trivy-action and KICS Docker images (CVE-2026-33634). Pin GitHub Actions to full commit SHAs and container images to digests — @master and @latest are how attacks ship.

---

## Quick Hits

=== ":lucide-list-check: Essential Commands"

    ```bash
    # Install
    pip install checkov                                  # (1)!

    # Scan the whole repo — auto-detects frameworks
    checkov -d .                                         # (2)!

    # Scan one framework only
    checkov -d . --framework terraform                   # (3)!

    # CI gate — fail the build on HIGH severity and above
    checkov -d . --hard-fail-on HIGH                     # (4)!

    # Report-only pass while baselining
    checkov -d . --soft-fail

    # SARIF output for GitHub Code Scanning
    checkov -d . --output sarif > checkov.sarif
    ```

    1. Also available via Homebrew and the bridgecrew/checkov Docker image.
    2. Auto-detection is convenient; expect noise until suppressions are triaged.
    3. Cuts scan time and noise on single-framework repos.
    4. Start with `--soft-fail` for a sprint, then flip to hard-failing once the backlog is clean.

    **Real talk:**

    - Suppressions live inline in code: `# checkov:skip=CKV_AWS_20:<reason>` — greppable, reviewable, attributable.
    - Output formats cover CLI table, JSON, JUnit, CycloneDX SBOM, and SARIF for the Security tab.
    - Graph-based checks evaluate cross-resource relationships: a public S3 bucket attached to public-facing compute gets flagged as a compound finding, not two unrelated hits.

=== ":lucide-bolt: Common Patterns"

    Suppression lives where the finding does:

    ```hcl
    resource "aws_s3_bucket" "public_assets" { # checkov:skip=CKV_AWS_20:The bucket is public on purpose
      bucket = "my-cdn-assets"
    }
    ```

    Custom policies come in declarative YAML or Python classes:

    ```yaml
    metadata:
      id: CUSTOM_AWS_001
      name: S3 buckets must use customer-managed KMS keys
      category: ENCRYPTION
      severity: HIGH
    definition:
      cond_type: attribute
      resource_types:
        - aws_s3_bucket_server_side_encryption_configuration
      attribute: rule.apply_server_side_encryption_by_default.sse_algorithm
      operator: equals
      value: aws:kms
    ```

    **The 2026 open-source IaC scanner field** (all three support OpenTofu):

    | Scanner | Rules | Custom Policies | Best For |
    |---------|-------|-----------------|----------|
    | **Checkov** | ~1,400 | Python / YAML | Depth + graph-based compound checks |
    | **Trivy** (config mode) | ~1,000 | Rego | tfsec successor; fastest; broadest multi-mode |
    | **KICS** | ~2,400 | Rego | Widest format coverage incl Pulumi/Crossplane; noisiest |

    **Why this works:**

    - Inline skips appear in PR diffs with author and reason attached — no mystery suppressions.
    - Declarative YAML covers most org policies; drop to Python classes when logic gets complicated.
    - Graph checks catch compound exposure that per-resource scanners wave through.
    - Trivy and KICS are fine tools too — pick on rule depth versus noise tolerance, not hype.

=== ":material-fire: Pro Tips & Gotchas"

    **Tips:**

    - Baseline with `--soft-fail` for one sprint, then enforce with `--hard-fail-on HIGH` once the backlog is triaged.
    - Upload SARIF so findings land in the GitHub Security tab next to CodeQL — one triage queue instead of two.
    - Ship AI workloads? Add the AWS Bedrock, GCP Vertex AI, and Azure OpenAI policy packs (~47 AI-infrastructure checks added across 2025–2026).

    **Gotchas:**

    - The regex-based secrets scanner misses non-patterned credentials — pair it with trufflehog or gitleaks for verified detection.
    - Cross-module data flow analysis is weak; checks stay module-local, so exposures spanning modules slip past graph evaluation.
    - Pin bridgecrewio/checkov-action to a full commit SHA — the 2026 TeamPCP attack hit unpinned IaC-scanner actions.
    - tfsec ignores are NOT auto-migrated into Trivy or Checkov — re-triage every old suppression by hand.

---

## Reference

**Documentation:**

- :lucide-book: [Checkov Docs](https://www.checkov.io/1.Welcome/What%20is%20Checkov.html)
- :simple-github: [bridgecrewio/checkov](https://github.com/bridgecrewio/checkov)

**Related:**

- :lucide-wrench: __Terraform__
- :lucide-wrench: __tflint__

---

**Last Updated:** 2026-08-22 | **Vibe Check:** :lucide-globe: **Essential Guardrail** - The default IaC security scanner most teams should actually enforce rather than merely install.

**Tags:** iac, security, devsecops
