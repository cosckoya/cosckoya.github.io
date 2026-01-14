#!/bin/bash
# test-build.sh
# Tests MkDocs build in strict mode and validates serve works

set -e

echo "================================================"
echo "Testing MkDocs build and serve..."
echo "================================================"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if mkdocs is installed
if ! command -v mkdocs &> /dev/null; then
    echo -e "${RED}❌ mkdocs is not installed${NC}"
    echo "Install with: pip install -r requirements.txt"
    exit 1
fi

echo ""
echo "🏗️  Testing build with strict mode..."
if mkdocs build --strict --clean; then
    echo -e "${GREEN}✅ Build successful!${NC}"
else
    echo -e "${RED}❌ Build failed!${NC}"
    echo "Fix errors above before proceeding."
    exit 1
fi

echo ""
echo "🔍 Checking for warnings in build output..."
WARNINGS=$(mkdocs build 2>&1 | grep -i "warning" || true)
if [ -n "$WARNINGS" ]; then
    echo -e "${YELLOW}⚠️  Found warnings:${NC}"
    echo "$WARNINGS"
    echo ""
    echo -e "${YELLOW}Consider fixing these warnings${NC}"
else
    echo -e "${GREEN}✅ No warnings${NC}"
fi

echo ""
echo "🌐 Testing serve (5 seconds)..."
# Start mkdocs serve in background
mkdocs serve > /dev/null 2>&1 &
SERVE_PID=$!

# Wait for server to start
sleep 3

# Test if server is responding
if curl -s http://127.0.0.1:8000/ > /dev/null; then
    echo -e "${GREEN}✅ Serve is working!${NC}"
    echo "Local site accessible at: http://127.0.0.1:8000/"
else
    echo -e "${RED}❌ Serve failed to respond${NC}"
    kill $SERVE_PID 2>/dev/null || true
    exit 1
fi

# Clean up
kill $SERVE_PID 2>/dev/null || true

echo ""
echo "📊 Build statistics:"
echo "-------------------"
echo "Total markdown files: $(find docs -name '*.md' | wc -l)"
echo "Total directories: $(find docs -type d | wc -l)"
echo "Build output size: $(du -sh site 2>/dev/null | cut -f1 || echo 'N/A')"

echo ""
echo "================================================"
echo -e "${GREEN}✅ All tests passed!${NC}"
echo "================================================"
echo ""
echo "Site is ready for deployment."
