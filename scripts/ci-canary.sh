#!/usr/bin/env bash
set -euo pipefail

# CI Canary Script: Test Zensical build alongside existing MkDocs pipeline
# This is NON-BLOCKING — failures don't fail the CI run.
# Purpose: Detect Zensical compatibility issues early without disrupting production.

echo "::group::Install Zensical"
pip install zensical
echo "::endgroup::"

echo "::group::Zensical Build (Canary)"
echo "Testing: zensical build --strict"
zensical build --strict 2>&1 | tee /tmp/zensical-output.txt
EXIT_CODE=${PIPESTATUS[0]}

if [ $EXIT_CODE -eq 0 ]; then
  echo "✅ Zensical canary build PASSED"
else
  echo "⚠️ Zensical canary build FAILED (exit code: $EXIT_CODE)"
  echo "This is NON-BLOCKING — the site still deploys with MkDocs."
fi
echo "::endgroup::"

# Save output for artifact upload
cp /tmp/zensical-output.txt zensical-output.txt 2>/dev/null || true

exit 0
