#!/usr/bin/env bash
# RepoJanitor - The Sarcastic Repository Cleaner
# Project: cosckoya.github.io
# Created: 2026-01-13

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Project root
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Janitor personality
info() { echo -e "${BLUE}🧹${NC} $1"; }
success() { echo -e "${GREEN}✨${NC} $1"; }
warning() { echo -e "${YELLOW}⚠️${NC}  $1"; }
error() { echo -e "${RED}💀${NC} $1"; }
sassy() { echo -e "${PURPLE}🎭${NC} $1"; }

# Check if in project root
if [ ! -f "$PROJECT_ROOT/mkdocs.yml" ]; then
    error "Must be run from project root. Where's your mkdocs.yml?"
    exit 1
fi

# ======================
# INSPECTION FUNCTIONS
# ======================

inspect() {
    info "RepoJanitor starting full inspection..."
    sassy "Buckle up, this might hurt your feelings."
    echo ""

    local issues=0

    # File statistics
    info "📊 Gathering repository statistics..."
    local total_files=$(git ls-files | wc -l)
    local md_files=$(git ls-files "*.md" | wc -l)
    local py_files=$(git ls-files "*.py" | wc -l)
    local repo_size=$(du -sh .git | cut -f1)

    echo "   Total files: $total_files"
    echo "   Markdown files: $md_files"
    echo "   Python files: $py_files"
    echo "   Repository size: $repo_size"
    echo ""

    # Check obsolete files
    info "🗑️  Checking for obsolete files (365+ days old)..."
    local obsolete_count=0
    while IFS= read -r file; do
        warning "   Old file: $file"
        obsolete_count=$((obsolete_count + 1))
        issues=$((issues + 1))
    done < <(find "$PROJECT_ROOT" -type f -mtime +365 \
        -not -path "*/venv/*" \
        -not -path "*/site/*" \
        -not -path "*/.git/*" \
        -not -path "*/node_modules/*" 2>/dev/null || true)

    if [ $obsolete_count -eq 0 ]; then
        success "   No ancient files found. Impressive!"
    else
        sassy "   Found $obsolete_count files older than your last haircut."
    fi
    echo ""

    # Check cache files
    info "💾 Hunting for cache files in version control..."
    local cache_count=0
    while IFS= read -r dir; do
        warning "   Cache directory: $dir"
        cache_count=$((cache_count + 1))
        issues=$((issues + 1))
    done < <(find "$PROJECT_ROOT" -type d \( -name "__pycache__" -o -name ".cache" -o -name "*.egg-info" \) \
        -not -path "*/venv/*" \
        -not -path "*/site/*" 2>/dev/null || true)

    if [ $cache_count -eq 0 ]; then
        success "   No cache files in git. You've been trained well!"
    else
        sassy "   Found $cache_count cache directories. Git is not a trash can!"
    fi
    echo ""

    # Check backup files
    info "🗂️  Looking for backup files..."
    local backup_count=0
    while IFS= read -r file; do
        warning "   Backup file: $file"
        backup_count=$((backup_count + 1))
        issues=$((issues + 1))
    done < <(find "$PROJECT_ROOT" \( -name "*.bak" -o -name "*.backup" -o -name "*~" -o -name "*.tmp" \) \
        -not -path "*/venv/*" \
        -not -path "*/site/*" \
        -not -path "*/.git/*" 2>/dev/null || true)

    if [ $backup_count -eq 0 ]; then
        success "   No backup files found. Clean!"
    else
        sassy "   Found $backup_count backup files. Git exists for a reason!"
    fi
    echo ""

    # Check large files
    info "🐘 Detecting large files (>1MB)..."
    local large_count=0
    while IFS= read -r line; do
        warning "   Large file: $line"
        large_count=$((large_count + 1))
    done < <(find "$PROJECT_ROOT" -type f -size +1M \
        -not -path "*/venv/*" \
        -not -path "*/site/*" \
        -not -path "*/.git/*" \
        -exec du -h {} \; 2>/dev/null | sort -rh | head -10 || true)

    if [ $large_count -eq 0 ]; then
        success "   No suspiciously large files. Nice!"
    else
        sassy "   Found $large_count large files. Binary files belong in releases, not git."
    fi
    echo ""

    # Health score
    local health_score=$((100 - issues * 2))
    if [ $health_score -lt 0 ]; then
        health_score=0
    fi

    echo ""
    info "🎯 Repository Health Score: $health_score/100"
    if [ $health_score -ge 90 ]; then
        success "   Pristine! The Janitor is impressed. 🏆"
    elif [ $health_score -ge 75 ]; then
        success "   Good shape. Minor issues to address. ✅"
    elif [ $health_score -ge 60 ]; then
        warning "   Needs work. Schedule a cleanup session. ⚠️"
    else
        error "   Critical condition. The Janitor is judging you. 🚨"
    fi
}

