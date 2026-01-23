# Kiro AI Assistant - {{PROJECT_NAME}} Project Context

## Project Overview

**{{PROJECT_NAME}}** is a {{PROJECT_TYPE}} application built with {{TECH_STACK}} that {{PROJECT_DESCRIPTION}}.

## Environment Safety Protocol

### 🧪 Development Environment ({{DEV_ENV}})
- **Purpose**: Safe local development and testing
- **Risk Level**: ✅ **ZERO RISK** - Completely isolated
- **Usage**: Daily development, feature testing, experimentation

### 🔄 Staging Environment ({{STAGING_ENV}})
- **Purpose**: Pre-production testing and validation
- **Risk Level**: ⚠️ **LOW RISK** - Separate from production
- **Usage**: Integration testing, stakeholder reviews

### 🚀 Production Environment ({{PROD_ENV}})
- **Purpose**: Live application serving real users
- **Risk Level**: 🚨 **HIGH RISK** - Affects real users
- **Usage**: Live application only

## Technology Stack

- **Frontend**: {{FRONTEND_FRAMEWORK}}
- **Backend**: {{BACKEND_FRAMEWORK}}
- **Database**: {{DATABASE}}
- **Authentication**: {{AUTH_PROVIDER}}
- **Deployment**: {{DEPLOYMENT_PLATFORM}}

## Project Structure

```
{{PROJECT_NAME}}/
├── {{FRONTEND_DIR}}/                    # Frontend application
│   ├── components/                      # Reusable components
│   ├── pages/                          # Application pages
│   ├── lib/                            # Utility libraries
│   └── contexts/                       # State management
├── {{BACKEND_DIR}}/                     # Backend services
│   ├── routes/                         # API endpoints
│   ├── models/                         # Data models
│   └── middleware/                     # Request middleware
├── tests/                              # Test files
├── docs/                               # Documentation
└── config/                             # Configuration files
```

## Core Features

- {{RESOURCE_NAME}} management and CRUD operations
- User authentication with {{AUTH_PROVIDER}}
- {{DATABASE}} data persistence
- {{WORKFLOW_NAME}} optimization
- Responsive {{PROJECT_TYPE}} interface

## Development Workflow

1. **Setup**: Use {{DEV_ENV}} for all development
2. **Testing**: Validate features in development environment
3. **Integration**: Test in {{STAGING_ENV}} before production
4. **Deployment**: Deploy to {{PROD_ENV}} after validation

## Safety Reminders

- **{{DEV_ENV}}** = ✅ Safe for development and testing
- **{{STAGING_ENV}}** = ⚠️ Use for final validation only
- **{{PROD_ENV}}** = 🚨 Production environment - handle with care

## Key Resources

- Primary entity: {{RESOURCE_NAME}}
- Main workflow: {{WORKFLOW_NAME}}
- Frontend directory: {{FRONTEND_DIR}}/
- Backend directory: {{BACKEND_DIR}}/

## Environment Quick Check

```bash
echo "Current environment: $NODE_ENV"
echo "Database: $DATABASE_URL"
echo "Auth provider: {{AUTH_PROVIDER}}"
```

This documentation ensures Kiro can provide safe, accurate, and helpful guidance for {{PROJECT_NAME}} development while protecting production systems.
