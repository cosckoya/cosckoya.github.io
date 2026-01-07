#!/bin/bash
#
# CLEANUP OBSOLETE FILES SCRIPT
#
# Purpose: Safely remove obsolete files from MkDocs refactoring
# Version: 1.0
# Date: 2026-01-07
# Author: Claude (The Shadow Architect)
#
# SAFETY FEATURES:
# - Dry-run mode by default (use --execute to actually delete)
# - Git status check (ensures clean working directory)
# - Backup creation before deletion
# - Detailed logging of all actions
# - Rollback instructions provided
#

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_ROOT="/home/cosckoya/hack/cosckoya.github.io"
BACKUP_BRANCH="backup-cleanup-$(date +%Y%m%d-%H%M%S)"
LOG_FILE="${PROJECT_ROOT}/cleanup.log"
DRY_RUN=true

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --execute)
            DRY_RUN=false
            shift
            ;;
        --help|-h)
            cat << EOF
USAGE: $0 [OPTIONS]

Safely remove obsolete files from the MkDocs refactoring.

OPTIONS:
    --execute    Actually delete files (default is dry-run)
    --help       Show this help message

DEFAULT BEHAVIOR:
    Without --execute, this script runs in DRY-RUN mode and only
    shows what would be deleted without actually removing anything.

SAFETY FEATURES:
    - Checks git status before running
    - Creates backup branch before deletion
    - Logs all actions
    - Provides rollback instructions

EXAMPLE:
    # Preview what would be deleted
    $0

    # Actually delete files
    $0 --execute

EOF
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Logging function
log() {
    local level=$1
    shift
    local message="$@"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "${timestamp} [${level}] ${message}" | tee -a "${LOG_FILE}"
}

# Print colored output
print_color() {
    local color=$1
    shift
    echo -e "${color}$@${NC}"
}

# Header
print_color "${BLUE}" "╔════════════════════════════════════════════════════════╗"
print_color "${BLUE}" "║   CLEANUP OBSOLETE FILES - MkDocs Refactoring         ║"
print_color "${BLUE}" "║   Version 1.0                                         ║"
print_color "${BLUE}" "╚════════════════════════════════════════════════════════╝"
echo ""

if [ "$DRY_RUN" = true ]; then
    print_color "${YELLOW}" "🔍 DRY-RUN MODE: No files will be deleted"
    print_color "${YELLOW}" "   Use --execute to actually delete files"
    echo ""
else
    print_color "${RED}" "⚠️  EXECUTE MODE: Files WILL be deleted!"
    print_color "${RED}" "   Press Ctrl+C within 5 seconds to cancel..."
    echo ""
    sleep 5
fi

# Change to project root
cd "${PROJECT_ROOT}" || {
    print_color "${RED}" "❌ Error: Cannot change to project root: ${PROJECT_ROOT}"
    exit 1
}

log "INFO" "Starting cleanup process in ${PROJECT_ROOT}"
if [ "$DRY_RUN" = true ]; then
    log "INFO" "Running in DRY-RUN mode"
else
    log "INFO" "Running in EXECUTE mode"
fi

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    print_color "${RED}" "❌ Error: Not in a git repository"
    exit 1
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD -- 2>/dev/null; then
    print_color "${YELLOW}" "⚠️  Warning: You have uncommitted changes"
    print_color "${YELLOW}" "   It's recommended to commit or stash them first"
    read -p "Continue anyway? (yes/no): " -r
    echo
    if [[ ! $REPLY =~ ^[Yy]es$ ]]; then
        print_color "${BLUE}" "Aborted by user"
        exit 0
    fi
fi

# Create backup branch if in execute mode
if [ "$DRY_RUN" = false ]; then
    print_color "${YELLOW}" "📦 Creating backup branch: ${BACKUP_BRANCH}"
    if git checkout -b "${BACKUP_BRANCH}"; then
        log "INFO" "Created backup branch: ${BACKUP_BRANCH}"
        git checkout -
    else
        print_color "${RED}" "❌ Error: Failed to create backup branch"
        exit 1
    fi