# ======================
# FIND OBSOLETE FILES
# ======================

find_obsolete() {
    info "Finding obsolete files (365+ days old)..."
    sassy "Let's see what vintage collection you've been hoarding."
    echo ""

    local count=0
    while IFS= read -r file; do
        local days=$(( ($(date +%s) - $(stat -c %Y "$file")) / 86400 ))
        warning "   $file (${days} days old)"
        count=$((count + 1))
    done < <(find "$PROJECT_ROOT" -type f -mtime +365 \
        -not -path "*/venv/*" \
        -not -path "*/site/*" \
        -not -path "*/.git/*" \
        -not -path "*/node_modules/*" 2>/dev/null || true)

    if [ $count -eq 0 ]; then
        success "No obsolete files found. Your repo is fresh!"
    else
        sassy "Found $count files older than a year. Time to let go?"
        info "To archive: ./scripts/repo-janitor.sh archive-obsolete"
    fi
}

# ======================
# CLEAN CACHE
# ======================

clean_cache() {
    info "Cleaning cache directories..."
    sassy "Removing Python turds and other cache nonsense."
    echo ""

    local count=0
    while IFS= read -r dir; do
        info "   Removing: $dir"
        rm -rf "$dir"
        count=$((count + 1))
    done < <(find "$PROJECT_ROOT" -type d \( -name "__pycache__" -o -name ".cache" -o -name "*.egg-info" \) \
        -not -path "*/venv/*" 2>/dev/null || true)

    # Also clean .pyc files
    while IFS= read -r file; do
        rm -f "$file"
        count=$((count + 1))
    done < <(find "$PROJECT_ROOT" -name "*.pyc" -o -name "*.pyo" -o -name "*.pyd" 2>/dev/null || true)

    if [ $count -eq 0 ]; then
        success "No cache files found. Already clean!"
    else
        success "Removed $count cache items. Your git repo thanks you."
    fi
}

# ======================
# FIND DUPLICATES
# ======================

find_duplicates() {
    info "Finding duplicate markdown files..."
    sassy "Copy-paste is not version control, just FYI."
    echo ""

    # Find markdown files and compute checksums
    local temp_file=$(mktemp)
    find "$PROJECT_ROOT" -name "*.md" \
        -not -path "*/venv/*" \
        -not -path "*/site/*" \
        -not -path "*/.git/*" \
        -type f -exec md5sum {} \; | sort > "$temp_file" 2>/dev/null || true

    # Find duplicates
    local duplicates=$(awk '{print $1}' "$temp_file" | uniq -d)

    if [ -z "$duplicates" ]; then
        success "No duplicate markdown files found. DRY principle approved!"
    else
        warning "Duplicate markdown files detected:"
        for hash in $duplicates; do
            echo ""
            warning "   Duplicate set (hash: ${hash:0:8}...):"
            grep "^$hash" "$temp_file" | awk '{print "      - " $2}'
        done
        echo ""
        sassy "These files say the same thing. Pick one and delete the rest!"
    fi

    rm -f "$temp_file"
}

# ======================
# CHECK GITIGNORE
# ======================

