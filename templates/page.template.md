---
title: {{TITLE}}
description: {{DESCRIPTION}}
tags:
  - {{TAG_1}}
  - {{TAG_2}}
  - {{TAG_3}}
---

<!-- ═══════════════════════════════════════════════════════════════════════
     RENDERED EXAMPLE — Frontmatter
     ═══════════════════════════════════════════════════════════════════════

---
title: Amazon Web Services (AWS)
description: AWS reference — cloud platform running half the internet
tags:
  - aws
  - cloud
  - infrastructure
---

-->

<!-- ═══════════════════════════════════════════════════════════════════════
     SKELETON — Title and Introduction
     ═══════════════════════════════════════════════════════════════════════ -->

# {{TITLE_ICON}} {{TITLE}}

{{INTRO_PARAGRAPH}}

!!! tip "2026 Update"
    {{YEAR_UPDATE_NOTE}}

---

<!-- ═══════════════════════════════════════════════════════════════════════
     RENDERED EXAMPLE — Title and Introduction
     ═══════════════════════════════════════════════════════════════════════

# :lucide-cloud: Amazon Web Services (AWS)

Cloud platform that runs half the internet. 200+ services (you'll use maybe 10). The rest is either niche, deprecated, or bait for enterprise upsells.

!!! tip "2026 Update"
    AI-powered vulnerability discovery tools are changing cloud security. AWS GuardDuty now includes ML-based threat detection.

---

-->

<!-- ═══════════════════════════════════════════════════════════════════════
     SKELETON — Quick Hits (3 tabs)
     ═══════════════════════════════════════════════════════════════════════ -->

## Quick Hits

=== ":lucide-list-check: {{TAB_1_TITLE}}"

    ```{{CODE_LANGUAGE}}
    {{TAB_1_CODE_EXAMPLES}}
    ```

    **Real talk:**

    {{TAB_1_REAL_TALK}}

=== ":lucide-bolt: Common Patterns"

    ```{{CODE_LANGUAGE}}
    {{TAB_2_CODE_EXAMPLES}}
    ```

    **Why this works:**

    {{TAB_2_EXPLANATION}}

=== ":lucide-fire: Pro Tips & Gotchas"

    **Tips:**

    {{PRO_TIPS}}

    **Gotchas:**

    {{GOTCHAS}}

---

<!-- ═══════════════════════════════════════════════════════════════════════
     RENDERED EXAMPLE — Quick Hits > Tab 1: Essential
     ═══════════════════════════════════════════════════════════════════════

## Quick Hits

=== ":lucide-list-check: Essential AWS Services"

    ```bash
    # Configure AWS CLI
    aws configure                        # (1)!
    # List S3 buckets
    aws s3 ls                            # (2)!
    # Describe EC2 instances
    aws ec2 describe-instances --region us-east-1  # (3)!
    ```

    1. Configure access key, secret key, region, output format
    2. Lists all S3 buckets in the configured account
    3. Replace region with your target zone

    **Real talk:**
    - IAM is the hardest part of AWS. Spend time here.
    - Start with EC2, S3, RDS — 90% of use cases covered.
    - Use `aws configure sso` for team setups (more secure).

=== ":lucide-bolt: Common Patterns"

    !!! note "VPC Layout"
        Always use private subnets for databases, public subnets for load balancers.

    ```hcl
    resource "aws_s3_bucket" "data" {
      bucket = "my-app-data-${var.env}"
      acl    = "private"
    }
    ```

    | Service | Use Case | Cost Model |
    |---------|----------|------------|
    | EC2 | Compute | Per-hour instance |
    | S3 | Storage | Per-GB/month |
    | Lambda | Serverless | Per-invocation |

    **Why this works:**
    - Infrastructure as Code (Terraform) makes changes reviewable
    - Private subnets reduce attack surface
    - S3 with private ACL prevents accidental public exposure

=== ":lucide-fire: Pro Tips & Gotchas"

    **Tips:**
    - Use `aws s3 cp --recursive` for bulk operations
    - Enable S3 versioning before any production data goes in
    - Tag all resources (`Environment`, `Project`, `Owner`) for cost tracking
    - Use CloudFront + S3 for static hosting (cheaper than EC2)

    **Gotchas:**
    - S3 bucket names are **globally unique** — someone may have taken yours
    - Default VPC is not production-ready (no redundancy)
    - Removing S3 bucket with versioning enabled requires deleting all versions first
    - IAM changes can take 15+ minutes to propagate

---

=== ":lucide-list-check: Essential Commands"

    ```bash
    # Install dependencies
    source venv/bin/activate
    pip install -r requirements.txt

    # Run server with live reload
    zensical serve
    ```

    **Real talk:**
    - Always use virtual environments. No exceptions.
    - Lock your dependencies (pip freeze > requirements.txt).

=== ":lucide-bolt: Common Patterns"

    ```bash
    # One-line setup after cloning
    make venv && source venv/bin/activate && make deps
    ```

    **Why this works:**
    - Makefile abstracts complexity — new contributors don't need to know Python packaging
    - `make venv` + `make deps` is idempotent (safe to rerun)
    - CI and local dev use the same path

=== ":lucide-fire: Pro Tips & Gotchas"

    **Tips:**
    - Use `make validate` before every commit
    - Add `venv/` to `.gitignore` (it is — check first)
    - Pin Python 3.12 in `pyproject.toml` consistently

    **Gotchas:**
    - `zensical build --strict` fails on warnings — run this, not plain `zensical build`
    - Forgetting `source venv/bin/activate` means system Python — things WILL break

---

-->

<!-- ═══════════════════════════════════════════════════════════════════════
     SKELETON — Optional Sections
     ═══════════════════════════════════════════════════════════════════════ -->

{{OPTIONAL_INSTALL_SECTION}}

---

{{OPTIONAL_CONFIG_SECTION}}

---

{{OPTIONAL_SECTION_1_TITLE}}

{{OPTIONAL_SECTION_1_CONTENT}}

---

{{OPTIONAL_SECTION_2_TITLE}}

{{OPTIONAL_SECTION_2_CONTENT}}

---

<!-- ═══════════════════════════════════════════════════════════════════════
     RENDERED EXAMPLE — Installation (Content Actions)
     ═══════════════════════════════════════════════════════════════════════

## :lucide-sliders: Content Actions

Pages can have action buttons (edit/view source):

```yaml
features:
  - content.action.edit
  - content.action.view
```

---

## :lucide-circle-half-stroke: Dark & Light Mode

Toggling between dark (Purple theme) and light (Deep Purple + Teal) modes is built in:

```toml
[[theme.palette]]
  scheme = "slate"
  primary = "purple"
  accent = "lime"

[[theme.palette]]
  scheme = "default"
  primary = "deep purple"
  accent = "teal"
```

---

## :lucide-search: Zensical Features

### Disco Search
Search is built-in via Disco (Zensical's native search engine):
- Powered by client-side Rust indexing — no external search plugin
- Supports stemming, fuzzy matching, and URL-shared results

### GLightbox
Images open in a lightbox for full-size viewing. Powered by `zensical.extensions.glightbox`.

### Template Macros
Reusable content macros via `zensical.extensions.macros`. Define snippets once, include anywhere.

---

## :lucide-rocket: Performance Tips

- **Instant loading** — SPA-like navigation enabled via `navigation.instant`
- **Lazy load images** — Use proper alt text: `![Description](image.png){ alt="Detail" }`
- **Organize navigation** — Use explicit `nav:` in zensical.toml
- **Optimize images** — Compress, use WebP, set width/height
- **Cache-friendly URLs** — Zensical generates static URLs that leverage browser caching

---

-->

<!-- ═══════════════════════════════════════════════════════════════════════
     SKELETON — Reference
     ═══════════════════════════════════════════════════════════════════════ -->

## Reference

**Documentation:**

- :lucide-book: [Official Docs]({{DOCS_URL}})
- :lucide-github: [GitHub]({{GITHUB_URL}})

**Related:**

- :lucide-fire: __{{RELATED_1}}__
- :lucide-wrench: __{{RELATED_2}}__

---

<!-- ═══════════════════════════════════════════════════════════════════════
     RENDERED EXAMPLE — Reference
     ═══════════════════════════════════════════════════════════════════════

## Reference

**Documentation:**

- :lucide-book: [AWS Documentation](https://aws.amazon.com/documentation/)
- :simple-github: [AWS CLI GitHub](https://github.com/aws/aws-cli)
- :lucide-book: [Zensical Documentation](https://zensical.dev/)
- :simple-github: [cosckoya/cosckoya.github.io](https://github.com/cosckoya/cosckoya.github.io)

**Related:**

- :lucide-fire: __Cloud Security Best Practices__
- :lucide-wrench: __Terraform AWS Provider__

---

-->

<!-- ═══════════════════════════════════════════════════════════════════════
     SKELETON — Footer
     ═══════════════════════════════════════════════════════════════════════ -->

**Last Updated:** {{LAST_UPDATED}} | **Vibe Check:** {{VIBE_CHECK_ICON}} **{{VIBE_CHECK_TITLE}}** - {{VIBE_CHECK_DESC}}

**Tags:** {{TAG_1}}, {{TAG_2}}, {{TAG_3}}

---

<!-- ═══════════════════════════════════════════════════════════════════════
     RENDERED EXAMPLE — Footer
     ═══════════════════════════════════════════════════════════════════════

**Last Updated:** 2026-07-08 | **Vibe Check:** :lucide-globe: **Industry Standard** - AWS is the default cloud for most production workloads.

**Tags:** aws, cloud, infrastructure

-->
