---
title: Nuclei
description: fast, template-based vulnerability scanner by ProjectDiscovery
---

# :lucide-scan: Nuclei

Template-based vulnerability scanner. Write a YAML template, point it at a target, get findings in seconds. The community template repo is the real product.

!!! tip "2026 Update"
    Nuclei templates are now the de-facto standard for quick web vuln checks. Keep templates updated: `nuclei -update-templates`.

---

## Quick Hits

=== ":lucide-list-check: Essential Usage"
    ```bash
    # Scan a single target with all templates
    nuclei -u https://example.com

    # Scan a list of targets
    nuclei -l targets.txt -o results.txt

    # Only critical/high severity
    nuclei -u https://example.com -severity critical,high
    ```

    **Real talk:**
    - Templates are the value; keep them updated.
    - Rate-limit with `-rl` to avoid knocking over targets.
    - Always get authorization before scanning.

=== ":lucide-bolt: Common Patterns"
    ```bash
    # Tech detection + targeted templates
    nuclei -u https://example.com -tags cve,exposure

    # JSON output for pipelines
    nuclei -u https://example.com -json -o findings.json
    ```

    **Why this works:**
    - Tag-based filtering keeps noise down.
    - JSON output feeds triage/automation.

=== ":material-fire: Pro Tips & Gotchas"
    **Tips:**
    - Use `-interactsh` for OOB detection.
    - Pin template versions in CI for reproducibility.

    **Gotchas:**
    - Running all templates against production without rate limits = outage.
    - False positives happen; verify before reporting.

---

## Reference

- :lucide-book: [Nuclei Docs](https://docs.projectdiscovery.io/tools/nuclei)
- :simple-github: [projectdiscovery/nuclei](https://github.com/projectdiscovery/nuclei)

---

**Last Updated:** 2026-11-05 | **Vibe Check:** :lucide-globe: **Template Hunter** - fast scans, noisy if unfiltered.

**Tags:** security, tool, scanner