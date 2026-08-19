---
title: Spectral
description: Stoplight Spectral — linting OpenAPI specs for API design and security, with custom rulesets
---

# :lucide-shield-check: Spectral

Stoplight Spectral is the linter for API contracts. It reads your OpenAPI (or AsyncAPI) spec and flags design smells, security gaps, and consistency violations before they ship. Think of it as ruff, but for `openapi.json`. The default ruleset is decent; the real power is writing your own.

!!! tip "2026 Update"
    Spectral remains the standard for OpenAPI linting. Rulesets are reusable across repos via NPM packages, and the CLI drops cleanly into any CI pipeline.

---

## Quick Hits

=== ":lucide-list-check: Essential Commands"

    ```bash
    # Install (Node)
    npm install -g @stoplight/spectral-cli

    # Lint a spec with the default ruleset
    spectral lint openapi.json

    # Lint with a custom ruleset
    spectral lint openapi.yaml -r .spectral.yaml
    ```

    **Real talk:**
    - Run it in CI on every PR that touches a spec
    - Fail the build on `error` severity, warn on the rest
    - `-r` points at your ruleset; defaults are fine for a first pass

=== ":lucide-bolt: Custom Rulesets"

    ```yaml
    # .spectral.yaml
    extends: ["spectral:oas", "spectral:oas-ruleset"]

    rules:
      no-numeric-ids:
        description: IDs must be UUIDs or strings, not integers
        given: $.paths.*.*.parameters[?(@.name == 'id')]
        severity: error
        then:
          field: schema
          function: pattern
          functionOptions:
            match: "^string$|^integer.*format: uuid$"

      security-defined:
        description: Every path must have a security scheme
        given: "$.paths[*][*]"
        severity: warn
        then:
          function: defined
          field: security
    ```

    **Why this works:**
    - Rules use JSONPath to target spec locations (`given`)
    - `function: defined/undefined/pattern` cover most checks
    - Custom rules make the linter enforce *your* standards, not Stoplight's

=== ":material-fire: Pro Tips & Gotchas"

    **Tips:**
    - Package your ruleset (`@scope/spectral-rules`) and reuse across teams
    - Use `spectral lint --fail-severity error` in CI to block bad specs
    - Pair with the OpenAPI Generator to catch drift between spec and code

    **Gotchas:**
    - Default ruleset doesn't check security — add OWASP-style rules yourself
    - JSONPath in `given` is finicky; test rules against a real spec first
    - Spectral won't catch a spec that doesn't match the implemented API — that's contract testing's job

---

## Reference

**Documentation:**

- :lucide-book: [Spectral Docs](https://meta.stoplight.io/docs/spectral/)
- :simple-github: [Spectral GitHub](https://github.com/stoplightio/spectral)
- :simple-openapiinitiative: [OpenAPI Specification](https://spec.openapis.org/oas/latest.html)

**Related:**

- :simple-fastapi: __Python API Development__ — FastAPI generates specs worth linting

---

**Last Updated:** 2026-08-20 | **Vibe Check:** :lucide-shield-check: **Essential Guardrail** - Spectral is the standard tool for catching API contract problems before they ship.

**Tags:** api, security, openapi