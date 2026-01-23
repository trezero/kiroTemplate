# {{PROJECT_NAME}} Environment Management & Testing Guide

## Environment Overview

{{PROJECT_NAME}} uses a multi-environment setup for safe development and deployment:

### 🧪 Development Environment
- **Purpose**: Local development and testing
- **Environment ID**: `{{DEV_ENV}}`
- **Risk Level**: ✅ **SAFE** - Isolated development environment
- **Usage**: Daily development, feature testing, experimentation

### 🔄 Staging Environment  
- **Purpose**: Pre-production testing and validation
- **Environment ID**: `{{STAGING_ENV}}`
- **Risk Level**: ⚠️ **LOW RISK** - Staging environment for final testing
- **Usage**: Integration testing, stakeholder reviews, deployment validation

### 🚀 Production Environment
- **Purpose**: Live application serving real users
- **Environment ID**: `{{PROD_ENV}}`
- **Risk Level**: 🚨 **HIGH RISK** - Live production system
- **Usage**: Live application, real user data

## Environment Configuration

### Development Setup
```bash
# Environment variables for development
NODE_ENV=development
DATABASE_URL={{DEV_ENV}}_database_url
API_BASE_URL=http://localhost:3000
AUTH_PROJECT_ID={{DEV_ENV}}
```

### Staging Setup
```bash
# Environment variables for staging
NODE_ENV=staging
DATABASE_URL={{STAGING_ENV}}_database_url
API_BASE_URL=https://staging.{{PROJECT_NAME}}.com
AUTH_PROJECT_ID={{STAGING_ENV}}
```

### Production Setup
```bash
# Environment variables for production
NODE_ENV=production
DATABASE_URL={{PROD_ENV}}_database_url
API_BASE_URL=https://{{PROJECT_NAME}}.com
AUTH_PROJECT_ID={{PROD_ENV}}
```

## Safety Protocols

### ✅ Safe Development Practices
1. **Always use {{DEV_ENV}} for development**
2. **Test new features in development first**
3. **Use staging for integration testing**
4. **Never test directly in production**

### 🚨 Production Safety
- **Double-check environment before deployment**
- **Use staging for final validation**
- **Monitor production deployments**
- **Have rollback plan ready**

## Environment Switching

### Using Environment Scripts
```bash
# Switch to development
./scripts/set-env.sh dev

# Switch to staging  
./scripts/set-env.sh staging

# Switch to production (use with caution)
./scripts/set-env.sh prod
```

### Manual Environment Setup
```bash
# Copy appropriate .env file
cp .env.development .env.local
# or
cp .env.staging .env.local
# or  
cp .env.production .env.local
```

## Testing Strategy

### Development Testing
- **Environment**: {{DEV_ENV}}
- **Data**: Test data, safe to modify
- **Purpose**: Feature development, bug fixes
- **Risk**: None - isolated environment

### Staging Testing
- **Environment**: {{STAGING_ENV}}
- **Data**: Production-like test data
- **Purpose**: Integration testing, final validation
- **Risk**: Low - separate from production

### Production Monitoring
- **Environment**: {{PROD_ENV}}
- **Data**: Real user data
- **Purpose**: Live application
- **Risk**: High - affects real users

## Deployment Pipeline

1. **Development** → Test locally with {{DEV_ENV}}
2. **Staging** → Deploy to {{STAGING_ENV}} for validation
3. **Production** → Deploy to {{PROD_ENV}} after staging approval

## Troubleshooting

### Environment Issues
1. **Wrong Environment**: Check environment variables
2. **Database Connection**: Verify database URLs
3. **Authentication**: Confirm auth project IDs
4. **API Endpoints**: Validate base URLs

### Quick Environment Check
```bash
echo "Current environment: $NODE_ENV"
echo "Database: $DATABASE_URL"
echo "Auth Project: $AUTH_PROJECT_ID"
```
