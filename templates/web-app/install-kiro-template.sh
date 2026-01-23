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
    # Check if we're in a temp directory and suggest parent instead
    CURRENT_DIR="$(pwd)"
    if [[ "$(basename "$CURRENT_DIR")" == "temp" ]]; then
        TARGET_DIR="$(dirname "$CURRENT_DIR")"
        print_status "Detected temp directory - installing to project directory: $TARGET_DIR"
    else
        TARGET_DIR="$CURRENT_DIR"
        print_status "Installing to current directory: $TARGET_DIR"
    fi
else
    TARGET_DIR="$1"
fi

SCRIPT_DIR="$(dirname "$0")"
TEMPLATE_DIR="$SCRIPT_DIR"

# Check if template directory exists
if [ ! -f "$TEMPLATE_DIR/agents/kiro-setup.json" ]; then
    print_error "Template files not found in $TEMPLATE_DIR"
    print_error "Make sure you're running this from the kiro-cli-template repository"
    exit 1
fi

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    print_status "Creating target directory: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
fi

# Check if target already has .kiro
if [ -d "$TARGET_DIR/.kiro" ]; then
    print_warning "Target directory already has Kiro CLI configuration"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Installation cancelled"
        exit 0
    fi
    rm -rf "$TARGET_DIR/.kiro"
fi

print_status "Installing Kiro CLI template to $TARGET_DIR"

# Copy template files directly to .kiro folder
rsync -av --exclude='.git' --exclude='install-kiro-template.sh' --exclude='README.md' --exclude='kiroInit.py' "$TEMPLATE_DIR/" "$TARGET_DIR/.kiro/"
print_success "Template installed to .kiro folder"

# Update .gitignore to exclude .kiro (but keep steering docs)
GITIGNORE_FILE="$TARGET_DIR/.gitignore"
if [ -f "$GITIGNORE_FILE" ]; then
    if ! grep -q "^\.kiro/\*" "$GITIGNORE_FILE"; then
        echo "" >> "$GITIGNORE_FILE"
        echo "# Kiro CLI (exclude most but keep steering docs)" >> "$GITIGNORE_FILE"
        echo ".kiro/*" >> "$GITIGNORE_FILE"
        echo "!.kiro/steering/" >> "$GITIGNORE_FILE"
        print_success "Added .kiro to .gitignore"
    else
        print_status ".kiro already in .gitignore"
    fi
else
    print_status "Creating .gitignore with .kiro entry"
    echo "# Kiro CLI (exclude most but keep steering docs)" > "$GITIGNORE_FILE"
    echo ".kiro/*" >> "$GITIGNORE_FILE"
    echo "!.kiro/steering/" >> "$GITIGNORE_FILE"
fi

# Make initialization script executable
chmod +x "$TARGET_DIR/.kiro/agents/kiro-setup.json"
print_success "Setup agent configured"

# Check Python availability
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
else
    print_warning "Python not found. You'll need Python 3.6+ to run advanced features"
    PYTHON_CMD="python3"
fi

print_success "Kiro CLI template installed successfully!"
echo
print_status "🚀 Ready to configure your project!"
echo
echo "Next steps:"
echo "1. Navigate to your project directory:"
echo "   cd $TARGET_DIR"
echo
echo "2. Start Kiro CLI and run the setup agent:"
echo "   kiro-cli --agent kiro-setup"
echo "   (The agent will automatically start - no prompt needed!)"
echo
echo "3. The setup agent will:"
echo "   • Auto-detect your technology stack"
echo "   • Ask only for confirmation and missing details"
echo "   • Configure specialized agents for your project"
echo "   • Set up MCP servers and workflows"
echo "   • Update all configuration in place"
echo
print_status "The intelligent setup will make configuration effortless! 🎯"