check_gitignore() {
    info "Auditing .gitignore configuration..."
    sassy "Let's see if you know what should be ignored."
    echo ""

    local gitignore="$PROJECT_ROOT/.gitignore"
    local issues=0

    # Essential patterns that MUST be in .gitignore
    declare -a required_patterns=(
        "__pycache__"
        "*.pyc"
        "venv/"
        "site/"
        ".cache"
        "*.log"
        ".DS_Store"
        "*.bak"
    )

    info "Checking for essential ignore patterns..."
    for pattern in "${required_patterns[@]}"; do
        if grep -q "$pattern" "$gitignore" 2>/dev/null; then
            success "   ✓ $pattern (ignored)"
        else
            warning "   ✗ $pattern (NOT ignored - add it!)"
            issues=$((issues + 1))
        fi
    done
    echo ""

    # Check for files that should be ignored but aren't
    info "Checking for files that should be ignored..."

    # Check for cache directories
    if find "$PROJECT_ROOT" -type d -name "__pycache__" -not -path "*/venv/*" 2>/dev/null | grep -q .; then
        error "   __pycache__ directories found in repo!"
        issues=$((issues + 1))
    fi

    # Check for .pyc files
    if find "$PROJECT_ROOT" -name "*.pyc" -not -path "*/venv/*" 2>/dev/null | grep -q .; then
        error "   .pyc files found in repo!"
        issues=$((issues + 1))
    fi

    # Check for .DS_Store
    if find "$PROJECT_ROOT" -name ".DS_Store" 2>/dev/null | grep -q .; then
        error "   .DS_Store files found (Mac user detected!)"
        issues=$((issues + 1))
    fi

    if [ $issues -eq 0 ]; then
        success "✨ .gitignore is properly configured!"
    else
        error "Found $issues .gitignore issues."
        info "Run: ./scripts/repo-janitor.sh fix-gitignore"
    fi
}

# ======================
# FIX GITIGNORE
# ======================

fix_gitignore() {
    info "Updating .gitignore with best practices..."

    local gitignore="$PROJECT_ROOT/.gitignore"

    # Backup current .gitignore
    if [ -f "$gitignore" ]; then
        cp "$gitignore" "${gitignore}.backup"
        success "Backed up current .gitignore to .gitignore.backup"
    fi

    # Essential patterns
    declare -a essential=(
        "# Python"
        "__pycache__/"
        "*.py[cod]"
        "*\$py.class"
        "*.so"
        ".Python"
        "venv/"
        "env/"
        ".venv/"
        "ENV/"
        "*.egg-info/"
        "dist/"
        "build/"
        ""
        "# MkDocs"
        "site/"
        "test/"
        ""
        "# IDEs"
        ".vscode/"
        ".idea/"
        "*.swp"
        "*.swo"
        "*~"
        ""
        "# OS"
        ".DS_Store"
        "Thumbs.db"
        ""
        "# Cache & Logs"
        ".cache/"
        "*.log"
        ""
        "# Backup files"
        "*.bak"
        "*.backup"
        "*.tmp"
        "*.temp"
    )

    # Add missing patterns
    for pattern in "${essential[@]}"; do
        if ! grep -Fxq "$pattern" "$gitignore" 2>/dev/null; then
            echo "$pattern" >> "$gitignore"
        fi
    done

    success "Updated .gitignore with essential patterns"
    sassy "Now stop committing cache files!"
}

# ======================
# ARCHIVE OBSOLETE
# ======================

