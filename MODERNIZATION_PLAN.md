# Kiro Template Modernization Plan

## Current Issues
1. **Outdated agent architecture** - Still using .md agents and .py files
2. **Missing optimized agents** - Lacks the 22 standardized agents from Recipe Raiders
3. **No hybrid architecture** - Missing docs/ directory for detailed guides
4. **Inconsistent structure** - Mixed formats, outdated patterns
5. **Basic template manager** - Not leveraging advanced learnings

## Transformation Strategy

### 1. Update Base Template with Recipe Raiders Architecture
- Replace outdated agents with 22 optimized JSON agents
- Implement hybrid architecture (focused agents + detailed docs)
- Add docs/, patterns/, prompts/ directories
- Standardize all agents under 3,000 characters

### 2. Create Project-Specific Agent Templates
- **Web App Template**: frontend, backend, firebase, cooking-workflow → ui-components, api-integration, deployment, user-workflow
- **API Service Template**: backend, api-testing, db-query → api-design, testing-automation, database-optimization
- **Mobile App Template**: frontend, backend → mobile-ui, native-integration, app-store-deployment

### 3. Enhanced Template Manager Agent
- Auto-detect project type and technology stack
- Generate project-specific agents from base templates
- Customize steering documents for project context
- Set up appropriate MCP servers and workflows

### 4. Template Customization System
- Variable substitution in agent prompts ({{PROJECT_NAME}}, {{TECH_STACK}})
- Conditional agent inclusion based on project needs
- Dynamic resource path generation
- Technology-specific pattern libraries

## Implementation Steps

1. **Modernize baseTemplate** with Recipe Raiders architecture
2. **Update template-manager** with advanced capabilities
3. **Create project-specific templates** for different use cases
4. **Add customization engine** for dynamic agent generation
5. **Test and validate** template installations
