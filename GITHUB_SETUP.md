# Kiro CLI Template Repository Setup Guide

## Creating the Template Repository

### 1. Create New GitHub Repository
```bash
# Create new repo on GitHub (e.g., "kiro-cli-template")
# Then clone it locally
git clone https://github.com/yourusername/kiro-cli-template.git
cd kiro-cli-template
```

### 2. Copy Template Files
```bash
# From your continuum project directory
cp -r .kiroTemplate/* /path/to/kiro-cli-template/
cd /path/to/kiro-cli-template
```

### 3. Initialize Repository
```bash
# Make scripts executable
chmod +x install-kiro-template.sh
chmod +x kiroInit.py

# Initial commit
git add .
git commit -m "Initial Kiro CLI template with interactive setup"
git push origin main
```

## Using the Template in New Projects

### Method 1: Clone and Install
```bash
# In your new project directory
git clone https://github.com/yourusername/kiro-cli-template.git temp-template
cd temp-template
./install-kiro-template.sh ../
cd ..
rm -rf temp-template

# Initialize the template
cd .kiroTemplate
python3 kiroInit.py
```

### Method 2: Direct Download and Install
```bash
# Download and extract
curl -L https://github.com/yourusername/kiro-cli-template/archive/main.zip -o kiro-template.zip
unzip kiro-template.zip
cd kiro-cli-template-main

# Install to current project
./install-kiro-template.sh /path/to/your/project

# Clean up
cd ..
rm -rf kiro-cli-template-main kiro-template.zip
```

### Method 3: One-liner Installation
```bash
# Create a simple installation command
curl -fsSL https://raw.githubusercontent.com/yourusername/kiro-cli-template/main/install.sh | bash
```

## Repository Structure

```
kiro-cli-template/
├── README.md                    # Template documentation
├── install-kiro-template.sh     # Installation script
├── kiroInit.py                  # Interactive setup script
├── IMPLEMENTATION_SUMMARY.md    # Technical details
├── agents/                      # Agent configurations
├── steering/                    # Steering documents
├── workflows/                   # Development workflows
├── patterns/                    # Project patterns
├── prompts/                     # Reusable prompts
├── settings/                    # MCP and other settings
└── mcp-servers/                 # MCP server implementations
```

## Benefits of Separate Repository

### ✅ **Advantages**
- **Version control** for template improvements
- **Easy distribution** via git clone
- **Collaborative development** of template
- **Release management** with tags/versions
- **Documentation** separate from projects
- **No template pollution** in project repos

### 🔧 **Maintenance**
- Update template based on learnings from projects
- Tag releases for stable versions
- Accept contributions from team members
- Keep template current with Kiro CLI updates

## Recommended Workflow

### For Template Maintenance
1. **Test improvements** in active projects
2. **Backport successful patterns** to template repo
3. **Version releases** with semantic versioning
4. **Document changes** in changelog

### For New Projects
1. **Clone template** to temporary location
2. **Run installer** pointing to project directory
3. **Initialize with kiroInit.py**
4. **Start development** with full Kiro CLI setup

## Advanced Usage

### Custom Template Versions
```bash
# Use specific version
git clone --branch v1.2.0 https://github.com/yourusername/kiro-cli-template.git

# Use development version
git clone --branch develop https://github.com/yourusername/kiro-cli-template.git
```

### Team Distribution
```bash
# Add to team documentation
echo "## Kiro CLI Setup" >> CONTRIBUTING.md
echo "git clone https://github.com/yourusername/kiro-cli-template.git temp && cd temp && ./install-kiro-template.sh ../ && cd .. && rm -rf temp" >> CONTRIBUTING.md
```

This approach gives you a clean, maintainable template system that can be easily shared and updated across all your projects! 🚀
