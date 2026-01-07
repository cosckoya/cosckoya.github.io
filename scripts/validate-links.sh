#!/bin/bash
# validate-links.sh
# Validates internal links and checks for references to deleted sections

set -e

BASE_DIR="docs"
ERRORS=0

echo "================================================"
echo "Validating internal links..."
echo "================================================"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo ""
echo "🔍 Checking for links to deleted tools/ directory..."
TOOLS_LINKS=$(grep -r "](tools/" "${BASE_DIR}/" --include="*.md" 2>/dev/null || true)
if [ -n "$TOOLS_LINKS" ]; then
    echo -e "${RED}❌ Found links to deleted tools/ directory:${NC}"
    echo "$TOOLS_LINKS"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✅ No links to tools/${NC}"
fi

echo ""
echo "🔍 Checking for links to deleted code/ directory..."
CODE_LINKS=$(grep -r "](code/" "${BASE_DIR}/" --include="*.md" 2>/dev/null || true)
if [ -n "$CODE_LINKS" ]; then
    echo -e "${RED}❌ Found links to deleted code/ directory:${NC}"
    echo "$CODE_LINKS"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✅ No links to code/${NC}"
fi

echo ""
echo "🔍 Checking for links to old monitoring/ location..."
OLD_MONITORING=$(grep -r "](monitoring/" "${BASE_DIR}/" --include="*.md" 2>/dev/null | grep -v "devops/monitoring-observability" || true)
if [ -n "$OLD_MONITORING" ]; then
    echo -e "${YELLOW}⚠️  Found links to old monitoring/ location:${NC}"
    echo "$OLD_MONITORING"
    echo -e "${YELLOW}These should point to devops/monitoring-observability/${NC}"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✅ No links to old monitoring/${NC}"
fi

echo ""
echo "🔍 Checking for relative links that may be broken..."
RELATIVE_LINKS=$(grep -rE "\]\(\.\./" "${BASE_DIR}/" --include="*.md" | grep -E "(404|notfound)" || true)
if [ -n "$RELATIVE_LINKS" ]; then
    echo -e "${RED}❌ Found potentially broken relative links:${NC}"
    echo "$RELATIVE_LINKS"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}✅ No obvious broken relative links${NC}"
fi

echo ""
echo "🔍 Checking for TODO markers in content..."
TODO_COUNT=$(grep -r "TODO" "${BASE_DIR}/" --include="*.md" | wc -l)
if [ "$TODO_COUNT" -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Found ${TODO_COUNT} TODO markers${NC}"
    echo "Run: grep -r 'TODO' docs/ --include='*.md' | head -20"
else
    echo -e "${GREEN}✅ No TODO markers${NC}"
fi

echo ""
echo "🔍 Checking for missing SUMMARY.md files..."
MISSING_SUMMARY=0
for section in sysadmin cloud devops ciberseguridad containerizacion inteligencia-artificial; do
    if [ ! -f "${BASE_DIR}/${section}/SUMMARY.md" ]; then
        echo -e "${RED}❌ Missing ${section}/SUMMARY.md${NC}"
        MISSING_SUMMARY=$((MISSING_SUMMARY + 1))
    fi
done
if [ "$MISSING_SUMMARY" -eq 0 ]; then
    echo -e "${GREEN}✅ All SUMMARY.md files present${NC}"
else
    ERRORS=$((ERRORS + 1))
fi

echo ""
echo "================================================"
if [ ${ERRORS} -eq 0 ]; then
    echo -e "${GREEN}✅ All validations passed!${NC}"
    echo "================================================"
    exit 0
else
    echo -e "${RED}❌ Found ${ERRORS} validation errors${NC}"
    echo "================================================"
    echo ""
    echo "Please fix these issues before proceeding."
    exit 1
fi
