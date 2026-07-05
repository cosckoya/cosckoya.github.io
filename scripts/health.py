#!/usr/bin/env python3
"""Documentation health check: placeholders, orphaned pages, Vibe Check presence."""

import os
import re
import sys

DOCS = "docs"
IGNORED = {"index.md", "showcase.md", "robots.txt"}
EXCLUDE_DIRS = {"__pycache__", "templates"}
PLACEHOLDER_EXEMPT = {"index.md"}  # Documents template syntax intentionally
SUMMARY_ONLY = "SUMMARY.md"


def main():
    issues = 0
    print("=== Documentation Health Check ===\n")

    # --- Placeholder check ---
    print("--- Checking for unresolved placeholders ---")
    count = 0
    for root, dirs, files in os.walk(DOCS):
        dirs[:] = [d for d in dirs if d not in EXCLUDE_DIRS]
        for f in files:
            if not f.endswith(".md") or f == SUMMARY_ONLY:
                continue
            path = os.path.join(root, f)
            rel_path = os.path.relpath(path, DOCS)
            if rel_path in PLACEHOLDER_EXEMPT:
                continue
            content = open(path, encoding="utf-8").read()
            if "{{" not in content:
                continue
            lines = content.split("\n")
            inside_code_block = False
            for i, line in enumerate(lines):
                stripped = line.strip()
                if stripped.startswith("```"):
                    inside_code_block = not inside_code_block
                    continue
                if inside_code_block:
                    continue
                # Only flag uppercase {{PLACEHOLDER}} patterns, not {{.Values}} template syntax
                if re.search(r"\{\{[A-Z_]+}}", stripped):
                    rel = os.path.relpath(path, DOCS)
                    print(f"  PLACEHOLDER: {rel}:{i+1}")
                    issues += 1
                    count += 1
                    break
    if count == 0:
        print("  No unresolved placeholders found.")
    print()

    # --- Orphan check ---
    print("--- Checking for orphaned pages (not in any SUMMARY.md) ---")
    all_pages = set()
    for root, dirs, files in os.walk(DOCS):
        dirs[:] = [d for d in dirs if d not in EXCLUDE_DIRS]
        for f in files:
            if not f.endswith(".md") or f == SUMMARY_ONLY:
                continue
            rel = os.path.relpath(os.path.join(root, f), DOCS)
            if rel in IGNORED:
                continue
            all_pages.add(rel)

    referenced = set()
    for root, dirs, files in os.walk(DOCS):
        for f in files:
            if f != SUMMARY_ONLY:
                continue
            path = os.path.join(root, f)
            content = open(path, encoding="utf-8").read()
            for m in re.finditer(r"\]\(([^)]+)\)", content):
                link = m.group(1)
                if link.endswith(".md"):
                    full = os.path.normpath(os.path.join(os.path.dirname(path), link))
                    ref = os.path.relpath(full, DOCS)
                    referenced.add(ref)

    orphaned = sorted(all_pages - referenced)
    if orphaned:
        for p in orphaned:
            print(f"  ORPHAN: {p}")
            issues += 1
    else:
        print("  No orphaned pages found.")
    print()

    # --- Vibe Check check ---
    print("--- Checking Vibe Check presence ---")
    count = 0
    for root, dirs, files in os.walk(DOCS):
        dirs[:] = [d for d in dirs if d not in EXCLUDE_DIRS]
        for f in files:
            if not f.endswith(".md") or f == SUMMARY_ONLY or f in IGNORED:
                continue
            path = os.path.join(root, f)
            content = open(path, encoding="utf-8").read()
            if "Vibe Check" not in content:
                rel = os.path.relpath(path, DOCS)
                print(f"  MISSING Vibe Check: {rel}")
                issues += 1
                count += 1
    if count == 0:
        print("  All content pages have Vibe Check.")
    print()

    print(f"=== Health check complete: {issues} issue(s) found ===")
    return 0 if issues == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
