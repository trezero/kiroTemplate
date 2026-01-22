# Template Repository Management

This repository contains multiple Kiro CLI templates for different project types.

## Repository Structure

- `baseTemplate/` - Full-featured template with all capabilities
- `templates/` - Specialized template variants
- `.kiro/` - This repository's own Kiro CLI setup for template management
- `scripts/` - Helper scripts for template creation and management

## Working on Templates

Use the template-manager agent to improve and customize templates:

```bash
kiro-cli --agent template-manager
```

## Creating New Templates

Use the creation script:

```bash
./scripts/create-template.sh <template-name> [base-template]
```

## Testing Templates

Test template installation in a temporary directory:

```bash
mkdir test-install
cd test-install
../baseTemplate/install-kiro-template.sh
# Test functionality
cd ..
rm -rf test-install
```
