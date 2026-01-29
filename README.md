# Kiro CLI Project Templates - Universal Template System

This repository provides modern Kiro CLI templates for any project type, featuring streamlined universal agents, automated browser testing, and intelligent project-specific customization.

## 🚀 Quick Start

### Option 1: Smart Installation (Recommended)
```bash
# 1. Navigate to your project directory
cd /path/to/your/project

# 2. Install template detector (lightweight - just one agent)
/path/to/kiroTemplate/install-detector.sh

# 3. Auto-detect and install optimal template
kiro-cli --agent template-installer
# When prompted, type: "Install the best template for my project"

# 4. Follow the automated setup workflow
# The agent will guide you through the remaining steps
```

### Option 2: Manual Template Selection
```bash
# 1. Navigate to your project directory
cd /path/to/your/project

# 2. Choose and install specific template
/path/to/kiroTemplate/templates/api-service/install-kiro-template.sh
# or /path/to/kiroTemplate/baseTemplate/install-kiro-template.sh

# 3. Initialize and configure everything automatically
kiro-cli --agent kiro-setup
# When prompted, type: "Set up my development environment"

# 4. Analyze your project for optimal configuration
kiro-cli --agent project-detector
# When prompted, type: "Analyze my project"

# 5. Implement recommended customizations
kiro-cli --agent template-manager
# When prompted, type: "Implement my project-detector recommendations"

# 6. Start developing with automated testing
kiro-cli --agent automated-browser-testing
# When prompted, type: "Test my web application"

# 7. Begin regular development
kiro-cli
```

**Important:** Run the installation script from your project root directory. It will create the `.kiro/` folder structure in your current location.

## ✨ What's New (Universal Template Architecture)

### 🤖 Streamlined Base Template
- **13 essential agents** - Only universally beneficial agents included
- **Universal compatibility** - Works with any programming language or framework
- **Automated browser testing** - Built-in web application testing with screenshot evidence
- **Intelligent setup** - Auto-configures everything after template deployment
- **Easy customization** - Add project-specific agents as needed via template-manager
- **Under 2,000 characters per agent** - Focused prompts with clear purposes
- **Hybrid architecture** - Core functionality + detailed reference documentation

### 📚 Modern Structure
```
.kiro/
├── agents/          # 13 streamlined universal agents
├── steering/        # Project knowledge base
├── docs/           # Detailed reference guides
├── prompts/        # Reusable prompt templates
├── patterns/       # Code patterns and examples
├── workflows/      # Process definitions
└── settings/       # MCP server configurations
```

### 🎯 Smart Customization
- **Auto-detection** - project-detector analyzes your project automatically
- **Intelligent setup** - kiro-setup configures everything including browser testing
- **Template manager** - Adds project-specific agents and configurations
- **Technology-aware** - Adapts to any language or framework
- **Conditional inclusion** - Only relevant agents added when needed

## 🔧 Complete Setup Workflow

### Step-by-Step Template Deployment

1. **Install Template**
   ```bash
   cd /path/to/your/project
   /path/to/kiroTemplate/baseTemplate/install-kiro-template.sh
   ```

2. **Initialize Environment**
   ```bash
   kiro-cli --agent kiro-setup
   ```
   **Prompt**: `"Set up my development environment"`
   - Detects technology stack
   - Configures MCP servers
   - Sets up browser testing
   - Validates all components

3. **Analyze Project**
   ```bash
   kiro-cli --agent project-detector
   ```
   **Prompt**: `"Analyze my project"`
   - Identifies project type
   - Recommends specific agents
   - Suggests configurations

4. **Apply Customizations**
   ```bash
   kiro-cli --agent template-manager
   ```
   **Prompt**: `"Implement my project-detector recommendations"`
   - Adds recommended agents
   - Configures project-specific tools
   - Optimizes setup

5. **Test Setup**
   ```bash
   kiro-cli --agent automated-browser-testing
   ```
   **Prompt**: `"Test my web application"`
   - Validates browser automation
   - Creates testing evidence
   - Confirms everything works

