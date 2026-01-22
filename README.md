# Kiro CLI Project Templates - Recipe Raiders Architecture

This repository provides modern Kiro CLI templates based on the optimized architecture from Recipe Raiders, featuring 22 standardized agents, hybrid documentation structure, and project-specific customizations.

## 🚀 Quick Start

```bash
# 1. Navigate to your project directory
cd /path/to/your/project

# 2. Install template (creates .kiro/ directory in current location)
/path/to/kiroTemplate/baseTemplate/install-kiro-template.sh

# 3. Analyze and customize for your project
kiro-cli --agent project-detector
kiro-cli --agent template-manager

# 4. Start developing
kiro-cli
```

**Important:** Run the installation script from your project root directory. It will create the `.kiro/` folder structure in your current location.

## ✨ What's New (Recipe Raiders Architecture)

### 🤖 22 Optimized Agents
- **All JSON format** - Standardized, fast-loading agents
- **Under 3,000 characters** - Focused prompts with detailed docs
- **Hybrid architecture** - Core expertise + reference documentation
- **Project-specific customization** - Adapts to your technology stack

### 📚 Modern Structure
```
.kiro/
├── agents/          # 22 optimized JSON agents
├── steering/        # Project knowledge base
├── docs/           # Detailed reference guides
├── prompts/        # Reusable prompt templates
├── patterns/       # Code patterns and examples
├── workflows/      # Process definitions
└── settings/       # MCP server configurations
```

### 🎯 Smart Customization
- **Auto-detection** - Analyzes your project automatically
- **Technology-aware** - Customizes agents for your stack
- **Template variables** - Dynamic agent generation
- **Conditional inclusion** - Only relevant agents included

## 📋 Available Templates

### 🌐 Web App Template
**Perfect for:** React, Vue, Angular, Svelte applications
**Includes:** component-management, user-workflow, api-integration, deployment
**MCP Servers:** Vercel Agent-Browser, Context7, Deployment tools

### 🔌 API Service Template  
**Perfect for:** Express, FastAPI, Django, Spring Boot APIs
**Includes:** endpoint-management, request-workflow, database-management, api-documentation
**MCP Servers:** Context7, Database tools, Vercel Agent-Browser

### 📱 Mobile App Template
**Perfect for:** React Native, Flutter, Ionic applications
**Includes:** screen-management, navigation-workflow, native-integration, mobile-ui
**MCP Servers:** Context7, Vercel Agent-Browser, Mobile testing tools

### ⚡ Minimal Template
**Perfect for:** Libraries, CLI tools, simple projects
**Includes:** Essential agents only (frontend, backend, self-improve)
**MCP Servers:** Context7 only

## 🛠️ Technology Support

### Languages & Frameworks
- **Frontend:** React, Vue, Angular, Svelte, Next.js, Nuxt
- **Backend:** Express, FastAPI, Django, Flask, Spring Boot, Rails
- **Mobile:** React Native, Flutter, Ionic
- **Database:** PostgreSQL, MySQL, MongoDB, SQLite, Redis
- **Deployment:** Vercel, Netlify, AWS, GCP, Azure, Railway

### Smart Detection
The `project-detector` agent automatically identifies:
- Package managers (npm, yarn, pip, cargo, go mod)
- Frameworks and libraries
- Database connections
- Testing setups
- Deployment configurations

## 🎨 Agent Customization Examples

### Before (Generic)
```json
{
  "name": "recipe-management",
  "description": "Recipe CRUD operations specialist",
  "prompt": "Handle recipe operations for Recipe Raiders..."
}
```

### After (Customized for React App)
```json
{
  "name": "component-management", 
  "description": "React component CRUD operations specialist",
  "prompt": "Handle React component operations for MyApp. Focus on TypeScript, modern hooks, accessibility..."
}
```

## 🔧 Advanced Features

### Template Variables
- `{{PROJECT_NAME}}` - Your project name
- `{{TECH_STACK}}` - Primary technology (React, Express, etc.)
- `{{PROJECT_TYPE}}` - web-app, api-service, mobile-app
- `{{DEPLOYMENT_PLATFORM}}` - Vercel, AWS, etc.

### Conditional Agents
Based on project analysis:
- **Authentication detected?** → Include auth-troubleshoot
- **Database found?** → Include db-query
- **Testing setup?** → Include api-testing, end-to-end-testing
- **Calendar features?** → Include calendar-integration

### Resource Path Adaptation
```json
"resources": [
  "file://src/{{FRONTEND_DIR}}/**/*.tsx",
  "file://{{API_DIR}}/**/*.ts", 
  "file://{{CONFIG_DIR}}/**/*.json"
]
```

