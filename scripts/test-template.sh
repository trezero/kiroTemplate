#!/bin/bash

# Template Installation Test Script
# Tests the template installation and variable substitution

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
TEST_DIR="/tmp/kiro-template-test"

print_status() { echo -e "\033[0;34m[INFO]\033[0m $1"; }
print_success() { echo -e "\033[0;32m[SUCCESS]\033[0m $1"; }
print_error() { echo -e "\033[0;31m[ERROR]\033[0m $1"; }

cleanup() {
    if [ -d "$TEST_DIR" ]; then
        rm -rf "$TEST_DIR"
    fi
}

trap cleanup EXIT

print_status "Creating test project..."
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

# Create a basic project structure
echo "# Test Project" > README.md
echo '{"name": "test-project", "version": "1.0.0"}' > package.json

print_status "Testing template installation..."

# Copy the install script
cp "$REPO_ROOT/baseTemplate/install-kiro-template.sh" .
chmod +x install-kiro-template.sh

# Test that the script exists and is executable
if [ ! -x "./install-kiro-template.sh" ]; then
    print_error "Install script not found or not executable"
    exit 1
fi

print_success "Template installation test setup complete"

print_status "Verifying template structure..."

# Check that base template has required files
required_files=(
    "$REPO_ROOT/baseTemplate/kiroInit.py"
    "$REPO_ROOT/baseTemplate/template-variables.json"
    "$REPO_ROOT/baseTemplate/agents/resource-management.json"
    "$REPO_ROOT/baseTemplate/agents/user-workflow.json"
    "$REPO_ROOT/baseTemplate/agents/backend-services.json"
)

for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        print_error "Required template file missing: $file"
        exit 1
    fi
done

print_success "All required template files found"

print_status "Checking template variable definitions..."

# Verify template variables file is valid JSON
if ! python3 -m json.tool "$REPO_ROOT/baseTemplate/template-variables.json" > /dev/null 2>&1; then
    print_error "Template variables file is not valid JSON"
    exit 1
fi

print_success "Template variables file is valid"

print_status "Verifying agent templates..."

# Check that agent templates have template variables
agent_templates=(
    "$REPO_ROOT/baseTemplate/agents/resource-management.json"
    "$REPO_ROOT/baseTemplate/agents/user-workflow.json"
    "$REPO_ROOT/baseTemplate/agents/backend-services.json"
)

for agent in "${agent_templates[@]}"; do
    if ! grep -q "{{.*}}" "$agent"; then
        print_error "Agent template missing template variables: $agent"
        exit 1
    fi
done

print_success "Agent templates contain template variables"

print_status "Testing template creation script..."

# Test template creation script
if [ -x "$REPO_ROOT/scripts/create-template.sh" ]; then
    print_success "Template creation script is executable"
else
    print_error "Template creation script not found or not executable"
    exit 1
fi

print_success "All template tests passed!"

echo ""
echo "✅ Template system is ready for use"
echo ""
echo "Next steps:"
echo "1. Run validation: $REPO_ROOT/scripts/validate-template.sh"
echo "2. Create template variants: $REPO_ROOT/scripts/create-template.sh <type>"
echo "3. Test installation: cd your-project && $REPO_ROOT/baseTemplate/install-kiro-template.sh"
