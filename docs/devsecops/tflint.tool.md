---
title: TFLint
description: Pluggable Terraform linter that catches provider-specific errors before they burn a plan cycle
---

# :lucide-scan-line: TFLint

TFLint catches what `terraform validate` shrugs off — invalid instance types, malformed ARNs, deprecated syntax — before you waste a plan cycle discovering them. It is a pluggable linter framework: core ships generic rules, and provider-specific rulesets load as separate plugins declared in `.tflint.hcl`. Cheap insurance against a typo costing an hour of CI.

!!! tip "2026 Update"
    v0.64.x is current (v0.64.0 shipped July 17, 2026), MPL-2.0 licensed under the terraform-linters org. Release verification moved to GitHub Artifact Attestations (`gh attestation verify`) — cosign signatures are deprecated. The official GitHub Action (`terraform-linters/setup-tflint`) tracks the v6.x line, and editor support comes via the built-in language server.

---

## Quick Hits

=== ":lucide-list-check: Essential Commands"

    ```bash
    # Install (Homebrew)
    brew install terraform-linters/tap/tflint            # (1)!

    # Download plugins declared in .tflint.hcl
    tflint --init                                        # (2)!

    # Lint the current directory
    tflint                                               # (3)!

    # Provider-aware checks — run AFTER terraform init so schemas load
    terraform init && tflint                             # (4)!

    # SARIF output for GitHub Code Scanning
    tflint --format sarif                                # (5)!
    ```

    1. No Homebrew? The install script from terraform-linters releases works on Linux and macOS.
    2. Nothing downloads until you ask — plugins are declared in config, fetched by `--init`.
    3. Generic core rules run without plugins or cloud access.
    4. Provider plugins resolve real schemas from the initialized environment — this catches invalid instance types and malformed ARNs.
    5. Formats available: default, compact, json, checkstyle, junit, sarif.

    **Real talk:**

    - Provider-aware checks require `terraform init` first; opt-in deep checks additionally need `deep_check = true` in the plugin block plus credentials.
    - Core rules alone catch generic HCL issues; the provider plugins catch everything interesting.
    - Verify downloaded binaries with `gh attestation verify` — cosign verification is dead as of 2026.

=== ":lucide-bolt: Common Patterns"

    A working `.tflint.hcl` — plugin plus rule tuning:

    ```hcl
    # .tflint.hcl
    plugin "aws" {
      enabled = true
      version = "0.x"     # pin an exact version — floating breaks builds
      source  = "github.com/terraform-linters/tflint-ruleset-aws"

      # deep_check = true  # opt-in API validation; requires AWS credentials
    }

    rule "terraform_deprecated_syntax" {
      enabled = true
    }

    rule "aws_instance_previous_type" {
      enabled = false     # legacy t2 fleet; re-enable after migration
    }
    ```

    Monorepo? Lint every module in one pass:

    ```bash
    tflint --recursive
    ```

    CI with SARIF upload to GitHub Code Scanning:

    ```yaml
    # .github/workflows/tflint.yml (excerpt)
    steps:
      - uses: terraform-linters/setup-tflint@v6   # official action (v6.x line)

      - run: tflint --init
      - name: Lint all modules
        run: tflint --recursive --format sarif > tflint.sarif

      # Upload tflint.sarif via github/codeql-action/upload-sarif
      # so findings land in the Security tab
    ```

    **Why this works:**

    - Plugin declarations make the toolchain explicit and auditable — no surprise downloads mid-build.
    - Rule blocks kill noise at the source instead of ignoring findings one by one.
    - `--recursive` replaces per-directory shell loops; module linting stays consistent across the tree.
    - Uploading SARIF via `github/codeql-action/upload-sarif` puts lint findings next to CodeQL results where triage already happens.

=== ":material-fire: Pro Tips & Gotchas"

    **Tips:**

    - Pin plugin versions in `.tflint.hcl` — unpinned plugins upgrade out from under CI without warning.
    - Run `--recursive` in monorepos instead of looping over directories with shell scripts.
    - Wire TFLint into pre-commit AND CI: pre-commit catches it locally, CI catches everyone who bypassed the hooks.

    **Gotchas:**

    - TFLint is a linter, not a security scanner — pair it with checkov or Trivy for policy and compliance findings.
    - Deep checks call the cloud API with your provider credentials — scope them read-only and plan auth for CI.
    - Plugin SDK mismatches break old custom plugins — anything built on the SDK v0.25 era needs rebuilding against the current SDK.

---

## Reference

**Documentation:**

- :lucide-book: [TFLint Docs](https://tflint.io)
- :simple-github: [terraform-linters/tflint](https://github.com/terraform-linters/tflint)

**Related:**

- :lucide-wrench: __checkov__
- :lucide-wrench: __Terraform__

---

**Last Updated:** 2026-08-22 | **Vibe Check:** :lucide-globe: **Cheap Insurance** - One config file catches the Terraform mistakes that otherwise surface as failed applies at the worst time.

**Tags:** iac, linter, terraform
