#!/bin/bash

# Template Validation Script
# Validates template integrity and checks for hardcoded references

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

print_status() { echo -e "\033[0;34m[INFO]\033[0m $1"; }
print_success() { echo -e "\033[0;32m[SUCCESS]\033[0m $1"; }
print_error() { echo -e "\033[0;31m[ERROR]\033[0m $1"; }
print_warning() { echo -e "\033[0;33m[WARNING]\033[0m $1"; }

ERRORS=0
WARNINGS=0

validate_template() {
    local template_dir="$1"
    local template_name="$(basename "$template_dir")"
    
    print_status "Validating template: $template_name"
    
    # Check required directories
    local required_dirs=("agents" "steering" "docs")
    for dir in "${required_dirs[@]}"; do
        if [ ! -d "$template_dir/$dir" ]; then
            print_error "Missing required directory: $template_dir/$dir"
            ((ERRORS++))
        fi
    done
    
    # Check for hardcoded references
    print_status "Checking for hardcoded references in $template_name..."
    
    # Load validation patterns from config file
    local validation_config="$REPO_ROOT/.template-validation"
    local hardcoded_patterns=()
    
    if [ -f "$validation_config" ]; then
        # Read patterns from config file, skip comments and empty lines
        while IFS= read -r line; do
            # Skip comments and empty lines
            if [[ ! "$line" =~ ^[[:space:]]*# ]] && [[ -n "${line// }" ]]; then
                hardcoded_patterns+=("$line")
            fi
        done < "$validation_config"
    fi
    
    # If no patterns loaded, skip hardcoded reference check
    if [ ${#hardcoded_patterns[@]} -eq 0 ]; then
        print_status "No validation patterns configured in $validation_config"
        return
    fi
    
    for pattern in "${hardcoded_patterns[@]}"; do
        local matches=$(find "$template_dir" -type f \( -name "*.json" -o -name "*.md" -o -name "*.py" -o -name "*.sh" \) -exec grep -l "$pattern" {} \; 2>/dev/null | grep -v "# .*$pattern" || true)
        if [ -n "$matches" ]; then
            # Filter out comment-only matches
            local real_matches=""
            for file in $matches; do
                if grep -v "^\s*#.*$pattern" "$file" | grep -q "$pattern"; then
                    real_matches="$real_matches$file\n"
                fi
            done
            if [ -n "$real_matches" ]; then
                print_warning "Found hardcoded reference '$pattern' in:"
                echo -e "$real_matches" | sed 's/^/  /'
                ((WARNINGS++))
            fi
        fi
    done
    
    # Validate JSON files
    print_status "Validating JSON files in $template_name..."
    find "$template_dir" -name "*.json" | while read -r json_file; do
        if ! python3 -m json.tool "$json_file" > /dev/null 2>&1; then
            print_error "Invalid JSON: $json_file"
            ((ERRORS++))
        fi
    done
    
    # Check for template variables
    print_status "Checking template variable usage in $template_name..."
    local template_vars_found=$(find "$template_dir" -type f \( -name "*.json" -o -name "*.md" \) -exec grep -l "{{.*}}" {} \; 2>/dev/null | wc -l)
    if [ "$template_vars_found" -eq 0 ]; then
        print_warning "No template variables found in $template_name - may not be properly genericized"
        ((WARNINGS++))
    else
        print_success "Found template variables in $template_vars_found files"
    fi
}

# Main validation
print_status "Starting template validation..."

# Validate base template
if [ -d "$REPO_ROOT/baseTemplate" ]; then
    validate_template "$REPO_ROOT/baseTemplate"
else
    print_error "Base template not found at $REPO_ROOT/baseTemplate"
    ((ERRORS++))
fi

# Validate template variants
if [ -d "$REPO_ROOT/templates" ]; then
    for template_dir in "$REPO_ROOT/templates"/*; do
        if [ -d "$template_dir" ]; then
            validate_template "$template_dir"
        fi
    done
fi

# Summary
echo ""
print_status "Validation Summary:"
echo "  Errors: $ERRORS"
echo "  Warnings: $WARNINGS"

if [ "$ERRORS" -eq 0 ]; then
    print_success "Template validation passed!"
    exit 0
else
    print_error "Template validation failed with $ERRORS errors"
    exit 1
fi
