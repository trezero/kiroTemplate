# Recipe Raiders Environment Management & Testing Guide

## 🎯 Environment Overview

Recipe Raiders uses a sophisticated environment management system with 4 distinct environments:

### 1. **Safe Testing Environment** (Recommended for Feature Testing)
- **Purpose**: Isolated testing of new features (timers, UI, components)
- **Firebase Project**: `demo-project` (completely fake)
- **Risk Level**: ✅ **ZERO RISK** - Cannot affect any real systems
- **Use Cases**: Timer testing, UI changes, component development

### 2. **Local Development Environment**
- **Purpose**: Standard local development with real Firebase project
- **Firebase Project**: `studio-8456264137-c5384` (real project)
- **Risk Level**: ⚠️ **LOW RISK** - Connected to real Firebase but isolated data

### 3. **Staging Environment**
- **Purpose**: Pre-production testing with staging.reciperaiders.com
- **Firebase Project**: `reciperaiders-test`
- **Risk Level**: ⚠️ **MEDIUM RISK** - Affects staging environment

### 4. **Production Environment**
- **Purpose**: Live production deployment to app.reciperaiders.com
- **Firebase Project**: `reciperaiders-prod`
- **Risk Level**: 🚨 **HIGH RISK** - Affects live users

## 🛠️ Environment Management Tool

**Location**: `/RecipeRaiders/manageEnvironments.sh`

**Usage**:
```bash
cd /path/to/RecipeRaiders
./manageEnvironments.sh
```

**Menu Options**:
1. Local Development
2. **Safe Testing (Isolated)** ← Use this for feature testing
3. Staging (Test)
4. Production (LIVE)
5. Show Current Status
6. List Backups
7. Exit

## 🧪 Testing Workflow for New Features

### Step 1: Switch to Safe Testing
```bash
./manageEnvironments.sh
# Select option 2: Safe Testing (Isolated)
```

### Step 2: Start Development Server
```bash
npm run dev
```

### Step 3: Run Automated Tests (if available)
```bash
# For timer functionality:
./tests/timer-automation-test.sh

# For other features, check for test scripts:
ls -la *test*.sh
ls -la *test*.js
```

### Step 4: Manual Browser Testing
- Open `http://localhost:9002`
- Test the specific feature
- Verify functionality works as expected

### Step 5: Switch Back When Done
```bash
./manageEnvironments.sh
# Select option 1: Local Development
```

## 🔍 Current Environment Detection

**Check current environment**:
```bash
./manageEnvironments.sh
# Select option 5: Show Current Status
```

**Environment Indicators**:
- `demo-project` = Safe Testing (✅ Safe)
- `studio-8456264137-c5384` = Local Development (⚠️ Real Firebase)
- `reciperaiders-test` = Staging (⚠️ Affects staging.reciperaiders.com)
- `reciperaiders-prod` = Production (🚨 Affects app.reciperaiders.com)

## 🎯 Feature Testing Examples

### Timer Functionality Testing
```bash
# 1. Switch to safe testing
./manageEnvironments.sh  # Option 2

# 2. Start server
npm run dev

# 3. Run timer tests
./tests/timer-automation-test.sh

# 4. Manual testing:
# - Create recipe with "Bake for 5 minutes"
# - Enter cook mode
# - Test timer controls (play/pause/reset)
# - Verify audio alert on completion

# 5. Switch back
./manageEnvironments.sh  # Option 1
```

### UI Component Testing
```bash
# 1. Safe testing mode
./manageEnvironments.sh  # Option 2

# 2. Test component changes
npm run dev
# Test in browser at localhost:9002

# 3. Restore when done
./manageEnvironments.sh  # Option 1
```

## 🛡️ Safety Guidelines

### ✅ ALWAYS Use Safe Testing For:
- New feature development
- UI/UX changes
- Component testing
- Timer functionality
- Layout modifications
- Styling updates
- Frontend-only features

### ⚠️ Use Staging Only When:
- Testing full authentication flows
- Testing database operations
- Testing API integrations
- Pre-production validation

### 🚨 Use Production Only For:
- Final deployments
- Hotfixes to live system
- Production debugging (with extreme caution)

## 📁 File Structure

```
RecipeRaiders/
├── manageEnvironments.sh          # Main environment tool
├── environments/
│   ├── local/
│   │   ├── .env.local             # Local development config
│   │   ├── .env.safe-testing      # Safe testing config
│   │   ├── .firebaserc.safe-testing
│   │   ├── firebase.json.safe-testing
│   │   └── SAFE_TESTING_README.md
│   ├── test/                      # Staging environment
│   ├── prod/                      # Production environment
│   └── backups/                   # Automatic backups
├── timer-automation-test.sh       # Timer testing script
└── timer-test-puppeteer.js       # Browser automation tests
```

## 🔄 Backup & Recovery

**Automatic Backups**: Every environment switch creates a timestamped backup in `environments/backups/`

**Manual Backup**:
```bash
cp .env.local .env.local.backup
cp .firebaserc .firebaserc.backup
cp firebase.json firebase.json.backup
```

**Recovery**: Use `manageEnvironments.sh` to switch back to desired environment

## 🚨 Emergency Procedures

**If you accidentally switch to production**:
1. Immediately run `./manageEnvironments.sh`
2. Select option 2 (Safe Testing) or 1 (Local Development)
3. Verify environment with option 5 (Show Current Status)
4. Never deploy while in production mode unless intentional

**If environment is corrupted**:
1. Check `environments/backups/` for recent backup
2. Manually restore from backup
3. Or use `manageEnvironments.sh` to switch to known good environment

## 📝 Best Practices

1. **Always check current environment** before starting work
2. **Use Safe Testing for all feature development**
3. **Create backups before major changes**
4. **Test locally before staging**
5. **Test in staging before production**
6. **Never skip the Safe Testing step**

This system ensures safe development while maintaining access to full environments when needed.
