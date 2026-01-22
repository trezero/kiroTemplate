# Template Customization Guide

## Overview

All templates start with the 22+ optimized agents from the universal template system, then customize based on project type:

### Web App Template Customizations
- `resource-management.json` → `component-management.json` (React/Vue component CRUD)
- `user-workflow.json` → `user-workflow.json` (User journey and interaction flows)
- `backend-services.json` → `deployment.json` (Vercel/Netlify/AWS deployment)

### API Service Template Customizations
- `resource-management.json` → `endpoint-management.json` (API endpoint CRUD)
- `user-workflow.json` → `request-workflow.json` (Request/response handling)
- `backend-services.json` → `database-management.json` (Database operations)

### Mobile App Template Customizations
- `resource-management.json` → `screen-management.json` (Mobile screen CRUD)
- `user-workflow.json` → `navigation-workflow.json` (App navigation flows)
- `backend-services.json` → `native-integration.json` (Native platform features)

## Template Variables

The system uses these template variables for dynamic customization:

- `{{PROJECT_NAME}}` - Project name
- `{{TECH_STACK}}` - Primary technology (React, Express, Flutter, etc.)
- `{{PROJECT_TYPE}}` - web-app, api-service, mobile-app, etc.
- `{{DEPLOYMENT_PLATFORM}}` - Vercel, AWS, Google Cloud, etc.

## Resource Path Adaptation

Templates automatically adapt resource paths based on project structure:

- `file://{{FRONTEND_DIR}}/**/*.{{FILE_EXT}}`
- `file://{{BACKEND_DIR}}/**/*.{{FILE_EXT}}`
- `file://config/**/*.json`

## Agent Customization Process

1. **Base Template**: Start with universal agents
2. **Variable Substitution**: Replace template variables with project values
3. **Agent Specialization**: Transform generic agents to domain-specific ones
4. **Resource Mapping**: Update file paths and resource references
5. **Conditional Inclusion**: Add/remove agents based on project needs

## Creating Custom Templates

Use the template creation script:

```bash
./scripts/create-template.sh <template-name> [base-template]
```

Available template types:
- `api-service` - REST API backend
- `mobile-app` - React Native/Flutter
- `desktop-app` - Electron/Tauri
- `data-pipeline` - ETL/data processing
- `library` - Reusable library/package

## Template Validation

Validate templates with:

```bash
./scripts/validate-template.sh
```

This checks for:
- Required directory structure
- Valid JSON syntax
- Template variable usage
- Hardcoded references
- Agent completeness
