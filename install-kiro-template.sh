#!/bin/bash

# Kiro CLI Template Installation Script
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

# Determine target directory
if [ $# -eq 0 ]; then
    print_status "No target directory provided"
    
    # Check if we're in a temp directory and suggest parent instead
    CURRENT_DIR="$(pwd)"
    if [[ "$(basename "$CURRENT_DIR")" == "temp" ]]; then
        SUGGESTED_DIR="$(dirname "$CURRENT_DIR")"
        print_status "Detected temp directory installation"
        echo "Options:"
        echo "1. Install in project directory ($SUGGESTED_DIR)"
        echo "2. Specify a different directory"
    else
        SUGGESTED_DIR="$CURRENT_DIR"
        echo "Options:"
        echo "1. Install in current directory ($SUGGESTED_DIR)"
        echo "2. Specify a different directory"
    fi
    
    read -p "Choose option (1/2): " -n 1 -r
    echo
    
    if [[ $REPLY == "1" ]]; then
        TARGET_DIR="$SUGGESTED_DIR"
    else
        read -p "Enter target directory path: " TARGET_DIR
    fi
else
    TARGET_DIR="$1"
fi

SCRIPT_DIR="$(dirname "$0")"
TEMPLATE_DIR="$SCRIPT_DIR"

# Check if template directory exists
if [ ! -f "$TEMPLATE_DIR/kiroInit.py" ]; then
    print_error "Template files not found in $TEMPLATE_DIR"
    print_error "Make sure you're running this from the kiro-cli-template repository"
    exit 1
fi

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    print_status "Creating target directory: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

# Check if target already has .kiro or .kiroTemplate
if [ -d "$TARGET_DIR/.kiro" ] || [ -d "$TARGET_DIR/.kiroTemplate" ]; then
    print_warning "Target directory already has Kiro CLI configuration"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Installation cancelled"
        exit 0
    fi
    rm -rf "$TARGET_DIR/.kiro" "$TARGET_DIR/.kiroTemplate"
fi

print_status "Installing Kiro CLI template to $TARGET_DIR"

# Copy template files (excluding .git and install script)
rsync -av --exclude='.git' --exclude='install-kiro-template.sh' --exclude='README.md' "$TEMPLATE_DIR/" "$TARGET_DIR/.kiroTemplate/"
print_success "Template copied successfully"

# Update .gitignore to exclude .kiroTemplate
GITIGNORE_FILE="$TARGET_DIR/.gitignore"
if [ -f "$GITIGNORE_FILE" ]; then
    if ! grep -q "^\.kiroTemplate" "$GITIGNORE_FILE"; then
        echo "" >> "$GITIGNORE_FILE"
        echo "# Kiro CLI Template (remove after initialization)" >> "$GITIGNORE_FILE"
        echo ".kiroTemplate" >> "$GITIGNORE_FILE"
        print_success "Added .kiroTemplate to .gitignore"
    else
        print_status ".kiroTemplate already in .gitignore"
    fi
else
    print_status "Creating .gitignore with .kiroTemplate entry"
    echo "# Kiro CLI Template (remove after initialization)" > "$GITIGNORE_FILE"
    echo ".kiroTemplate" >> "$GITIGNORE_FILE"
fi

# Make initialization script executable
chmod +x "$TARGET_DIR/.kiroTemplate/kiroInit.py"
print_success "Initialization script made executable"

# Check Python availability
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
else
    print_warning "Python not found. Please install Python 3.6+ to run the initialization script"
    PYTHON_CMD="python3"
fi

print_success "Kiro CLI template installed successfully!"
echo
print_status "Next steps:"
echo "1. Navigate to your project directory:"
echo "   cd $TARGET_DIR"
echo
echo "2. Run the initialization script:"
echo "   cd .kiroTemplate"
echo "   $PYTHON_CMD kiroInit.py"
echo
echo "3. Follow the interactive prompts to configure your project"
echo
echo "4. Start using Kiro CLI:"
echo "   kiro-cli"
echo
print_status "The initialization script will:"
echo "  • Customize steering documents for your project"
echo "  • Configure specialized agents based on your tech stack"
echo "  • Set up MCP servers for enhanced capabilities"
echo "  • Create project-specific workflows and patterns"
echo "  • Rename .kiroTemplate to .kiro when complete"
echo
print_success "Happy coding with AI assistance! 🚀"
