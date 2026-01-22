#!/bin/bash

# Modern Kiro CLI Template Installation Script
# Based on {{PROJECT_NAME}} optimized architecture
# Usage: ./install-kiro-template.sh [target_directory]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Main installation function
install_template() {
    local target_dir=${1:-.}
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    print_status "Installing modern Kiro CLI template with {{PROJECT_NAME}} architecture..."
    print_status "Script directory: $script_dir"
    print_status "Target directory: $target_dir"
    
    # Create .kiro directory structure
    mkdir -p "$target_dir/.kiro"/{agents,steering,docs,prompts,patterns,workflows,settings}
    
    # Copy optimized agents (22 standardized JSON agents)
    print_status "Installing 22 optimized agents..."
    cp "$script_dir/agents"/*.json "$target_dir/.kiro/agents/"
    
    # Copy steering documents
    print_status "Installing steering documents..."
    cp "$script_dir/steering"/*.md "$target_dir/.kiro/steering/"
    
    # Copy docs and patterns
    print_status "Installing documentation and patterns..."
    cp "$script_dir/docs"/*.md "$target_dir/.kiro/docs/"
    cp "$script_dir/patterns"/*.md "$target_dir/.kiro/patterns/"
    cp "$script_dir/prompts"/*.md "$target_dir/.kiro/prompts/"
    
    # Copy settings and workflows
    cp "$script_dir/settings"/*.json "$target_dir/.kiro/settings/"
    cp "$script_dir/workflows"/*.yml "$target_dir/.kiro/workflows/" 2>/dev/null || true
    
    # Copy MCP servers
    print_status "Installing MCP servers..."
    cp -r "$script_dir/mcp-servers" "$target_dir/.kiro/"
    
    print_success "Template installed successfully!"
    print_status "Next steps:"
    echo "  1. cd $target_dir"
    echo "  2. kiro-cli --agent project-detector  # Analyze your project"
    echo "  3. kiro-cli --agent template-manager  # Customize for your needs"
    echo "  4. kiro-cli  # Start developing!"
}

# Run installation
install_template "$@"
