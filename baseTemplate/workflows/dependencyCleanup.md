# Dependency Cleanup Workflow

## Platform Migration Cleanup Process
1. **Identify Platform Dependencies**
   - Search for platform-specific imports/configs
   - Check package.json for platform packages
   - Scan environment variables

2. **Systematic Removal**
   - Remove unused imports
   - Clean configuration files
   - Update environment templates
   - Remove platform-specific scripts

3. **Validation Steps**
   - Test application startup
   - Verify core functionality
   - Check for broken references
   - Validate build process

## Common Platform Patterns
- Replit: `@replit/`, `.replit`, `replit.nix`
- Vercel: `vercel.json`, `@vercel/`
- Netlify: `netlify.toml`, `@netlify/`

Use this workflow for clean platform transitions.