6. **Start Development**
   ```bash
   kiro-cli
   ```
   - Use any agent for development tasks
   - All agents now optimized for your project

## 📋 Available Templates

### 🌐 Web App Template
**Perfect for:** React, Vue, Angular, Svelte applications
**Includes:** frontend-development, ui-components + 13 universal agents
**Agent Count:** 15 agents

### 🔌 API Service Template  
**Perfect for:** Express, FastAPI, Django, Spring Boot APIs
**Includes:** api-development, database-management + 13 universal agents
**Agent Count:** 15 agents

### 📱 Mobile App Template
**Perfect for:** React Native, Flutter, Ionic applications
**Includes:** mobile-development + 13 universal agents
**Agent Count:** 14 agents

### 💾 Data Pipeline Template
**Perfect for:** ETL, data processing, analytics pipelines
**Includes:** data-processing + 13 universal agents
**Agent Count:** 14 agents

### 🖥️ Desktop App Template
**Perfect for:** Electron, Tauri, native desktop applications
**Includes:** desktop-development + 13 universal agents
**Agent Count:** 14 agents

### 📦 Library Template
**Perfect for:** npm packages, Python libraries, Rust crates
**Includes:** library-development + 13 universal agents
**Agent Count:** 14 agents

### ⚡ Minimal Template
**Perfect for:** Simple projects, quick prototypes
**Includes:** 13 universal agents only
**Agent Count:** 13 agents

## 🛠️ Technology Support

### Languages & Frameworks
- **Frontend:** React, Vue, Angular, Svelte, Next.js, Nuxt
- **Backend:** Express, FastAPI, Django, Flask, Spring Boot, Rails
- **Mobile:** React Native, Flutter, Ionic
- **Database:** PostgreSQL, MySQL, MongoDB, SQLite, Redis, Firestore
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
  "name": "resource-management",
  "description": "Resource CRUD operations specialist",
  "prompt": "Handle resource operations for {{PROJECT_NAME}}..."
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
- `{{RESOURCE_NAME}}` - Primary entity (task, post, product)
- `{{WORKFLOW_NAME}}` - Main workflow process

### Conditional Agents
Based on project analysis:
- **Authentication detected?** → Include auth-troubleshoot
- **Database found?** → Include db-query
- **Testing setup?** → Include api-testing, end-to-end-testing
- **Calendar features?** → Include calendar-integration

### Resource Path Adaptation
```json
"resources": [
  "file://{{FRONTEND_DIR}}/**/*.{{FILE_EXT}}",
  "file://{{BACKEND_DIR}}/**/*.ts", 
  "file://{{CONFIG_DIR}}/**/*.json"
]
```

## 🔧 Template Validation

The repository includes a configurable validation system to ensure templates remain generic and reusable.

### Validation Configuration

Create or edit `.template-validation` to specify project-specific terms that should not appear in templates:

```bash
# Add terms that indicate hardcoded project references
MyCompanyName
my-specific-project
hardcoded-database-id
specific-domain.com
```

### Running Validation

```bash
./scripts/validate-template.sh
```

This checks for:
- Required directory structure
- Valid JSON syntax  
- Template variable usage
- Hardcoded references (from `.template-validation`)
- Agent completeness

### Template Testing

```bash
./scripts/test-template.sh
```

Validates template integrity and installation process.

## 🏗️ Creating Custom Templates

Use the template creation script to generate new template variants:

```bash
./scripts/create-template.sh <template-name> [base-template]
```

Available template types:
- `api-service` - REST API backend service
- `mobile-app` - React Native/Flutter mobile app
- `desktop-app` - Electron/Tauri desktop application
- `data-pipeline` - ETL/data processing pipeline
- `library` - Reusable library/package

Example:
```bash
./scripts/create-template.sh api-service
./scripts/create-template.sh mobile-app baseTemplate
```

## 📊 Performance Benefits