archive_obsolete() {
    info "Archiving obsolete files..."
    sassy "Moving ancient files to the archive. They had a good run."
    echo ""

    local archive_dir="$PROJECT_ROOT/.archive"
    mkdir -p "$archive_dir"

    local count=0
    while IFS= read -r file; do
        local relative_path="${file#$PROJECT_ROOT/}"
        local archive_path="$archive_dir/$relative_path"
        local archive_subdir=$(dirname "$archive_path")

        mkdir -p "$archive_subdir"
        git mv "$file" "$archive_path" 2>/dev/null || mv "$file" "$archive_path"
        info "   Archived: $relative_path"
        count=$((count + 1))
    done < <(find "$PROJECT_ROOT" -type f -mtime +365 \
        -not -path "*/venv/*" \
        -not -path "*/site/*" \
        -not -path "*/.git/*" \
        -not -path "*/.archive/*" \
        -not -path "*/node_modules/*" 2>/dev/null || true)

    if [ $count -eq 0 ]; then
        success "No obsolete files to archive!"
    else
        success "Archived $count files to .archive/"
        info "Review and commit with: git commit -m 'chore: archive obsolete files'"
    fi
}

# ======================
# HEALTH REPORT
# ======================

health_report() {
    info "Generating repository health report..."
    sassy "Time for your annual checkup!"
    echo ""

    # Repository statistics
    info "📊 Repository Statistics:"
    echo "   Total files: $(git ls-files | wc -l)"
    echo "   Markdown files: $(git ls-files "*.md" | wc -l)"
    echo "   Python files: $(git ls-files "*.py" | wc -l)"
    echo "   Shell scripts: $(git ls-files "*.sh" | wc -l)"
    echo "   Repository size: $(du -sh .git | cut -f1)"
    echo "   Total branches: $(git branch -a | wc -l)"
    echo ""

    # File type distribution
    info "📁 File Type Distribution (Top 10):"
    git ls-files | sed 's/.*\.//' | sort | uniq -c | sort -rn | head -10 | while read count ext; do
        echo "   .$ext: $count files"
    done
    echo ""

    # Largest files
    info "🐘 Largest Files (Top 5):"
    git ls-files | xargs du -h 2>/dev/null | sort -rh | head -5 | while read size file; do
        echo "   $size - $file"
    done
    echo ""

    # Recent activity
    info "🔥 Recent Activity (Last 30 days):"
    local commits=$(git log --since="30 days ago" --oneline | wc -l)
    echo "   Commits: $commits"
    echo ""

    # Calculate health score
    local issues=0

    # Check for problems
    issues=$((issues + $(find "$PROJECT_ROOT" -type f -mtime +365 -not -path "*/venv/*" -not -path "*/site/*" -not -path "*/.git/*" 2>/dev/null | wc -l)))
    issues=$((issues + $(find "$PROJECT_ROOT" -type d -name "__pycache__" -not -path "*/venv/*" 2>/dev/null | wc -l)))
    issues=$((issues + $(find "$PROJECT_ROOT" -name "*.pyc" -not -path "*/venv/*" 2>/dev/null | wc -l)))

    local health_score=$((100 - issues * 2))
    if [ $health_score -lt 0 ]; then
        health_score=0
    fi

    info "🎯 Repository Health Score: $health_score/100"
    if [ $health_score -ge 90 ]; then
        success "   Status: PRISTINE 🏆"
        sassy "   The Janitor is impressed. Keep it up!"
    elif [ $health_score -ge 75 ]; then
        success "   Status: GOOD ✅"
        sassy "   Minor issues, but you're doing alright."
    elif [ $health_score -ge 60 ]; then
        warning "   Status: NEEDS WORK ⚠️"
        sassy "   Schedule a cleanup session soon."
    else
        error "   Status: CRITICAL 🚨"
        sassy "   The Janitor is judging you heavily right now."
    fi
}

# ======================
# VALIDATE STRUCTURE
# ======================

