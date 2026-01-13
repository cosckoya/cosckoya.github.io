#!/usr/bin/env bash
# DocMaster Tools - Automation scripts for MkDocs documentation maintenance
# Project: cosckoya.github.io
# Created: 2026-01-13

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project root
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOCS_DIR="$PROJECT_ROOT/docs"

# Helper functions
info() { echo -e "${BLUE}ℹ${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warning() { echo -e "${YELLOW}⚠${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1"; }

# Check if in project root
if [ ! -f "$PROJECT_ROOT/mkdocs.yml" ]; then
    error "Must be run from project root. mkdocs.yml not found."
    exit 1
fi

# ======================
# SKILL 1: Check Links
# ======================
check_links() {
    info "Checking link integrity..."

    local broken_count=0
    local checked_count=0

    # Find all markdown links
    while IFS= read -r file; do
        while IFS= read -r link; do
            checked_count=$((checked_count + 1))

            # Extract link path
            link_path=$(echo "$link" | sed -n 's/.*(\([^)]*\)).*/\1/p')

            # Skip external links
            if [[ "$link_path" =~ ^https?:// ]]; then
                continue
            fi

            # Resolve relative path
            file_dir=$(dirname "$file")
            target="$file_dir/$link_path"

            # Handle directory links (literate-nav convention)
            if [[ "$link_path" == */ ]]; then
                target="${target}index.md"
            fi

            # Check if target exists
            if [ ! -f "$target" ] && [ ! -d "${target%/}" ]; then
                error "Broken link in $file: $link_path"
                broken_count=$((broken_count + 1))
            fi
        done < <(grep -o '\[.*\](.*\.md)' "$file" 2>/dev/null || true)
    done < <(find "$DOCS_DIR" -name "*.md")

    if [ $broken_count -eq 0 ]; then
        success "All $checked_count links are valid"
    else
        error "Found $broken_count broken links out of $checked_count checked"
        return 1
    fi
}

# ======================
# SKILL 2: Find Orphans
# ======================
find_orphans() {
    info "Finding orphaned documents..."

    local orphan_count=0

    # Find all markdown files except SUMMARY.md
    while IFS= read -r file; do
        filename=$(basename "$file")

        # Skip special files
        if [[ "$filename" == "index.md" ]] || [[ "$filename" == "bookmarks.md" ]]; then
            continue
        fi

        # Check if referenced in any SUMMARY.md
        if ! grep -q "$(basename "$file")" "$DOCS_DIR"/**/SUMMARY.md 2>/dev/null; then
            warning "Orphaned: $file"
            orphan_count=$((orphan_count + 1))
        fi
    done < <(find "$DOCS_DIR" -name "*.md" ! -name "SUMMARY.md")

    if [ $orphan_count -eq 0 ]; then
        success "No orphaned documents found"
    else
        warning "Found $orphan_count orphaned documents"
    fi
}

# ======================
# SKILL 3: Validate Structure
# ======================
validate_structure() {
    info "Validating documentation structure..."

    local issues=0

    # Check for SUMMARY.md in first-level directories
    for dir in "$DOCS_DIR"/*/; do
        dir_name=$(basename "$dir")

        # Skip resources directory
        if [ "$dir_name" == "resources" ]; then
            continue
        fi

        if [ ! -f "${dir}SUMMARY.md" ]; then
            error "Missing SUMMARY.md in $dir_name/"
            issues=$((issues + 1))
        fi

        if [ ! -f "${dir}index.md" ]; then
            error "Missing index.md in $dir_name/"
            issues=$((issues + 1))
        fi
    done

    # Check main SUMMARY.md exists
    if [ ! -f "$DOCS_DIR/SUMMARY.md" ]; then
        error "Missing main docs/SUMMARY.md"
        issues=$((issues + 1))
    fi

    # Check main index.md exists
    if [ ! -f "$DOCS_DIR/index.md" ]; then
        error "Missing main docs/index.md"
        issues=$((issues + 1))
    fi

    if [ $issues -eq 0 ]; then
        success "Documentation structure is valid"
    else
        error "Found $issues structural issues"
        return 1
    fi
}

# ======================
# SKILL 4: Cleanup Empty Directories
# ======================
cleanup_empty() {
    info "Finding empty directories..."

    local empty_dirs
    empty_dirs=$(find "$DOCS_DIR" -type d -empty)

    if [ -z "$empty_dirs" ]; then
        success "No empty directories found"
        return 0
    fi

    local count=0
    while IFS= read -r dir; do
        warning "Removing empty directory: $dir"
        rmdir "$dir"
        count=$((count + 1))
    done <<< "$empty_dirs"

    success "Removed $count empty directories"
}

# ======================
# SKILL 5: Audit Freshness
# ======================
audit_freshness() {
    info "Auditing content freshness..."

    local old_threshold=180  # 6 months
    local old_count=0

    # Find files older than threshold
    info "Files not modified in $old_threshold days:"
    while IFS= read -r file; do
        warning "Old: $file ($(stat -c %y "$file" | cut -d' ' -f1))"
        old_count=$((old_count + 1))
    done < <(find "$DOCS_DIR" -name "*.md" -mtime +$old_threshold)

    if [ $old_count -eq 0 ]; then
        success "All content is relatively fresh"
    else
        warning "Found $old_count files older than $old_threshold days"
    fi

    # Find TODO markers
    info "Finding TODO markers..."
    local todo_count=0
    while IFS= read -r line; do
        warning "TODO: $line"
        todo_count=$((todo_count + 1))
    done < <(grep -rn "TODO\|FIXME\|XXX" "$DOCS_DIR" 2>/dev/null || true)

    if [ $todo_count -eq 0 ]; then
        success "No TODO markers found"
    else
        warning "Found $todo_count TODO markers"
    fi
}

# ======================
# SKILL 6: Build Validator
# ======================
validate_build() {
    info "Validating MkDocs build..."

    # Check if venv exists
    if [ -d "$PROJECT_ROOT/venv" ]; then
        source "$PROJECT_ROOT/venv/bin/activate"
    fi

    # Check if mkdocs is available
    if ! command -v mkdocs &> /dev/null; then
        error "mkdocs not found. Install with: pip install -r requirements.txt"
        return 1
    fi

    # Run strict build
    if mkdocs build --strict --quiet; then
        success "MkDocs build successful"
    else
        error "MkDocs build failed"
        return 1
    fi
}

# ======================
# SKILL 7: Check Style
# ======================
check_style() {
    info "Checking markdown style..."

    # Check if markdownlint is available
    if ! command -v markdownlint &> /dev/null; then
        warning "markdownlint not installed. Install with: npm install -g markdownlint-cli"
        return 0
    fi

    if markdownlint "$DOCS_DIR" -c "$PROJECT_ROOT/.markdownlint.json"; then
        success "Markdown style check passed"
    else
        error "Markdown style issues found"
        return 1
    fi
}

# ======================
# SKILL 8: Full Maintenance
# ======================
full_maintenance() {
    info "Running full maintenance check..."
    echo ""

    local failed=0

    # Run all checks
    validate_structure || failed=$((failed + 1))
    echo ""

    cleanup_empty || failed=$((failed + 1))
    echo ""

    find_orphans || failed=$((failed + 1))
    echo ""

    check_links || failed=$((failed + 1))
    echo ""

    audit_freshness || failed=$((failed + 1))
    echo ""

    validate_build || failed=$((failed + 1))
    echo ""

    if [ $failed -eq 0 ]; then
        success "✨ All maintenance checks passed!"
    else
        error "❌ $failed maintenance checks failed"
        return 1
    fi
}

# ======================
# HELP
# ======================
show_help() {
    cat << EOF
DocMaster Tools - MkDocs Documentation Maintenance

Usage: $0 <command>

Commands:
    check-links         Check all internal links for validity
    find-orphans        Find documents not referenced in SUMMARY.md
    validate-structure  Validate documentation structure and conventions
    cleanup-empty       Remove all empty directories
    audit-freshness     Find old content and TODO markers
    validate-build      Run mkdocs build --strict
    check-style         Run markdownlint on all markdown files
    full-maintenance    Run all maintenance checks
    help                Show this help message

Examples:
    $0 check-links
    $0 cleanup-empty
    $0 full-maintenance

Documentation:
    See DOCMASTER.md for full agent documentation
EOF
}

# ======================
# MAIN
# ======================
main() {
    if [ $# -eq 0 ]; then
        show_help
        exit 0
    fi

    case "$1" in
        check-links)
            check_links
            ;;
        find-orphans)
            find_orphans
            ;;
        validate-structure)
            validate_structure
            ;;
        cleanup-empty)
            cleanup_empty
            ;;
        audit-freshness)
            audit_freshness
            ;;
        validate-build)
            validate_build
            ;;
        check-style)
            check_style
            ;;
        full-maintenance)
            full_maintenance
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            error "Unknown command: $1"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

main "$@"
