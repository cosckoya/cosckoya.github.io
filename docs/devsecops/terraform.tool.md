---
title: Terraform
description: the de-facto infrastructure-as-code standard — declare desired state in HCL and Terraform diffs it against reality; the state file is the actual job
---

# :lucide-layers: Terraform

Terraform is the de-facto infrastructure-as-code standard: declare desired state in HCL, and Terraform diffs it against reality to work out the create, update, and destroy calls. The HCL is the easy part. The actual job is state management — where the state lives, who locks it, and how badly your week goes when two engineers apply concurrently.

!!! tip "2026 Update"
    Current stable is v1.15.8 (July 8, 2026). Anything labelled 1.16.0-alpha on the downloads page is a pre-release, not stable — stop installing it by accident. HashiCorp is now an IBM company and Terraform remains BSL 1.1 licensed: free to manage your own infrastructure, restricted if you want to build a competing hosted offering. Only the two newest release lines get fixes — currently 1.15.x and 1.14.x; the 1.13 line went EOL on April 29, 2026.

---

## Quick Hits

=== ":lucide-list-check: Essential Commands"

    ```bash
    # Install mise once — one manager for every tool in this section
    curl https://mise.run | sh                                # (1)!
    mise use -g terraform@1.15.8                              # (2)!

    # Per-project pin — mise writes .mise.toml, commit it
    mise use terraform@1.15.8                                 # (3)!

    # Core workflow
    terraform fmt -recursive                                  # (4)!
    terraform init                                            # (5)!
    terraform validate
    terraform plan -out=tfplan                                # (6)!
    terraform apply tfplan                                    # (7)!
    ```

    1. Linux-first installer — lands in `~/.local/bin`, no root required; activate your shell afterwards (`mise activate zsh`).
    2. Global default lives in `~/.config/mise/config.toml`.
    3. Project-local pin replaces the old `.terraform-version` file convention — one `.mise.toml` can pin terraform AND tflint together.
    4. Normalizes formatting so style diffs never appear in code review.
    5. Downloads providers and writes `.terraform.lock.hcl` — COMMIT IT.
    6. Saves the plan so what gets applied is exactly what was reviewed.
    7. Applies the saved plan byte-for-byte instead of re-planning against a possibly changed world.

    **Real talk:**

    - Always plan before apply, and save the plan file (`-out=`) so CI applies exactly what was reviewed.
    - `.terraform.lock.hcl` pins provider checksums — commit it.
    - Run `terraform version` in CI to catch version drift early.

=== ":lucide-bolt: Common Patterns"

    Pin the core and the providers together:

    ```hcl
    terraform {
      required_version = "~> 1.15"

      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 6.0"   # AWS provider v6.x is current in 2026
        }
      }
    }
    ```

    Remote state with locking — non-negotiable for teams:

    ```hcl
    terraform {
      backend "s3" {
        bucket         = "myorg-tfstate"
        key            = "prod/network.tfstate"
        region         = "eu-west-1"
        dynamodb_table = "tf-locks"
        encrypt        = true
      }
    }
    ```

    Native tests since 1.6 — no external framework required:

    ```hcl
    # tests/naming.tftest.hcl
    run "naming_convention" {
      command = plan

      assert {
        condition     = startswith(aws_s3_bucket.logs.bucket, "myorg-")
        error_message = "Buckets must follow the myorg- naming convention"
      }
    }
    ```

    **Why this works:**

    - `~>` constraints allow patch and minor updates within a release line while blocking major-bump surprises.
    - The lockfile makes CI runs reproducible — every machine resolves identical provider versions.
    - Tests catch logic errors before plan, while fixes are still cheap.

=== ":material-fire: Pro Tips & Gotchas"

    **Tips:**

    - Keep state small — split by blast radius so one bad apply cannot take down everything at once.
    - Use ephemeral values (1.10+) and write-only arguments (1.11+) instead of shoving secrets through variables.
    - Try list resources plus `terraform query` (1.14) for cloud inventory queries without touching state.
    - 1.15 adds dynamic module sources, deprecated markers on variables/outputs, and `convert()`.

    **Gotchas:**

    - State files contain PLAINTEXT secrets — encrypt the backend bucket and restrict IAM hard.
    - State is stamped with the writer's version, older binaries REFUSE newer state, and upgrades are one-way.
    - Never edit state by hand — use `terraform state mv`, `terraform state rm`, or `import`.
    - Stacks (GA late 2025) is an HCP Terraform feature — you do not get it from the OSS binary.

---

## Terraform vs OpenTofu (2026)

In August 2023 HashiCorp relicensed Terraform from MPL 2.0 to BSL 1.1; the community forked the last-MPL code into OpenTofu under the Linux Foundation, and both have shipped since. Three years later the split is boring in the good way:

| Aspect | Terraform | OpenTofu |
|--------|-----------|----------|
| License | BSL 1.1 | MPL 2.0 |
| Governance | IBM / HashiCorp | Linux Foundation |
| State encryption | Backend-side only | Native client-side encryption built-in |
| Registry | registry.terraform.io | registry.opentofu.org + TF-compatible |
| Orchestration extras | Stacks (GA late 2025) — HCP-only | None — use Terragrunt and friends |
| Binary name | terraform | tofu |

Both support ephemeral resources through independent implementations, and the provider ecosystem is largely shared — AWS provider v6.x works with both. For typical configs, migration amounts to renaming the binary in CI.

Choosing between them:

- Need Stacks, HCP Terraform, Sentinel, or commercial support → Terraform.
- Need an OSI-approved license, client-side state encryption (regulated industries), or vendor independence → OpenTofu.
- Everyone else → either works. Pick once, document it, move on.

---

## Reference

**Documentation:**

- :lucide-book: [Terraform Docs](https://developer.hashicorp.com/terraform)
- :simple-github: [hashicorp/terraform](https://github.com/hashicorp/terraform)
- :lucide-book: [Release Archives](https://releases.hashicorp.com/terraform/)
- :lucide-book: [OpenTofu](https://opentofu.org)
- :lucide-book: [endoflife.date/terraform](https://endoflife.date/terraform)

**Related:**

- :lucide-wrench: __tflint__
- :lucide-wrench: __checkov__
- :lucide-wrench: __terraform-docs__

---

**Last Updated:** 2026-08-22 | **Vibe Check:** :lucide-globe: **Industry Standard** - still the default IaC choice; just mind the license and the EOL window.

**Tags:** iac, devsecops, terraform
