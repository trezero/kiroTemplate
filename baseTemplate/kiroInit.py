#!/usr/bin/env python3
"""
Kiro CLI Project Initialization Script
Configures .kiroTemplate folder for a new project with customized agents, steering docs, and workflows.
"""

import os
import json
import shutil
import sys
from pathlib import Path
from typing import Dict, List, Optional

class KiroInitializer:
    def __init__(self):
        self.template_dir = Path(__file__).parent
        self.project_info = {}
        
    def collect_project_info(self) -> Dict:
        """Collect project information through interactive prompts"""
        print("🚀 Kiro CLI Project Initialization")
        print("=" * 50)
        
        info = {}
        
        # Basic project info
        info['project_name'] = input("Project name: ").strip()
        info['project_description'] = input("Project description: ").strip()
        info['project_type'] = self._select_option(
            "Project type:",
            ["web-app", "api-service", "desktop-app", "mobile-app", "library", "other"]
        )
        
        # Technology stack
        print("\n📚 Technology Stack")
        info['frontend_framework'] = self._select_option(
            "Frontend framework:",
            ["react", "vue", "angular", "svelte", "vanilla-js", "none"]
        )
        
        info['backend_framework'] = self._select_option(
            "Backend framework:",
            ["express", "fastapi", "django", "flask", "spring-boot", "rails", "none"]
        )
        
        info['database'] = self._select_option(
            "Database:",
            ["postgresql", "mysql", "mongodb", "sqlite", "redis", "none"]
        )
        
        info['language'] = self._select_option(
            "Primary language:",
            ["typescript", "javascript", "python", "java", "go", "rust", "other"]
        )
        
        # Development preferences
        print("\n⚙️ Development Preferences")
        info['testing_framework'] = self._select_option(
            "Testing framework:",
            ["jest", "vitest", "pytest", "junit", "go-test", "cargo-test", "none"]
        )
        
        info['deployment_platform'] = self._select_option(
            "Deployment platform:",
            ["aws", "gcp", "azure", "vercel", "netlify", "railway", "docker", "none"]
        )
        
        # Features and integrations
        print("\n🔧 Features & Integrations")
        info['needs_auth'] = self._yes_no("Does your project need authentication?")
        info['needs_api_testing'] = self._yes_no("Do you need API testing tools?")
        info['needs_calendar'] = self._yes_no("Do you need calendar integration?")
        info['needs_database_crud'] = self._yes_no("Do you need database CRUD operations?")
        
        # AI and external services
        info['ai_provider'] = self._select_option(
            "AI provider (if any):",
            ["openai", "anthropic", "google-gemini", "ollama", "none"]
        )
        
        # Development workflow
        print("\n🔄 Development Workflow")
        info['use_git'] = self._yes_no("Using Git for version control?")
        info['team_size'] = self._select_option(
            "Team size:",
            ["solo", "small (2-5)", "medium (6-15)", "large (15+)"]
        )
        
        return info
    
    def _select_option(self, prompt: str, options: List[str]) -> str:
        """Present multiple choice selection"""
        print(f"\n{prompt}")
        for i, option in enumerate(options, 1):
            print(f"  {i}. {option}")
        
        while True:
            try:
                choice = int(input("Select option (number): ")) - 1
                if 0 <= choice < len(options):
                    return options[choice]
                else:
                    print("Invalid selection. Please try again.")
            except ValueError:
                print("Please enter a number.")
    
    def _yes_no(self, prompt: str) -> bool:
        """Simple yes/no prompt"""
        while True:
            response = input(f"{prompt} (y/n): ").lower().strip()
            if response in ['y', 'yes']:
                return True
            elif response in ['n', 'no']:
                return False
            else:
                print("Please enter 'y' or 'n'.")
    
    def update_steering_documents(self):
        """Update steering documents with project-specific information"""
        print("\n📝 Updating steering documents...")
        
        # Update product.md
        self._update_product_md()
        
        # Update tech.md
        self._update_tech_md()
        
        # Update structure.md
        self._update_structure_md()
        
        # Update session-init.md
        self._update_session_init_md()
        
        # Update authentication.md if needed
        if self.project_info['needs_auth']:
            self._update_authentication_md()
        
        # Remove Continuum-specific docs
        self._remove_continuum_specific_docs()
    
    def _update_product_md(self):
        """Update product overview with project info"""
        content = f"""# Product Overview

## Project Status Reference
**IMPORTANT:** Always check `docs/projectStatus.md` for the current state of all components, testing status, and known issues before starting any development work.

## Product Purpose
{self.project_info['project_description']}

**Core Differentiator:** [Define what makes your {self.project_info['project_type']} unique]

## Target Users
- **Primary:** [Define your primary user base]
- **Characteristics:** [User characteristics and needs]
- **Core Struggles:** [Problems your product solves]

## Key Features

### Phase 1 (Current Implementation)
- [List current features and capabilities]

### Phase 2 (Planned)
- [List planned features and enhancements]

## Business Objectives
- **Primary Goal:** [Main business objective]
- **Success Philosophy:** [How you measure success]
- **Key Metrics:** [Important metrics to track]

## User Journey
1. **Onboarding:** [How users get started]
2. **Daily Flow:** [Typical user workflow]
3. **Key Actions:** [Important user actions]

## Success Criteria
**Primary Success Signal:** [Main indicator of success]

**Behavioral Indicators:**
- [User behavior that indicates success]
- [Engagement patterns to track]

**Technical Success:**
- [Technical metrics and thresholds]

## Current Feature Set
[Document current implemented features]

## Development Status
**Phase:** Phase 1 - Initial Development
**Status:** 🟡 In Development
**Technology Stack:** {self.project_info['language']}, {self.project_info['frontend_framework']}, {self.project_info['backend_framework']}
"""
        
        with open(self.template_dir / "steering" / "product.md", "w") as f:
            f.write(content)
    
    def _update_tech_md(self):
        """Update technical architecture document"""
        content = f"""# Technical Architecture

## Technology Stack

### Frontend
- **Framework:** {self.project_info['frontend_framework'].title()}
- **Language:** {self.project_info['language'].title()}
- **Build Tool:** [Your build tool]
- **Styling:** [Your styling solution]

### Backend
- **Framework:** {self.project_info['backend_framework'].title()}
- **Language:** {self.project_info['language'].title()}
- **API:** RESTful endpoints with validation
- **File Structure:** Modular services with clear separation of concerns

### Database
- **Primary:** {self.project_info['database'].title()}
- **ORM/ODM:** [Your database abstraction layer]

### Testing
- **Framework:** {self.project_info['testing_framework'].title()}
- **Strategy:** [Your testing approach]

### Deployment
- **Platform:** {self.project_info['deployment_platform'].title()}
- **Environment:** [Development/staging/production setup]

## Architecture Overview

### Core Components
[Describe your main application components]

### Data Models
[Document your key data structures]

## API Endpoints
[Document your API structure]

## Development Environment

### Prerequisites
- {self.project_info['language'].title()}
- {self.project_info['database'].title()}
- Git

### Setup Commands
```bash
# Add your setup commands here
npm install  # or equivalent
# Database setup
# Environment configuration
```

### Environment Variables
```bash
# Add your required environment variables
DATABASE_URL=
API_KEY=
```

## Code Standards

### File Organization
[Describe your file structure]

### Naming Conventions
[Document your naming standards]

### Testing Strategy
[Describe your testing approach]

## Performance Requirements
[Document performance expectations]

## Security Considerations
[Document security measures]
"""
        
        with open(self.template_dir / "steering" / "tech.md", "w") as f:
            f.write(content)
    
    def _update_structure_md(self):
        """Update project structure document"""
        content = f"""# Project Structure

## Directory Layout

### Root Structure
```
{self.project_info['project_name']}/
├── src/                   # Source code
├── tests/                 # Test files
├── docs/                  # Documentation
├── .kiro/                 # Kiro CLI configuration
└── README.md              # Project overview
```

## File Naming Conventions

### General Rules
- Use kebab-case for files and directories
- Use PascalCase for classes and components
- Use camelCase for functions and variables
- Use UPPER_CASE for constants

## Module Organization

### Source Code
[Describe your source code organization]

### Tests
[Describe your test organization]

### Documentation
[Describe your documentation structure]

## Configuration Files

### Root Configuration
- `package.json` - Dependencies and scripts (if applicable)
- `.env` - Environment variables
- `README.md` - Project overview

## Development Workflow
[Describe your development process]

## Build Artifacts
[Describe build outputs and artifacts]
"""
        
        with open(self.template_dir / "steering" / "structure.md", "w") as f:
            f.write(content)
    
    def _update_session_init_md(self):
        """Update session initialization checklist"""
        content = f"""# Session Initialization Checklist

## Required Reading for New Sessions

Before starting any development work, always review:

1. **`docs/projectStatus.md`** - Current status of all components, testing results, and known issues
2. **`.kiro/steering/product.md`** - Product overview and objectives  
3. **`.kiro/steering/tech.md`** - Technical architecture and stack
4. **`.kiro/steering/structure.md`** - Project structure and conventions

## Current Development Context

**Project:** {self.project_info['project_name']}
**Type:** {self.project_info['project_type']}
**Phase:** Phase 1 - Initial Development
**Status:** 🟡 In Development
**Technology:** {self.project_info['language']}, {self.project_info['frontend_framework']}, {self.project_info['backend_framework']}

## Development Priorities

**Immediate:** [Current sprint priorities]
**Short Term:** [Next 2-4 weeks]
**Medium Term:** [Next 1-3 months]

## Working Components (Safe to Build On)
- [List stable, working components]

## Components Needing Work
- [List components in development or needing attention]

This checklist ensures every new session starts with full context of the project's current state.
"""
        
        with open(self.template_dir / "steering" / "session-init.md", "w") as f:
            f.write(content)
    
    def _update_authentication_md(self):
        """Update authentication document if auth is needed"""
        if not self.project_info['needs_auth']:
            # Remove auth doc if not needed
            auth_file = self.template_dir / "steering" / "authentication.md"
            if auth_file.exists():
                auth_file.unlink()
            return
        
        content = """# Authentication Architecture

## Overview

[Describe your authentication system]

## Authentication Flow Architecture

### User Authentication
[Describe your user auth flow]

### API Authentication
[Describe your API auth]

## Database Schema

### User Tables
[Document user-related tables]

## API Endpoints

### Authentication
[Document auth endpoints]

## Security Implementation

### Token Management
[Describe token handling]

### Security Considerations
[Document security measures]

## Configuration

### Environment Variables
[List required auth environment variables]

## Troubleshooting
[Common auth issues and solutions]
"""
        
        with open(self.template_dir / "steering" / "authentication.md", "w") as f:
            f.write(content)
    
    def _remove_continuum_specific_docs(self):
        """Remove Continuum-specific documentation"""
        docs_to_remove = [
            "calendarIntegration.md",
            "common-pitfalls.md",
            "form-validation-patterns.md"
        ]
        
        for doc in docs_to_remove:
            doc_path = self.template_dir / "steering" / doc
            if doc_path.exists():
                doc_path.unlink()
    
    def configure_agents(self):
        """Configure agents based on project needs"""
        print("\n🤖 Configuring specialized agents...")
        
        # Always include core agents
        self._create_core_agents()
        
        # Conditional agents based on project needs
        if self.project_info['needs_api_testing']:
            self._update_api_testing_agent()
        else:
            self._remove_agent("api-testing.json")
        
        if self.project_info['needs_calendar']:
            self._update_calendar_agent()
        else:
            self._remove_agent("calendar-integration.json")
        
        if self.project_info['needs_database_crud']:
            self._update_crud_agent()
        else:
            self._remove_agent("crud-pattern.json")
        
        # Update agent README
        self._update_agent_readme()
    
    def _create_core_agents(self):
        """Create core agents that every project needs"""
        
        # Code refactor agent
        refactor_agent = {
            "name": "code-refactor",
            "description": f"Specialized agent for refactoring {self.project_info['language']} code with focus on maintainability and performance",
            "prompt": f"You are a code refactoring specialist for {self.project_info['language']} projects. Focus on improving code quality, maintainability, and performance while preserving functionality.",
            "tools": ["read", "write", "grep", "glob"],
            "allowedTools": ["read", "write", "grep", "glob"],
            "resources": [
                "file://src/**/*",
                "file://.kiro/steering/tech.md",
                "file://.kiro/steering/structure.md"
            ]
        }
        
        with open(self.template_dir / "agents" / "code-refactor.json", "w") as f:
            json.dump(refactor_agent, f, indent=2)
        
        # Self-improve agent (keep as-is, it's generic)
        # Project status agent
        status_agent_md = f"""# Project Status Agent

## Purpose
Maintains and updates project status documentation for {self.project_info['project_name']}.

## Usage
```bash
kiro-cli --agent projectStatus
> Update project status with latest developments
> Generate status report for stakeholders
```

## Responsibilities
- Track feature development progress
- Document completed work
- Identify blockers and next steps
- Maintain project timeline
"""
        
        with open(self.template_dir / "agents" / "projectStatus.md", "w") as f:
            f.write(status_agent_md)
    
    def _update_api_testing_agent(self):
        """Update API testing agent for project-specific needs"""
        agent_config = self._load_agent_config("api-testing.json")
        
        # Update resources based on project structure
        resources = [
            "file://src/**/*.ts",  # Adjust based on language
            "file://tests/**/*.test.*",
            "file://.kiro/steering/tech.md",
            "file://.kiro/steering/structure.md"
        ]
        
        agent_config["resources"] = resources
        agent_config["description"] = f"Generates API tests and debugging tools for {self.project_info['project_name']} using {self.project_info['testing_framework']}"
        
        with open(self.template_dir / "agents" / "api-testing.json", "w") as f:
            json.dump(agent_config, f, indent=2)
    
    def _update_calendar_agent(self):
        """Update calendar integration agent"""
        # Keep the existing calendar agent but update description
        agent_config = self._load_agent_config("calendar-integration.json")
        agent_config["description"] = f"Calendar integration specialist for {self.project_info['project_name']}"
        
        with open(self.template_dir / "agents" / "calendar-integration.json", "w") as f:
            json.dump(agent_config, f, indent=2)
    
    def _update_crud_agent(self):
        """Update CRUD pattern agent"""
        agent_config = self._load_agent_config("crud-pattern.json")
        agent_config["description"] = f"Generates CRUD operations for {self.project_info['project_name']} using {self.project_info['database']}"
        
        with open(self.template_dir / "agents" / "crud-pattern.json", "w") as f:
            json.dump(agent_config, f, indent=2)
    
    def _load_agent_config(self, filename: str) -> Dict:
        """Load existing agent configuration"""
        try:
            with open(self.template_dir / "agents" / filename, "r") as f:
                return json.load(f)
        except FileNotFoundError:
            return {}
    
    def _remove_agent(self, filename: str):
        """Remove agent file if not needed"""
        agent_path = self.template_dir / "agents" / filename
        if agent_path.exists():
            agent_path.unlink()
    
    def _update_agent_readme(self):
        """Update agent README with project-specific information"""
        content = f"""# {self.project_info['project_name']} Agents

## Available Agents

### Core Agents
- **code-refactor**: {self.project_info['language']} code refactoring specialist
- **selfImprove**: Kiro CLI efficiency improvement agent
- **projectStatus**: Project status tracking and reporting

"""
        
        if self.project_info['needs_api_testing']:
            content += f"### API Testing\n- **api-testing**: {self.project_info['testing_framework']} test generation and API debugging\n\n"
        
        if self.project_info['needs_calendar']:
            content += "### Integrations\n- **calendar-integration**: Calendar API integration specialist\n\n"
        
        if self.project_info['needs_database_crud']:
            content += f"### Database\n- **crud-pattern**: {self.project_info['database']} CRUD operation generator\n\n"
        
        content += f"""## Usage

```bash
# Start with specific agent
kiro-cli --agent code-refactor

# List all agents
kiro-cli --agent list
```

## Agent Development

Add new agents to `.kiro/agents/` directory. See existing agents for patterns.
"""
        
        with open(self.template_dir / "agents" / "README.md", "w") as f:
            f.write(content)
    
    def configure_mcp_servers(self):
        """Configure MCP servers and provide installation instructions"""
        print("\n🔌 Configuring MCP servers...")
        
        # Update MCP configuration
        mcp_config = {
            "mcpServers": {}
        }
        
        # Always include Context7 for documentation
        mcp_config["mcpServers"]["context7"] = {
            "command": "npx",
            "args": ["@upstash/context7-mcp"],
            "env": {}
        }
        
        # Add Chrome DevTools if it's a web project
        if self.project_info['project_type'] in ['web-app', 'frontend']:
            mcp_config["mcpServers"]["chrome-devtools"] = {
                "command": "node",
                "args": [".kiro/mcp-servers/chrome-devtools-mcp/build/src/index.js"],
                "env": {}
            }
        
        # Add project-specific MCP servers based on needs
        if self.project_info['needs_auth'] and 'firebase' in self.project_info.get('auth_provider', ''):
            mcp_config["mcpServers"]["firebase"] = {
                "command": "node",
                "args": [".kiro/mcp-servers/firebase/index.js"],
                "env": {}
            }
        
        with open(self.template_dir / "settings" / "mcp.json", "w") as f:
            json.dump(mcp_config, f, indent=2)
        
        # Clean up unused MCP servers
        self._cleanup_mcp_servers(mcp_config)
    
    def _cleanup_mcp_servers(self, mcp_config: Dict):
        """Remove unused MCP server directories"""
        mcp_servers_dir = self.template_dir / "mcp-servers"
        
        # Keep only configured servers
        configured_servers = set()
        for server_name, config in mcp_config["mcpServers"].items():
            if ".kiro/mcp-servers/" in " ".join(config.get("args", [])):
                configured_servers.add(server_name)
        
        # Remove unused server directories
        if mcp_servers_dir.exists():
            for server_dir in mcp_servers_dir.iterdir():
                if server_dir.is_dir() and server_dir.name not in configured_servers:
                    shutil.rmtree(server_dir)
    
    def create_workflows(self):
        """Create project-specific workflows"""
        print("\n🔄 Creating workflows...")
        
        # Update session init workflow
        session_init = f"""# Session Initialization Protocol for {self.project_info['project_name']}

## Standard Project Analysis Sequence
1. **Project Status Check**
   - Review current development phase
   - Check for any blockers or issues
   - Validate environment setup

2. **Technology Stack Validation**
   - Verify {self.project_info['language']} environment
   - Check {self.project_info['frontend_framework']} setup
   - Validate {self.project_info['database']} connection

3. **Dependency Audit**
   - Scan for outdated packages
   - Check for security vulnerabilities
   - Validate configuration files

4. **Integration Status**
   - Test external service connections
   - Verify API endpoints
   - Check authentication flows

5. **Documentation Update**
   - Update project status
   - Log any issues found
   - Update architecture notes

Use this protocol at session start for comprehensive project understanding.
"""
        
        with open(self.template_dir / "workflows" / "sessionInit.md", "w") as f:
            f.write(session_init)
        
        # Create project-specific feature prompts
        feature_prompts = f"""# Feature Development Prompts for {self.project_info['project_name']}

## New Feature Development
```
I need to implement [feature name] for {self.project_info['project_name']}.

Requirements:
- [List requirements]
- Technology: {self.project_info['language']}, {self.project_info['frontend_framework']}
- Database: {self.project_info['database']}

Please:
1. Analyze the current codebase structure
2. Design the feature architecture
3. Implement following our established patterns
4. Add appropriate tests using {self.project_info['testing_framework']}
5. Update documentation
```

## Bug Fix Template
```
I found a bug in {self.project_info['project_name']}:

Issue: [Describe the problem]
Expected: [Expected behavior]
Actual: [Actual behavior]
Steps to reproduce: [Steps]

Please investigate and fix while maintaining code quality standards.
```

## Code Review Template
```
Please review this code for {self.project_info['project_name']}:

Focus areas:
- Code quality and maintainability
- Performance implications
- Security considerations
- Adherence to project patterns
- Test coverage
```
"""
        
        with open(self.template_dir / "workflows" / "feature-prompts.md", "w") as f:
            f.write(feature_prompts)
    
    def create_patterns(self):
        """Create project-specific patterns and templates"""
        print("\n📋 Creating patterns...")
        
        # Project status pattern
        status_pattern = f"""# Project Status Pattern for {self.project_info['project_name']}

## Status Structure
```
# {self.project_info['project_name']} Status - [Date]

## Active Features
- [Feature]: [Status] - [Next Action]

## Completed This Session
- [Achievement 1]
- [Achievement 2]

## Next Session Priority
1. [Priority 1]
2. [Priority 2]

## Technology Health
- {self.project_info['language']}: [Status]
- {self.project_info['frontend_framework']}: [Status]
- {self.project_info['database']}: [Status]

## Context Preservation
- Key decisions made
- Patterns established
- Workflows created
```

## Update Triggers
- Feature completion
- Session end
- Major decisions
- Architecture changes

## Location
`.kiro/status.md` - Always current project state
"""
        
        with open(self.template_dir / "patterns" / "project-status.md", "w") as f:
            f.write(status_pattern)
    
    def finalize_setup(self):
        """Finalize the setup and rename to .kiro"""
        print("\n✅ Finalizing setup...")
        
        # Create initial project status
        initial_status = f"""# {self.project_info['project_name']} Status - {self._get_current_date()}

## Project Overview
- **Name**: {self.project_info['project_name']}
- **Type**: {self.project_info['project_type']}
- **Language**: {self.project_info['language']}
- **Framework**: {self.project_info['frontend_framework']}
- **Database**: {self.project_info['database']}

## Current Phase
Phase 1 - Initial Setup and Development

## Active Features
- Project initialization: ✅ Complete
- Kiro CLI configuration: ✅ Complete
- Development environment: 🟡 In Progress

## Next Session Priority
1. Set up development environment
2. Initialize project structure
3. Configure build tools
4. Set up testing framework

## Technology Health
- {self.project_info['language']}: 🟡 Setup needed
- {self.project_info['frontend_framework']}: 🟡 Setup needed
- {self.project_info['database']}: 🟡 Setup needed

## Context Preservation
- Kiro CLI template configured for {self.project_info['project_name']}
- Specialized agents created based on project needs
- MCP servers configured for development workflow
"""
        
        with open(self.template_dir / "status.md", "w") as f:
            f.write(initial_status)
        
        # Rename .kiroTemplate to .kiro
        target_dir = self.template_dir.parent / ".kiro"
        if target_dir.exists():
            shutil.rmtree(target_dir)
        
        shutil.move(str(self.template_dir), str(target_dir))
        
        print(f"\n🎉 Setup complete! .kiroTemplate has been renamed to .kiro")
        print(f"📁 Project: {self.project_info['project_name']}")
        print(f"🔧 Technology: {self.project_info['language']}, {self.project_info['frontend_framework']}, {self.project_info['database']}")
        
        self._print_next_steps()
    
    def _get_current_date(self) -> str:
        """Get current date in YYYY-MM-DD format"""
        from datetime import datetime
        return datetime.now().strftime("%Y-%m-%d")
    
    def _print_next_steps(self):
        """Print next steps for the user"""
        print("\n📋 Next Steps:")
        print("1. Start a new Kiro CLI session:")
        print("   kiro-cli")
        print("\n2. Install MCP servers:")
        print("   npx @upstash/context7-mcp  # Documentation search")
        
        if self.project_info['project_type'] in ['web-app', 'frontend']:
            print("   # Chrome DevTools MCP server is already included")
        
        print("\n3. Initialize your project structure:")
        print(f"   # Set up {self.project_info['language']} project")
        print(f"   # Configure {self.project_info['frontend_framework']} if applicable")
        print(f"   # Set up {self.project_info['database']} if applicable")
        
        print("\n4. Available specialized agents:")
        agents = ["code-refactor", "selfImprove", "projectStatus"]
        if self.project_info['needs_api_testing']:
            agents.append("api-testing")
        if self.project_info['needs_calendar']:
            agents.append("calendar-integration")
        if self.project_info['needs_database_crud']:
            agents.append("crud-pattern")
        
        for agent in agents:
            print(f"   kiro-cli --agent {agent}")
        
        print("\n5. Review configuration:")
        print("   - Check .kiro/steering/ documents")
        print("   - Customize agents in .kiro/agents/")
        print("   - Review MCP servers in .kiro/settings/mcp.json")
        
        print(f"\n🚀 Ready to start developing {self.project_info['project_name']}!")
    
    def run(self):
        """Run the complete initialization process"""
        try:
            self.project_info = self.collect_project_info()
            self.update_steering_documents()
            self.configure_agents()
            self.configure_mcp_servers()
            self.create_workflows()
            self.create_patterns()
            self.finalize_setup()
            
        except KeyboardInterrupt:
            print("\n\n❌ Setup cancelled by user")
            sys.exit(1)
        except Exception as e:
            print(f"\n❌ Error during setup: {e}")
            sys.exit(1)

if __name__ == "__main__":
    initializer = KiroInitializer()
    initializer.run()
