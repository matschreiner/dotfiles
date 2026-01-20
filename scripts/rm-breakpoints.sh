#!/bin/bash
# Remove Python debug breakpoints from all .py files
#
# Pattern: __import__("pdb").set_trace() with optional #TODO delme comment
#
# Usage:
#   rm-breakpoints.sh        # Remove breakpoints from all .py files
#   rm-breakpoints.sh -n     # Dry run - show what would be removed

set -euo pipefail

DRY_RUN=false
FILES_MODIFIED=0
LINES_REMOVED=0

# Parse arguments
while getopts "n" opt; do
    case $opt in
        n) DRY_RUN=true ;;
        *) echo "Usage: $0 [-n]" >&2; exit 1 ;;
    esac
done

# Pattern to match: __import__("pdb").set_trace() with optional comment
# Handles both single and double quotes, and optional whitespace
PATTERN='__import__\s*\(\s*["'"'"']pdb["'"'"']\s*\)\s*\.\s*set_trace\s*\(\s*\)'

if $DRY_RUN; then
    echo "=== DRY RUN MODE - No files will be modified ==="
    echo
fi

# Find Python files (use git ls-files if in a git repo, otherwise find)
if git rev-parse --is-inside-work-tree &>/dev/null 2>&1; then
    files=$(git ls-files '*.py' 2>/dev/null || true)
else
    files=$(find . -name '*.py' -type f 2>/dev/null || true)
fi

if [[ -z "$files" ]]; then
    echo "No Python files found."
    exit 0
fi

# Process each file
while IFS= read -r file; do
    [[ -z "$file" ]] && continue
    [[ ! -f "$file" ]] && continue

    # Find matching lines with line numbers
    matches=$(grep -nE "$PATTERN" "$file" 2>/dev/null || true)

    if [[ -n "$matches" ]]; then
        match_count=$(echo "$matches" | wc -l)
        echo "[$file] Found $match_count breakpoint(s):"
        echo "$matches" | while IFS= read -r line; do
            echo "  $line"
        done
        echo

        if $DRY_RUN; then
            LINES_REMOVED=$((LINES_REMOVED + match_count))
            FILES_MODIFIED=$((FILES_MODIFIED + 1))
        else
            # Remove the lines in-place
            sed -i -E "/$PATTERN/d" "$file"
            LINES_REMOVED=$((LINES_REMOVED + match_count))
            FILES_MODIFIED=$((FILES_MODIFIED + 1))
        fi
    fi
done <<< "$files"

# Summary
echo "========================================="
if $DRY_RUN; then
    echo "DRY RUN COMPLETE"
    echo "Would modify: $FILES_MODIFIED file(s)"
    echo "Would remove: $LINES_REMOVED line(s)"
else
    echo "COMPLETE"
    echo "Modified: $FILES_MODIFIED file(s)"
    echo "Removed: $LINES_REMOVED line(s)"
fi
