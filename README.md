# Kiro CLI Project Template

This template provides a comprehensive Kiro CLI setup for new projects with specialized agents, steering documents, workflows, and MCP server configurations.

## Quick Start

1. **Copy template to your new project:**
   ```bash
   cp -r .kiroTemplate /path/to/your/new/project/
   cd /path/to/your/new/project/.kiroTemplate
   ```

2. **Run initialization script:**
   ```bash
   python3 kiroInit.py
   ```

3. **Follow the interactive prompts** to configure your project

4. **Start Kiro CLI:**
   ```bash
   kiro-cli
   ```

## What's Included

### 📚 Steering Documents
- **product.md** - Product overview and objectives (customized for your project)
- **tech.md** - Technical architecture and stack
- **structure.md** - Project structure and conventions
- **session-init.md** - Session initialization checklist
- **authentication.md** - Authentication architecture (if needed)
- **kiro-cli-reference.md** - Complete Kiro CLI reference
- **confucius-ax.md** - Advanced agent experience standards

### 🤖 Specialized Agents
- **code-refactor** - Language-specific code refactoring specialist
- **selfImprove** - Kiro CLI efficiency improvement agent
- **projectStatus** - Project status tracking and reporting
- **api-testing** - API test generation and debugging (optional)
- **calendar-integration** - Calendar API integration specialist (optional)
- **crud-pattern** - Database CRUD operation generator (optional)

### 🔄 Workflows
- **sessionInit.md** - Project-specific session initialization protocol
- **feature-prompts.md** - Templates for common development tasks
- **dependencyCleanup.md** - Dependency management workflow
- **self-improve.md** - Session end improvement protocol

### 🔌 MCP Servers
- **Context7** - Documentation and code search
- **Chrome DevTools** - Browser automation (for web projects)
- **Firebase** - Firebase integration (if using Firebase auth)
- **BMAD** - Custom agent builder tools

### 📋 Patterns & Templates
- **project-status.md** - Status tracking template
- Project-specific patterns based on your technology choices

## Supported Project Types

- **Web Applications** (React, Vue, Angular, etc.)
- **API Services** (Express, FastAPI, Django, etc.)
- **Desktop Applications**
- **Mobile Applications**
- **Libraries and Frameworks**
- **General Software Projects**

## Supported Technologies

### Languages
- TypeScript/JavaScript
- Python
- Java
- Go
- Rust
- And more...

### Frameworks
- **Frontend:** React, Vue, Angular, Svelte
- **Backend:** Express, FastAPI, Django, Flask, Spring Boot, Rails
- **Database:** PostgreSQL, MySQL, MongoDB, SQLite, Redis
- **Testing:** Jest, Vitest, Pytest, JUnit

### Deployment Platforms
- AWS, GCP, Azure
- Vercel, Netlify, Railway
- Docker, Kubernetes

## Features Configured Based on Your Needs

The initialization script will configure different components based on your project requirements:

- **Authentication System** - Includes auth-specific agents and documentation
- **API Testing** - Postman collection generation and test automation
- **Calendar Integration** - Multi-provider calendar API support
- **Database CRUD** - Pattern-based CRUD operation generation
- **AI Integration** - Support for various AI providers

## MCP Server Installation

After initialization, you'll need to install the MCP servers:

### Context7 (Always included)
```bash
npx @upstash/context7-mcp
```

### Chrome DevTools (Web projects)
```bash
# Already included in template, just needs building
cd .kiro/mcp-servers/chrome-devtools-mcp
npm install
npm run build
```

### Firebase (If using Firebase)
```bash
cd .kiro/mcp-servers/firebase
npm install
```

## Customization

After initialization, you can customize:

1. **Agents** - Modify `.kiro/agents/*.json` files
2. **Steering Docs** - Update `.kiro/steering/*.md` files
3. **MCP Servers** - Modify `.kiro/settings/mcp.json`
4. **Workflows** - Customize `.kiro/workflows/*.md` files

## Agent Usage Examples

```bash
# Code refactoring
kiro-cli --agent code-refactor
> Refactor the authentication module for better maintainability

# API testing
kiro-cli --agent api-testing
> Generate Postman collection for all user management endpoints

# Project status
kiro-cli --agent projectStatus
> Update project status with this week's progress

# CRUD operations
kiro-cli --agent crud-pattern
> Create a complete user management system with CRUD operations
```

## Best Practices

1. **Start each session** by reviewing `.kiro/steering/session-init.md`
2. **Use specialized agents** for domain-specific tasks
3. **Update project status** regularly using the projectStatus agent
4. **Leverage MCP servers** for enhanced capabilities
5. **Customize agents** as your project evolves

## Troubleshooting

### Common Issues

1. **Python not found**
   ```bash
   # Use python instead of python3
   python kiroInit.py
   ```

2. **Permission denied**
   ```bash
   chmod +x kiroInit.py
   ./kiroInit.py
   ```

3. **MCP servers not working**
   - Check `.kiro/settings/mcp.json` configuration
   - Ensure MCP server dependencies are installed
   - Verify file paths in MCP configuration

### Getting Help

1. Check the Kiro CLI reference: `.kiro/steering/kiro-cli-reference.md`
2. Review agent documentation: `.kiro/agents/README.md`
3. Use the selfImprove agent to optimize your workflow

## Template Maintenance

This template is based on the Continuum project's mature Kiro CLI setup. It includes:

- 13 specialized agents with proven patterns
- Comprehensive steering documentation
- Production-tested MCP server configurations
- Battle-tested workflows and patterns

The template automatically adapts to your project's specific needs while providing the same powerful development experience.

---

**Ready to supercharge your development workflow with AI-assisted coding!** 🚀