validate_structure() {
    info "Validating repository structure..."
    sassy "Let's see if your folders make sense."
    echo ""

    local issues=0

    # Check for expected directories
    declare -a expected_dirs=(
        ".github"
        ".claude"
        "docs"
        "scripts"
    )

    info "Checking expected directories..."
    for dir in "${expected_dirs[@]}"; do
        if [ -d "$PROJECT_ROOT/$dir" ]; then
            success "   ✓ $dir/"
        else
            warning "   ✗ $dir/ (missing)"
            issues=$((issues + 1))
        fi
    done
    echo ""

    # Check for expected files
    declare -a expected_files=(
        "README.md"
        "mkdocs.yml"
        "requirements.txt"
        ".gitignore"
    )

    info "Checking expected files..."
    for file in "${expected_files[@]}"; do
        if [ -f "$PROJECT_ROOT/$file" ]; then
            success "   ✓ $file"
        else
            warning "   ✗ $file (missing)"
            issues=$((issues + 1))
        fi
    done
    echo ""

    # Check for problematic directories
    declare -a bad_dirs=(
        "backup"
        "old"
        "tmp"
        "temp"
        "test_output"
        "node_modules"
    )

    info "Checking for problematic directories..."
    for dir in "${bad_dirs[@]}"; do
        if [ -d "$PROJECT_ROOT/$dir" ]; then
            error "   ✗ $dir/ (should not exist)"
            issues=$((issues + 1))
        fi
    done
    echo ""

    if [ $issues -eq 0 ]; then
        success "✨ Repository structure is valid!"
    else
        warning "Found $issues structural issues."
    fi
}

# ======================
# DEEP CLEAN
# ======================

deep_clean() {
    local dry_run=false
    if [[ "${1:-}" == "--dry-run" ]]; then
        dry_run=true
        warning "DRY RUN MODE - No files will be deleted"
    fi

    info "Initiating deep clean..."
    sassy "Nuclear option activated. Hope you know what you're doing!"
    echo ""

    if [ "$dry_run" = false ]; then
        warning "This will DELETE files. Press Ctrl+C to cancel, Enter to continue..."
        read -r
    fi

    # Clean cache
    info "Cleaning cache directories..."
    if [ "$dry_run" = true ]; then
        find "$PROJECT_ROOT" -type d \( -name "__pycache__" -o -name ".cache" \) -not -path "*/venv/*"
    else
        clean_cache
    fi

    # Remove backup files
    info "Removing backup files..."
    while IFS= read -r file; do
        if [ "$dry_run" = true ]; then
            info "   Would delete: $file"
        else
            rm -f "$file"
            info "   Deleted: $file"
        fi
    done < <(find "$PROJECT_ROOT" \( -name "*.bak" -o -name "*.backup" -o -name "*~" -o -name "*.tmp" \) \
        -not -path "*/venv/*" -not -path "*/.git/*" 2>/dev/null || true)

    if [ "$dry_run" = true ]; then
        warning "DRY RUN complete. Run without --dry-run to actually delete files."
    else
        success "Deep clean complete! Repository is squeaky clean."
        sassy "Now please try to keep it this way."
    fi
}

# ======================
# HELP
# ======================

show_help() {
    cat << EOF
RepoJanitor 🧹 - The Sarcastic Repository Cleaner

Usage: $0 <command> [options]

Commands:
    inspect               Full repository inspection
    find-obsolete         Find files older than 365 days
    clean-cache           Remove cache directories and files
    find-duplicates       Find duplicate markdown files
    check-gitignore       Audit .gitignore configuration
    fix-gitignore         Update .gitignore with best practices
    archive-obsolete      Move obsolete files to .archive/
    health-report         Generate repository health report
    validate-structure    Validate repository structure
    deep-clean            Nuclear cleanup option
      --dry-run           Preview what would be deleted

Examples:
    $0 inspect
    $0 clean-cache
    $0 health-report
    $0 deep-clean --dry-run

Janitor's Motto: "Clean repos, clear mind, zero BS."
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
        inspect)
            inspect
            ;;
        find-obsolete)
            find_obsolete
            ;;
        clean-cache)
            clean_cache
            ;;
        find-duplicates)
            find_duplicates
            ;;
        check-gitignore)
            check_gitignore
            ;;
        fix-gitignore)
            fix_gitignore
            ;;
        archive-obsolete)
            archive_obsolete
            ;;
        health-report)
            health_report
            ;;
        validate-structure)
            validate_structure
            ;;
        deep-clean)
            deep_clean "${2:-}"
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