### Browser Automation Setup (WSL)
```bash
# One-command setup for Vercel agent-browser in WSL
curl -fsSL https://raw.githubusercontent.com/your-repo/kiroTemplate/main/scripts/setup-vercel-browser-wsl.sh | bash

# Prerequisites (Windows):
# 1. Install VcXsrv: https://sourceforge.net/projects/vcxsrv/
# 2. Run ~/start-vcxsrv.bat before using browser automation

# Usage:
auth-session my-project        # Handle authentication flows
kiro-cli --agent vercel-browser # Automated testing and scraping
```

## 📊 Performance Benefits

### Recipe Raiders Optimizations
- ⚡ **90% faster agent loading** - Focused prompts vs. bloated documentation
- 🧠 **Better context management** - Hybrid architecture prevents context bloat
- 🎯 **Higher accuracy** - Specialized agents for specific tasks
- 🔄 **Easier maintenance** - Standardized structure and formats

### Metrics
- **All agents under 3,000 characters** (was up to 8,400+)
- **22 standardized agents** (was inconsistent mix)
- **100% JSON format** (was mix of JSON, MD, PY)
- **Hybrid documentation** (focused agents + detailed guides)

## 🚀 Getting Started Examples

### React + TypeScript Web App
```bash
# Navigate to your project
cd my-react-app

# Install template
/path/to/kiroTemplate/baseTemplate/install-kiro-template.sh

# Auto-detect and customize
kiro-cli --agent project-detector
# Detects: React, TypeScript, Vite, Tailwind
# Customizes: component-management, user-workflow, api-integration
# Sets up: Vercel Agent-Browser, Context7, deployment integration

# Setup browser automation for testing
curl -fsSL https://raw.githubusercontent.com/your-repo/kiroTemplate/main/scripts/setup-vercel-browser-wsl.sh | bash
```

### Express API Service
```bash
# Navigate to your project
cd my-api-service

# Install template
/path/to/kiroTemplate/baseTemplate/install-kiro-template.sh

# Auto-detect and customize
kiro-cli --agent project-detector
# Detects: Express, TypeScript, PostgreSQL, Jest
# Customizes: endpoint-management, database-management, api-testing
# Sets up: Database MCP, Vercel Agent-Browser, API documentation

# Setup automated testing
auth-session my-api-project
kiro-cli --agent vercel-browser
```

## 🎯 Best Practices

1. **Always run project-detector first** - Ensures optimal customization
2. **Use template-manager for fine-tuning** - Adjust agents after detection
3. **Leverage hybrid architecture** - Agents for action, docs for reference
4. **Keep agents focused** - Let detailed guides handle complexity
5. **Update regularly** - Use self-improve agent for continuous optimization
6. **Setup browser automation early** - Essential for testing workflows
7. **Use auth-session for complex logins** - Handles authentication flows seamlessly

## 🔄 Migration from Old Templates

### Automatic Migration
```bash
kiro-cli --agent template-manager
> "Migrate my existing .kiro setup to Recipe Raiders architecture"
```

### Manual Steps
1. Backup existing `.kiro/` directory
2. Install new template
3. Run project-detector for customization
4. Merge any custom agents or configurations

## 📈 Success Stories

**Recipe Raiders Project:**
- Reduced agent complexity by 84% (8,427 → 1,383 chars)
- Standardized 22 agents with consistent performance
- Implemented hybrid architecture for better maintainability
- Achieved 100% JSON compliance and validation

**Template Benefits:**
- Faster project setup (5 minutes vs. 30+ minutes)
- Consistent development experience across projects
- Reduced learning curve for new team members
- Scalable architecture that grows with projects
- **Automated browser testing** - WSL-optimized Vercel agent-browser setup
- **Authentication handling** - Seamless login flow management

## 📋 Quick Reference

### Essential Commands
```bash
# Setup new project (run from your project root)
cd /path/to/your/project
/path/to/kiroTemplate/baseTemplate/install-kiro-template.sh

# Analyze and customize
kiro-cli --agent project-detector
kiro-cli --agent template-manager

# Setup browser automation (WSL)
curl -fsSL https://raw.githubusercontent.com/your-repo/kiroTemplate/main/scripts/setup-vercel-browser-wsl.sh | bash

# Daily workflow
auth-session my-project              # Handle authentication
kiro-cli --agent vercel-browser      # Automated testing
kiro-cli --agent component-management # UI development
kiro-cli --agent self-improve        # End-of-session optimization
```

### Validation
```bash
# Test template integrity
./scripts/validate-template.sh

# Test browser setup
test-browser-setup
```

---

**Ready to supercharge your development with AI-assisted coding!** 🚀

*Based on battle-tested Recipe Raiders architecture with automated browser testing*
