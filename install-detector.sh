#!/bin/bash

# Kiro Template Detector Installer
# Installs a single agent to analyze and auto-install the best template

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(pwd)"

echo "🔍 Installing Kiro Template Detector..."

# Create minimal .kiro structure
mkdir -p .kiro/agents

# Install the template detector agent
cat > .kiro/agents/template-installer.json << 'EOF'
{
  "name": "template-installer",
  "description": "Analyzes project structure and automatically installs the optimal Kiro CLI template",
  "prompt": "🚀 **Kiro Template Auto-Installer**\n\nI'll analyze your project and install the perfect Kiro CLI template automatically.\n\n**Just say: \"Install the best template for my project\"** and I'll:\n• Analyze your project structure and dependencies\n• Detect technology stack (React, Express, Flutter, etc.)\n• Determine optimal template (web-app, api-service, mobile-app, etc.)\n• Automatically install the recommended template\n• Set up all agents and configurations\n• Provide next steps for development\n\nYou are a Kiro CLI template installation specialist. When the user requests template installation, analyze the project structure by examining package.json, requirements.txt, Cargo.toml, go.mod, file structure, and dependencies to determine the best template. Then automatically install the appropriate template by running the install-kiro-template.sh script from the correct template directory. Available templates: web-app (React/Vue/Angular), api-service (Express/FastAPI/Django), mobile-app (React Native/Flutter), desktop-app (Electron/Tauri), data-pipeline (pandas/Airflow), library (npm/PyPI packages), minimal (fallback). The kiroTemplate repository should be available at ~/projects/kiroTemplate/. After installation, guide the user through the setup process with kiro-setup, project-detector, and other essential agents. IMPORTANT: Never run kiro-cli commands from within this agent - only run the template installation scripts directly.",
  "tools": ["read", "write", "shell"],
  "allowedTools": ["read", "write", "shell"],
  "resources": [
    "file://package.json",
    "file://requirements.txt", 
    "file://Cargo.toml",
    "file://go.mod",
    "file://pom.xml",
    "file://pubspec.yaml",
    "file://docker-compose.yml",
    "file://src/**/*",
    "file://app/**/*",
    "file://README.md"
  ],
  "model": "claude-sonnet-4"
}
EOF

echo "✅ Template detector installed!"
echo ""
echo "🎯 Next step:"
echo "kiro-cli --agent template-installer"
echo "Prompt: \"Install the best template for my project\""
