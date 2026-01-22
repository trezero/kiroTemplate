# Template Agent Customization Guide

## Base Agent Templates

All templates start with the 22 optimized agents from {{PROJECT_NAME}}, then customize based on project type:

### Web App Template Customizations
- `resource-management.json` → `component-management.json` (React/Vue component CRUD)
- `cooking-workflow.json` → `user-workflow.json` (User journey and interaction flows)
- `ai-integration.json` → `api-integration.json` (External API integration)
- `firebase.json` → `deployment.json` (Vercel/Netlify/AWS deployment)

### API Service Template Customizations  
- `resource-management.json` → `endpoint-management.json` (API endpoint CRUD)
- `cooking-workflow.json` → `request-workflow.json` (Request/response handling)
- `firebase.json` → `database-management.json` (Database operations)
- `frontend.json` → `api-documentation.json` (API docs and testing)

### Mobile App Template Customizations
- `resource-management.json` → `screen-management.json` (Mobile screen CRUD)
- `cooking-workflow.json` → `navigation-workflow.json` (App navigation flows)
- `firebase.json` → `native-integration.json` (Native platform features)
- `frontend.json` → `mobile-ui.json` (Mobile-specific UI patterns)

## Variable Substitution

Agents use template variables for customization:
- `{{PROJECT_NAME}}` - Project name
- `{{TECH_STACK}}` - Primary technology (React, Express, Flutter, etc.)
- `{{PROJECT_TYPE}}` - web-app, api-service, mobile-app, etc.
- `{{DEPLOYMENT_PLATFORM}}` - Vercel, AWS, Google Cloud, etc.

## Resource Path Templates

Resources adapt to project structure:
- `file://src/{{FRONTEND_DIR}}/**/*.tsx` 
- `file://{{API_DIR}}/**/*.ts`
- `file://{{CONFIG_DIR}}/**/*.json`

## Conditional Agent Inclusion

Based on project analysis:
- **Has authentication?** → Include auth-troubleshoot.json
- **Has database?** → Include db-query.json  
- **Has calendar features?** → Include calendar-integration.json
- **Has testing setup?** → Include api-testing.json, end-to-end-testing.json
