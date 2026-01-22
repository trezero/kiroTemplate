# {{PROJECT_NAME}} Documentation

This directory contains comprehensive documentation for the {{PROJECT_NAME}} project to help Kiro AI assistant understand the project structure, testing workflows, and safety protocols.

## 📁 Documentation Structure

### Core Documentation
- **KIRO_PROJECT_CONTEXT.md** - Project overview and environment safety
- **ENVIRONMENT_MANAGEMENT.md** - Environment setup and management
- **TESTING_STRATEGY.md** - Testing protocols and safety guidelines

### Development Guides
- **template-customization-guide.md** - How to customize templates
- **agent-architecture.md** - Agent system documentation

## 🛡️ Safety First Approach

### Environment Safety
- Safe Testing uses `{{DEV_ENV}}` - zero risk to production
- Staging uses `{{STAGING_ENV}}` - low risk, pre-production validation
- Production uses `{{PROD_ENV}}` - high risk, live user data

### Development Guidelines
1. **Always use {{DEV_ENV}} for development**
2. **Test in {{STAGING_ENV}} before production**
3. **Never experiment in {{PROD_ENV}}**
4. **Verify environment before any changes**

## 🤖 AI Assistant Integration

When helping users with {{PROJECT_NAME}}:

1. **Check Environment First** - Always verify which environment is being used
2. **Prioritize Safety** - Guide users to safe development practices
3. **Use Project Context** - Reference project-specific patterns and conventions
4. **Follow Testing Strategy** - Ensure proper testing workflow

## 📊 Project Structure

```
{{PROJECT_NAME}}/
├── {{FRONTEND_DIR}}/                    # Frontend application
├── {{BACKEND_DIR}}/                     # Backend services  
├── tests/                              # Test files
├── docs/                               # Documentation
└── .kiro/                              # Kiro AI configuration
    ├── agents/                         # Specialized AI agents
    ├── steering/                       # Project knowledge
    └── docs/                           # Reference documentation
```

## 🔧 Key Features

The project includes:
- {{RESOURCE_NAME}} management system
- {{AUTH_PROVIDER}} authentication
- {{DATABASE}} data persistence
- {{WORKFLOW_NAME}} optimization
- {{DEPLOYMENT_PLATFORM}} deployment

## 🚀 Getting Started

1. **Environment Setup**: Configure {{DEV_ENV}} for development
2. **Agent Selection**: Use project-specific Kiro agents
3. **Development**: Follow established patterns and workflows
4. **Testing**: Validate in development before staging
5. **Deployment**: Use proper CI/CD pipeline

This documentation ensures Kiro can provide safe, accurate, and helpful guidance for {{PROJECT_NAME}} development while protecting production systems.