### Universal Template Optimizations
- ⚡ **90% faster agent loading** - Focused prompts vs. bloated documentation
- 🧠 **Better context management** - Hybrid architecture prevents context bloat
- 🎯 **Higher accuracy** - Specialized agents for specific tasks
- 🔄 **Easier maintenance** - Standardized structure and formats

### Metrics
- **All agents under 3,000 characters** (was up to 8,400+)
- **22+ standardized agents** (was inconsistent mix)
- **100% JSON format** (was mix of JSON, MD, PY)
- **Hybrid documentation** (focused agents + detailed guides)

## 🚀 Getting Started Examples

### React + TypeScript Web App
```bash
# Navigate to your project
cd my-react-app

# Install template
/path/to/kiroTemplate/baseTemplate/install-kiro-template.sh

# Initialize and configure everything
kiro-cli --agent kiro-setup
# Prompt: "Set up my development environment"
# Detects: React, TypeScript, Vite, Tailwind
# Sets up: Browser testing, development environment
# Configures: All agents and MCP servers

# Analyze project for customizations
kiro-cli --agent project-detector
# Prompt: "Analyze my project"
# Output: Recommends frontend-development, ui-components agents

# Apply recommendations
kiro-cli --agent template-manager
# Prompt: "Add React development agents"

# Start automated testing
kiro-cli --agent automated-browser-testing
# Prompt: "Test my React application"
```

### Express API Service
```bash
# Navigate to your project
cd my-api-service

# Install API service template
/path/to/kiroTemplate/templates/api-service/install-kiro-template.sh

# Initialize and configure everything
kiro-cli --agent kiro-setup
# Prompt: "Set up my development environment"
# Detects: Express, TypeScript, PostgreSQL, Jest
# Sets up: API testing, database tools, browser automation
# Configures: All development tools

# Analyze and customize
kiro-cli --agent project-detector
# Prompt: "Analyze my project"
# Output: Confirms API service setup, suggests database agents

# Test API endpoints
kiro-cli --agent automated-browser-testing
# Prompt: "Test my API endpoints"
```
```

### Data Processing Pipeline
```bash
# Navigate to your project
cd my-data-pipeline

# Install data pipeline template
/path/to/kiroTemplate/templates/data-pipeline/install-kiro-template.sh

# Auto-detect and customize
kiro-cli --agent project-detector
# Detects: Python, pandas, PostgreSQL, Airflow
# Customizes: data-processing, pipeline-workflow, data-validation
# Sets up: Database MCP, monitoring tools
```

## 🎯 Best Practices

## 🎯 Best Practices

1. **Always run kiro-setup first** - Ensures complete initialization including browser testing
   - Prompt: **"Set up my development environment"**
2. **Use project-detector for analysis** - Understands your specific project needs
   - Prompt: **"Analyze my project"**
3. **Use template-manager for customization** - Implements recommended agents
   - Prompt: **"Implement my project-detector recommendations"** or **"Add [technology] agents"**
4. **Leverage automated testing** - Test web applications with visual evidence
   - Prompt: **"Test my web application"** or **"Test my API endpoints"**
5. **Keep agents focused** - Let detailed guides handle complexity
6. **Update regularly** - Use self-improve agent for continuous optimization
   - Prompt: **"Optimize my Kiro CLI setup"**
7. **Validate templates** - Use validation scripts to ensure quality

## 📋 Essential Agent Prompts

### Core Setup Agents
- **`template-installer`**: *"Install the best template for my project"*
- **`kiro-setup`**: *"Set up my development environment"*
- **`project-detector`**: *"Analyze my project"*
- **`template-manager`**: *"Implement my project-detector recommendations"*
- **`automated-browser-testing`**: *"Test my web application"*

### Development Agents
- **`code-analysis`**: *"Analyze my code quality"*
- **`code-refactor`**: *"Refactor this messy code"*
- **`dependency-management`**: *"Update my dependencies"*
- **`environment-setup`**: *"Configure my development environment"*

### Project Management
- **`project-status`**: *"Generate project status report"*
- **`docs-navigator`**: *"Help me organize documentation"*
- **`self-improve`**: *"Optimize my Kiro CLI setup"*

## 📈 Success Stories

**Universal Template System:**
- Reduced agent count from 24+ to 13 essential agents
- Standardized all agents with consistent JSON format
- Implemented hybrid architecture for better maintainability
- Achieved 100% universal compatibility across project types
- Added automated browser testing with screenshot evidence

**Template Benefits:**
- Faster project setup (5 minutes vs. 30+ minutes)
- Consistent development experience across projects
- Reduced learning curve for new team members
- Scalable architecture that grows with projects
- Built-in testing capabilities with visual evidence
- Zero hardcoded references - truly reusable
- Configurable validation for quality assurance

## 📋 Quick Reference

### Essential Commands
```bash
# Setup new project (run from your project root)
cd /path/to/your/project
/path/to/kiroTemplate/baseTemplate/install-kiro-template.sh

