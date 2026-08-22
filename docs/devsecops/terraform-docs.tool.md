---
title: terraform-docs
description: Generate module documentation straight from Terraform source and inject it into READMEs automatically
---

# :lucide-file-text: terraform-docs

Hand-written input tables rot the moment someone adds a variable and forgets the README. terraform-docs parses your Terraform source — inputs, outputs, providers, modules, resources — and generates documentation in whatever format your project speaks. Run it via pre-commit or CI and documentation stops being optional homework nobody grades.

!!! tip "2026 Update"
    v0.24.0 is current, MIT licensed. The tooling story is boringly stable — `.terraform-docs.yml` config, inject mode, recursive mode, a maintained pre-commit hook, and the official terraform-docs/gh-actions action. Which means stale module READMEs are now a choice, not an accident.

---

## Quick Hits

=== ":lucide-list-check: Essential Commands"

    ```bash
    # Install (Homebrew)
    brew install terraform-docs

    # Generate straight to stdout
    terraform-docs markdown table ./modules/vpc          # (1)!

    # Inject docs between HTML markers in the README
    terraform-docs markdown table \
      --output-file README.md \
      --output-mode inject ./modules/vpc                 # (2)!
    ```

    1. Formats: markdown table/document, AsciiDoc, JSON/YAML/XML/TOML, pretty, tfvars hcl
    2. Inject mode writes between marker comments — everything outside them stays untouched

    Inject mode looks for these markers in the target file:

    ```markdown
    <!-- BEGIN_TF_DOCS -->
    Generated content lands here — never hand-edit it
    <!-- END_TF_DOCS -->
    ```

    **Real talk:**

    - The config file is `.terraform-docs.yml`, searched in module root, then `.config/`, then cwd, then `$HOME/.tfdocs.d/`.
    - `formatter:` is the one REQUIRED key — everything else has sane defaults.
    - Header content comes from description comments in main.tf via `header-from`; write descriptions once per variable and stop duplicating them.

=== ":lucide-bolt: Common Patterns"

    Minimal config — enough for most modules:

    ```yaml
    # .terraform-docs.yml
    formatter: markdown table        # required key

    output:
      file: README.md
      mode: inject

    sort:
      enabled: true
      by: name

    sections:
      hide: []
    ```

    Enforce it locally with pre-commit:

    ```yaml
    # .pre-commit-config.yaml
    repos:
      - repo: https://github.com/terraform-docs/terraform-docs
        rev: "v0.24.0"
        hooks:
          - id: terraform-docs-go
    ```

    Backstop contributors who skipped hooks — regenerate and push docs on every PR:

    ```yaml
    # .github/workflows/docs.yml
    name: terraform-docs
    on:
      pull_request:

    permissions:
      contents: write                # git-push needs a token with write access

    jobs:
      docs:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v5            # pin to a commit SHA in production
          - uses: terraform-docs/gh-actions@v1   # pin to a commit SHA in production
            with:
              working-dir: modules/vpc
              output-file: README.md
              output-method: inject
              git-push: "true"
    ```

    **Why this works:**

    - Docs regenerate from source, so they cannot drift — reviewers see doc diffs in the same PR that changed the module.
    - Inject mode preserves hand-written prose around the markers; automation touches only its own section.
    - Pre-commit keeps local clones fresh, and the workflow catches everyone who used `--no-verify`.

=== ":material-fire: Pro Tips & Gotchas"

    **Tips:**

    - Document-as-you-go: generated tables beat hand-written input lists that rot within two sprints.
    - Write each variable description once in source — `header-from` pulls description comments into the generated header.
    - Use recursive mode for monorepo module trees: one command documents every module underneath.

    **Gotchas:**

    - Never hand-edit content between BEGIN_TF_DOCS / END_TF_DOCS markers — the next run clobbers it without asking.
    - Broken or removed markers fail silently: inject changes nothing and exits fine. Check the diff.
    - Commit the generated docs — docs-as-code means reviewers actually see documentation changes in PRs instead of trusting a wiki.
    - The gh-action's `git-push: "true"` needs a token with write permissions, otherwise the job exits green having pushed nothing.

---

## Reference

**Documentation:**

- :lucide-book: [terraform-docs](https://terraform-docs.io)
- :simple-github: [terraform-docs/terraform-docs](https://github.com/terraform-docs/terraform-docs)

**Related:**

- :lucide-wrench: __Terraform__
- :lucide-wrench: __tflint__

---

**Last Updated:** 2026-08-22 | **Vibe Check:** :lucide-globe: **Zero-Effort Docs** - Module documentation that maintains itself beats every wiki page that ever quietly rotted.

**Tags:** iac, documentation, terraform
