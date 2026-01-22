# Repository Cleanup Detailed Guide

## Interactive Approval Process

**ALWAYS get user approval before making changes:**

1. **Analysis Phase** (Read-only):
   - Install tree if needed
   - Create/update root-requirements.json
   - Analyze all root files
   - Generate cleanup plan
   - Show before/after structure preview

2. **Present Plan to User**:
   ```
   CLEANUP PLAN SUMMARY:
   
   FILES TO KEEP IN ROOT (Framework Requirements):
   - [list files that must stay]
   
   FILES TO ORGANIZE:
   - tests/ folder: [list test files to move]
   - assets/ folder: [list image/media files to move]
   - config/ folder: [list config files to move]
   - temp/ folder: [list temporary files to move]
   - backups/ folder: [list backup files to move]
   
   REFERENCES TO UPDATE:
   - package.json scripts: [list changes needed]
   - Documentation: [list files with references to update]
   - Shell scripts: [list scripts with path updates needed]
   
   PROCEED WITH CLEANUP? (y/n)
   ```

## File Categories to Organize

**Test Files** → `tests/`:
- timer-automation-test.sh, timer-automation-test.js, timer-test-puppeteer.js
- test-url-import.sh, test-url-import.mjs, test-{{RESOURCE_NAME}}-sharing.sh
- All *.test.*, *.spec.* files

**Scripts** → `scripts/` (if not already there):
- setup-vercel-browser.sh, vercelMCPsetup.sh, manageEnvironments.sh
- agent-browser-example.sh, startTestAgent.sh, install-stripe.sh
- setup-debug.sh

**Assets** → `assets/`:
- All *.png files (screenshots, examples)
- Audio files from ./audio/
- Any media or image assets

## Critical Safety Rules

1. **NEVER move files required in root** (see root-requirements.json)
2. **Always check root-requirements.json** before moving any file
3. **Update root-requirements.json** when new framework files are discovered
4. **Always preserve symlinks** (check with `ls -la`)
5. **Keep core files in root**: package.json, tsconfig.json, next.config.ts, .gitignore
6. **Preserve AI tool directories**: .kiro/, .codex/, .windsurf/, etc.
7. **Test npm scripts after any package.json changes**
8. **Validate symlinks still work**: firestore.rules, storage.rules, etc.

## Root Requirements File Structure

```json
{
  "required_in_root": {
    "next_js": ["next.config.ts", "next-env.d.ts"],
    "firebase": ["firebase.json", ".firebaserc", "apphosting.yaml", "firestore.rules", "storage.rules", "firestore.indexes.json"],
    "node_js": ["package.json", "package-lock.json"],
    "typescript": ["tsconfig.json", "tsconfig.scripts.json"],
    "build_tools": ["tailwind.config.ts", "postcss.config.mjs", "components.json"],
    "git": [".gitignore"],
    "environment": [".env.local"],
    "documentation": ["README.md"]
  }
}
```