# Initialize and configure everything
kiro-cli --agent kiro-setup
# Prompt: "Set up my development environment"

# Analyze and customize
kiro-cli --agent project-detector
# Prompt: "Analyze my project"

kiro-cli --agent template-manager
# Prompt: "Implement my project-detector recommendations"

# Create custom template
./scripts/create-template.sh <type>

# Validate templates
./scripts/validate-template.sh

# Test template system
./scripts/test-template.sh

# Daily workflow
kiro-cli --agent automated-browser-testing  # "Test my web application"
kiro-cli --agent code-analysis             # "Analyze my code quality"
kiro-cli --agent self-improve              # "Optimize my Kiro CLI setup"
```

### Directory Structure
```
kiroTemplate/
├── baseTemplate/           # Full-featured universal template
├── templates/             # Specialized template variants
│   ├── api-service/       # REST API backend
│   ├── mobile-app/        # React Native/Flutter
│   ├── desktop-app/       # Electron/Tauri desktop
│   ├── data-pipeline/     # ETL/data processing
│   ├── web-app/           # Frontend web applications
│   ├── library/           # Reusable library/package
│   └── minimal/           # Lightweight template
├── scripts/               # Template management scripts
├── .template-validation   # Configurable validation patterns
└── work/                  # Development notes (gitignored)
```

---

**Ready to supercharge your development with AI-assisted coding!** 🚀

*Based on battle-tested universal template architecture with configurable validation*

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
  "name": "resource-management",
  "description": "Resource CRUD operations specialist",
  "prompt": "Handle resource operations for {{PROJECT_NAME}}..."
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

### Universal Template Optimizations
- ⚡ **90% faster agent loading** - Focused prompts vs. bloated documentation
- 🧠 **Better context management** - Hybrid architecture prevents context bloat
- 🎯 **Higher accuracy** - Specialized agents for specific tasks
- 🔄 **Easier maintenance** - Standardized structure and formats

### Metrics
- **All agents under 3,000 characters** (was up to 8,400+)
- **22+ standardized agents** (was inconsistent mix)
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

## 🔧 Template Validation

The repository includes a configurable validation system to ensure templates remain generic and reusable.

### Validation Configuration

Create or edit `.template-validation` to specify project-specific terms that should not appear in templates:

```bash
# Add terms that indicate hardcoded project references
MyCompanyName
my-specific-project
hardcoded-database-id
specific-domain.com
```

### Running Validation

```bash
./scripts/validate-template.sh
```

This checks for:
- Required directory structure
- Valid JSON syntax  
- Template variable usage
- Hardcoded references (from `.template-validation`)
- Agent completeness

### Template Testing

```bash
./scripts/test-template.sh
```

Validates template integrity and installation process.

## 📈 Success Stories

**Universal Template System:**
- Reduced agent complexity by 84% (8,427 → 1,383 chars)
- Standardized 22+ agents with consistent performance
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

*Based on battle-tested universal template architecture with automated browser testing*
