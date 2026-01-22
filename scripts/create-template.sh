#!/bin/bash

# Create Template Script
# Usage: ./scripts/create-template.sh <template-name> [base-template]

TEMPLATE_NAME="$1"
BASE_TEMPLATE="${2:-baseTemplate}"

if [ -z "$TEMPLATE_NAME" ]; then
    echo "Usage: $0 <template-name> [base-template]"
    echo "Example: $0 web-app baseTemplate"
    exit 1
fi

TEMPLATE_DIR="templates/$TEMPLATE_NAME"

if [ -d "$TEMPLATE_DIR" ]; then
    echo "Template '$TEMPLATE_NAME' already exists"
    exit 1
fi

echo "Creating template '$TEMPLATE_NAME' based on '$BASE_TEMPLATE'..."

# Copy base template
cp -r "$BASE_TEMPLATE" "$TEMPLATE_DIR"

# Create template-specific README
cat > "$TEMPLATE_DIR/README.md" << EOF
# $TEMPLATE_NAME Template

This is a specialized Kiro CLI template for $TEMPLATE_NAME projects.

## Installation

From your project root:
\`\`\`bash
git clone https://github.com/trezero/kiroTemplate.git temp
cd temp
./templates/$TEMPLATE_NAME/install-kiro-template.sh
cd ..
rm -rf temp
\`\`\`

## Customizations

This template includes:
- TODO: Document template-specific features
- TODO: List specialized agents
- TODO: Mention specific MCP servers

EOF

echo "Template created at $TEMPLATE_DIR"
echo "Customize the template files as needed"