fi

# Arrays to store files and directories to delete
declare -a ANALYSIS_FILES
declare -a OBSOLETE_DIRS
declare -a TEMPLATE_FILES

# Define obsolete analysis files in root
ANALYSIS_FILES=(
    "ARCHITECTURE_ANALYSIS.md"
    "ARCHITECTURE_VISUAL.md"
    "MIGRATION_PLAN.md"
    "REFACTOR_EXECUTIVE_SUMMARY.md"
    "README_REFACTOR.md"
)

# Define obsolete sections
OBSOLETE_DIRS=(
    "docs/containers"
    "docs/security"
    "docs/monitoring"
    "docs/tools"
    "docs/code"
)

# Template files to review
TEMPLATE_FILES=(
    "TEMPLATE.md"
)

# Statistics
total_files=0
total_dirs=0
total_size=0

# Function to calculate directory size
get_dir_size() {
    local dir=$1
    if [ -d "$dir" ]; then
        du -sb "$dir" 2>/dev/null | cut -f1
    else
        echo "0"
    fi
}

# Function to format bytes
format_bytes() {
    local bytes=$1
    if [ $bytes -lt 1024 ]; then
        echo "${bytes}B"
    elif [ $bytes -lt 1048576 ]; then
        echo "$(( bytes / 1024 ))KB"
    else
        echo "$(( bytes / 1048576 ))MB"
    fi
}

# Section 1: Analysis Files
print_color "${BLUE}" "═══════════════════════════════════════════════════════"
print_color "${BLUE}" "1. ANALYSIS/PLANNING FILES (Root Directory)"
print_color "${BLUE}" "═══════════════════════════════════════════════════════"
echo ""

for file in "${ANALYSIS_FILES[@]}"; do
    if [ -f "$file" ]; then
        size=$(stat -c%s "$file" 2>/dev/null || echo "0")
        total_size=$((total_size + size))
        total_files=$((total_files + 1))

        print_color "${YELLOW}" "  📄 ${file} ($(format_bytes $size))"
        log "INFO" "Found analysis file: ${file} ($(format_bytes $size))"

        if [ "$DRY_RUN" = false ]; then
            if rm "$file"; then
                print_color "${GREEN}" "     ✓ Deleted"
                log "INFO" "Deleted: ${file}"
            else
                print_color "${RED}" "     ✗ Failed to delete"
                log "ERROR" "Failed to delete: ${file}"
            fi
        fi
    else
        print_color "${YELLOW}" "  ⊘ ${file} (not found)"
        log "INFO" "File not found: ${file}"
    fi
done

echo ""

# Section 2: Obsolete Directories
print_color "${BLUE}" "═══════════════════════════════════════════════════════"
print_color "${BLUE}" "2. OBSOLETE DOCUMENTATION SECTIONS"
print_color "${BLUE}" "═══════════════════════════════════════════════════════"
echo ""

for dir in "${OBSOLETE_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        size=$(get_dir_size "$dir")
        files_count=$(find "$dir" -type f | wc -l)
        total_size=$((total_size + size))
        total_dirs=$((total_dirs + 1))
        total_files=$((total_files + files_count))

        print_color "${YELLOW}" "  📁 ${dir}/ ($(format_bytes $size), ${files_count} files)"
        log "INFO" "Found obsolete directory: ${dir} ($(format_bytes $size), ${files_count} files)"

        # List contents
        print_color "${YELLOW}" "     Contents:"
        find "$dir" -type f -name "*.md" | while read -r file; do
            print_color "${YELLOW}" "       - ${file#$dir/}"
        done

        if [ "$DRY_RUN" = false ]; then
            if rm -rf "$dir"; then
                print_color "${GREEN}" "     ✓ Deleted"
                log "INFO" "Deleted directory: ${dir}"
            else
                print_color "${RED}" "     ✗ Failed to delete"
                log "ERROR" "Failed to delete: ${dir}"
            fi
        fi
    else
        print_color "${YELLOW}" "  ⊘ ${dir}/ (not found)"
        log "INFO" "Directory not found: ${dir}"
    fi
    echo ""
