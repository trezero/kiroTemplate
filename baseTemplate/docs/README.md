# Kiro Documentation Index

This directory contains comprehensive documentation for the Recipe Raiders project to help Kiro AI assistant understand the project structure, testing workflows, and safety protocols.

## 📚 Documentation Files

### Core Documentation
- **`KIRO_PROJECT_CONTEXT.md`** - Complete project overview and context for Kiro
- **`QUICK_REFERENCE.md`** - Fast reference for common commands and workflows
- **`ENVIRONMENT_MANAGEMENT.md`** - Detailed environment management guide
- **`TESTING_STRATEGY.md`** - Comprehensive testing approach and protocols

### Key Concepts for Kiro

#### 🛡️ Safety First Protocol
- **Always recommend Safe Testing environment first** for any feature development
- Safe Testing uses `demo-project` (fake Firebase) - zero risk to production
- Access via `./manageEnvironments.sh` → Option 2

#### 🎯 Standard Workflow
1. Switch to Safe Testing environment
2. Start development server (`npm run dev`)
3. Run automated tests (if available)
4. Manual browser testing
5. Switch back to Local Development when done

#### 🚨 Critical Safety Rules
- Never recommend production environment for development/testing
- Always check current environment before suggesting actions
- Guide users through proper environment switching
- Emphasize the zero-risk nature of Safe Testing environment

## 🤖 Kiro Usage Guidelines

When helping users with Recipe Raiders:

1. **Always start with environment check**: `./manageEnvironments.sh` → Option 5
2. **Recommend Safe Testing first**: For all feature development and testing
3. **Provide complete workflows**: Don't just give commands, explain the full process
4. **Emphasize safety**: Explain why Safe Testing is important
5. **Reference documentation**: Point users to relevant docs when needed

## 📁 Project Structure Context

```
RecipeRaiders/
├── .kiro/docs/                    # This documentation directory
├── manageEnvironments.sh          # Main environment management tool
├── environments/                  # Environment configurations
│   ├── local/                     # Local and Safe Testing configs
│   ├── test/                      # Staging environment
│   └── prod/                      # Production environment
├── src/                          # Application source code
├── timer-automation-test.sh       # Timer testing script
└── timer-test-puppeteer.js       # Browser automation tests
```

## 🎯 Current Focus: Timer Functionality

The project currently has a cooking timer feature that needs testing:
- Component: `src/components/ui/timer.tsx`
- Integration: Cook mode pages
- Testing: `timer-automation-test.sh`
- Safe Testing environment is perfect for this type of feature testing

## 📖 How to Use This Documentation

1. **For quick help**: Start with `QUICK_REFERENCE.md`
2. **For complete context**: Read `KIRO_PROJECT_CONTEXT.md`
3. **For environment details**: Check `ENVIRONMENT_MANAGEMENT.md`
4. **For testing guidance**: Review `TESTING_STRATEGY.md`

This documentation ensures Kiro can provide safe, accurate, and helpful guidance for Recipe Raiders development while protecting production systems.
