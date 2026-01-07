#!/bin/bash
# migrate-monitoring.sh
# Migrates monitoring/ to devops/monitoring-observability/

set -e

SOURCE="docs/monitoring"
DEST="docs/devops/monitoring-observability"

echo "================================================"
echo "Migrating monitoring/ to DevOps..."
echo "================================================"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if source exists
if [ ! -d "$SOURCE" ]; then
    echo -e "${RED}❌ Source directory $SOURCE does not exist${NC}"
    exit 1
fi

# Create destination directory
echo "📁 Creating destination directory..."
mkdir -p "$DEST"

# Copy index.md
if [ -f "$SOURCE/index.md" ]; then
    echo "📄 Copying index.md..."
    cp "$SOURCE/index.md" "$DEST/index.md"
    echo -e "${GREEN}✅ index.md copied${NC}"
else
    echo -e "${YELLOW}⚠️  No index.md found in source${NC}"
fi

# Copy SUMMARY.md
if [ -f "$SOURCE/SUMMARY.md" ]; then
    echo "📄 Copying SUMMARY.md..."
    cp "$SOURCE/SUMMARY.md" "$DEST/SUMMARY.md"
    echo -e "${GREEN}✅ SUMMARY.md copied${NC}"
else
    echo -e "${YELLOW}⚠️  No SUMMARY.md found in source${NC}"
fi

# Copy any other markdown files
echo "📄 Copying other markdown files..."
find "$SOURCE" -maxdepth 1 -name "*.md" ! -name "index.md" ! -name "SUMMARY.md" -exec cp {} "$DEST/" \;

# Copy subdirectories if they exist
if [ -d "$SOURCE/prometheus-grafana" ] || [ -d "$SOURCE/logging" ] || [ -d "$SOURCE/apm-tracing" ] || [ -d "$SOURCE/alerting" ]; then
    echo "📁 Copying subdirectories..."
    cp -r "$SOURCE"/* "$DEST/" 2>/dev/null || true
fi

echo ""
echo "🔄 Updating devops/SUMMARY.md..."
if [ ! -f "docs/devops/SUMMARY.md" ]; then
    cat > docs/devops/SUMMARY.md <<EOF
* [DevOps Overview](index.md)
* [Monitoring & Observability](monitoring-observability/)
EOF
    echo -e "${GREEN}✅ Created devops/SUMMARY.md${NC}"
else
    # Check if monitoring is already in SUMMARY
    if ! grep -q "monitoring-observability" docs/devops/SUMMARY.md; then
        echo "* [Monitoring & Observability](monitoring-observability/)" >> docs/devops/SUMMARY.md
        echo -e "${GREEN}✅ Added monitoring to devops/SUMMARY.md${NC}"
    else
        echo -e "${YELLOW}⚠️  Monitoring already in devops/SUMMARY.md${NC}"
    fi
fi

echo ""
echo "================================================"
echo -e "${GREEN}✅ Migration completed!${NC}"
echo "================================================"
echo ""
echo "Next steps:"
echo "1. Review migrated content in: $DEST"
echo "2. Update cross-references in other sections:"
echo "   - sysadmin/index.md → link to devops/monitoring-observability/"
echo "   - containerizacion/monitoring/ → link to devops/monitoring-observability/"
echo "3. Test build: ./scripts/test-build.sh"
echo "4. After verification, delete old directory:"
echo "   git rm -rf $SOURCE"
echo ""
echo -e "${YELLOW}⚠️  Manual review required before deleting source directory${NC}"