done

# Section 3: Template Files
print_color "${BLUE}" "═══════════════════════════════════════════════════════"
print_color "${BLUE}" "3. TEMPLATE FILES (Review Needed)"
print_color "${BLUE}" "═══════════════════════════════════════════════════════"
echo ""

for file in "${TEMPLATE_FILES[@]}"; do
    if [ -f "$file" ]; then
        size=$(stat -c%s "$file" 2>/dev/null || echo "0")

        print_color "${YELLOW}" "  📄 ${file} ($(format_bytes $size))"
        print_color "${YELLOW}" "     ⚠️  This file should be moved to docs/ or deleted manually"
        print_color "${YELLOW}" "     Skipping automatic deletion"
        log "INFO" "Template file found (not deleted): ${file}"
    else
        print_color "${YELLOW}" "  ⊘ ${file} (not found)"
    fi
done

echo ""

# Summary
print_color "${BLUE}" "═══════════════════════════════════════════════════════"
print_color "${BLUE}" "SUMMARY"
print_color "${BLUE}" "═══════════════════════════════════════════════════════"
echo ""

print_color "${GREEN}" "Files processed:      ${total_files}"
print_color "${GREEN}" "Directories removed:  ${total_dirs}"
print_color "${GREEN}" "Total space freed:    $(format_bytes $total_size)"
echo ""

if [ "$DRY_RUN" = true ]; then
    print_color "${YELLOW}" "🔍 DRY-RUN MODE: No files were actually deleted"
    print_color "${YELLOW}" ""
    print_color "${YELLOW}" "To actually delete these files, run:"
    print_color "${GREEN}" "    $0 --execute"
    echo ""
else
    print_color "${GREEN}" "✓ Cleanup completed successfully!"
    print_color "${GREEN}" ""
    print_color "${YELLOW}" "Backup branch created: ${BACKUP_BRANCH}"
    print_color "${YELLOW}" ""
    print_color "${BLUE}" "Next steps:"
    print_color "${BLUE}" "1. Verify the cleanup with: git status"
    print_color "${BLUE}" "2. Test the site with: mkdocs serve --strict"
    print_color "${BLUE}" "3. If everything works, commit: git add -A && git commit -m 'Remove obsolete files'"
    print_color "${BLUE}" ""
    print_color "${YELLOW}" "To rollback if needed:"
    print_color "${RED}" "    git reset --hard HEAD"
    print_color "${RED}" "    git checkout ${BACKUP_BRANCH}"
    echo ""
fi

log "INFO" "Cleanup process completed"
log "INFO" "Log file: ${LOG_FILE}"

# Final checks
print_color "${BLUE}" "═══════════════════════════════════════════════════════"
print_color "${BLUE}" "VERIFICATION COMMANDS"
print_color "${BLUE}" "═══════════════════════════════════════════════════════"
echo ""
print_color "${YELLOW}" "Check for broken links to deleted sections:"
print_color "${GREEN}" "    grep -r \"](containers/\" docs/ --include=\"*.md\""
print_color "${GREEN}" "    grep -r \"](security/\" docs/ --include=\"*.md\""
print_color "${GREEN}" "    grep -r \"](monitoring/\" docs/ --include=\"*.md\""
print_color "${GREEN}" "    grep -r \"](tools/\" docs/ --include=\"*.md\""
print_color "${GREEN}" "    grep -r \"](code/\" docs/ --include=\"*.md\""
echo ""
print_color "${YELLOW}" "Test the build:"
print_color "${GREEN}" "    mkdocs serve --strict"
echo ""

exit 0
