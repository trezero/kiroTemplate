# Kiro AI Assistant - Recipe Raiders Project Context

## 🎯 Project Overview

**Recipe Raiders** is a Next.js application with Firebase backend that helps users create, share, and cook recipes with AI assistance and cooking timers.

## 🛠️ Environment Management System

### Critical Safety Protocol
**ALWAYS use Safe Testing environment for feature development and testing**

### Environment Tool
- **Location**: `./manageEnvironments.sh`
- **Purpose**: Switch between 4 isolated environments safely
- **Usage**: Run from project root directory

### Environment Types
1. **Safe Testing** (Option 2) - ✅ **USE THIS FOR ALL FEATURE TESTING**
   - Firebase: `demo-project` (fake)
   - Zero risk to production/staging
   - Perfect for UI, components, timers, frontend features

2. **Local Development** (Option 1) - ⚠️ Real Firebase, isolated data
3. **Staging** (Option 3) - ⚠️ Affects staging.reciperaiders.com
4. **Production** (Option 4) - 🚨 Affects app.reciperaiders.com (live users)

## 🧪 Standard Testing Workflow

### For Any New Feature Development:

1. **Always start with Safe Testing**:
   ```bash
   ./manageEnvironments.sh  # Select option 2
   npm run dev
   ```

2. **Run available automated tests**:
   ```bash
   # Check for test scripts:
   ls -la *test*.sh *test*.js
   
   # For timer features:
   ./test./test./tests/timer-automation-test.sh
   ```

3. **Manual browser testing**:
   - Open `http://localhost:9002`
   - Test feature thoroughly
   - Verify all functionality

4. **Switch back when done**:
   ```bash
   ./manageEnvironments.sh  # Select option 1 (Local Development)
   ```

## 🎯 Current Feature: Timer Functionality

### Timer Implementation
- **Component**: `src/components/ui/timer.tsx`
- **Integration**: Cook mode (`src/app/recipes/[id]/cook/page.tsx`)
- **Time Parsing**: `src/lib/time-parser.ts`
- **Test Script**: `test./test./tests/timer-automation-test.sh`

### Timer Testing Process
```bash
# 1. Safe environment
./manageEnvironments.sh  # Option 2: Safe Testing

# 2. Start server
npm run dev

# 3. Run automated tests
./test./tests/timer-automation-test.sh

# 4. Manual testing:
# - Create recipe with "Bake for 5 minutes"
# - Enter cook mode
# - Test timer controls (play/pause/reset)
# - Verify audio alert on completion

# 5. Restore environment
./manageEnvironments.sh  # Option 1: Local Development
```

## 🚨 Critical Safety Rules

### NEVER:
- Skip Safe Testing environment for new features
- Deploy to production without staging testing
- Work directly in production environment
- Ignore environment status indicators

### ALWAYS:
- Check current environment: `./manageEnvironments.sh` → Option 5
- Use Safe Testing first for all feature development
- Create backups before major changes
- Verify environment before starting work

## 📁 Key Project Structure

```
RecipeRaiders/
├── manageEnvironments.sh          # Environment management tool
├── src/
│   ├── components/ui/timer.tsx    # Timer component
│   ├── app/recipes/[id]/cook/     # Cook mode with timer
│   └── lib/time-parser.ts         # Time parsing logic
├── environments/                  # Environment configurations
├── timer-automation-test.sh       # Timer testing script
└── .kiro/docs/                   # Documentation
```

## 🔍 Environment Detection

**Current Environment Indicators**:
- `demo-project` = ✅ Safe Testing (use this!)
- `studio-8456264137-c5384` = ⚠️ Local Development
- `reciperaiders-test` = ⚠️ Staging
- `reciperaiders-prod` = 🚨 Production

## 📋 Quick Reference Commands

```bash
# Check current environment
./manageEnvironments.sh  # Option 5

# Switch to Safe Testing (for feature development)
./manageEnvironments.sh  # Option 2

# Start development server
npm run dev

# Run timer tests
./test./tests/timer-automation-test.sh

# Switch back to Local Development
./manageEnvironments.sh  # Option 1
```

## 🎯 When to Use Each Environment

### Safe Testing (✅ Primary for Development)
- New feature development
- UI/UX changes
- Component testing
- Timer functionality
- Frontend-only features
- Any experimental work

### Local Development (⚠️ When needed)
- Testing with real Firebase APIs
- Authentication flow testing
- Database operation testing

### Staging (⚠️ Pre-production only)
- Full integration testing
- Pre-deployment validation
- Testing with staging.reciperaiders.com

### Production (🚨 Deployment only)
- Final deployment to app.reciperaiders.com
- Hotfixes (with extreme caution)
- Production debugging (emergency only)

## 📚 Documentation References

- **Environment Management**: `.kiro/docs/ENVIRONMENT_MANAGEMENT.md`
- **Testing Strategy**: `.kiro/docs/TESTING_STRATEGY.md`
- **Safe Testing Guide**: `environments/local/SAFE_TESTING_README.md`

## 🤖 AI Assistant Guidelines

When helping with Recipe Raiders development:

1. **Always recommend Safe Testing environment first**
2. **Guide users through proper environment switching**
3. **Emphasize safety protocols**
4. **Provide complete testing workflows**
5. **Check environment status before suggesting actions**
6. **Never recommend production environment for development/testing**

Remember: The Safe Testing environment is designed to be completely risk-free for all feature development and testing.
