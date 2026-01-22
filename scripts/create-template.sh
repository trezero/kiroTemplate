#!/bin/bash

# Template Creation Script
# Creates new template variants from base template

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

print_status() { echo -e "\033[0;34m[INFO]\033[0m $1"; }
print_success() { echo -e "\033[0;32m[SUCCESS]\033[0m $1"; }
print_error() { echo -e "\033[0;31m[ERROR]\033[0m $1"; }
print_warning() { echo -e "\033[0;33m[WARNING]\033[0m $1"; }

usage() {
    echo "Usage: $0 <template-name> [base-template]"
    echo ""
    echo "Template types:"
    echo "  api-service    - REST API backend service"
    echo "  mobile-app     - React Native/Flutter mobile app"
    echo "  desktop-app    - Electron/Tauri desktop application"
    echo "  data-pipeline  - ETL/data processing pipeline"
    echo "  library        - Reusable library/package"
    echo ""
    echo "Base templates:"
    echo "  baseTemplate   - Full-featured template (default)"
    echo "  minimal        - Minimal template with core agents only"
    echo ""
    echo "Examples:"
    echo "  $0 api-service"
    echo "  $0 mobile-app baseTemplate"
    exit 1
}

if [ $# -lt 1 ]; then
    usage
fi

TEMPLATE_NAME="$1"
BASE_TEMPLATE="${2:-baseTemplate}"
TEMPLATE_DIR="$REPO_ROOT/templates/$TEMPLATE_NAME"

if [ -d "$TEMPLATE_DIR" ]; then
    print_error "Template '$TEMPLATE_NAME' already exists at $TEMPLATE_DIR"
    exit 1
fi

if [ ! -d "$REPO_ROOT/$BASE_TEMPLATE" ]; then
    print_error "Base template '$BASE_TEMPLATE' not found at $REPO_ROOT/$BASE_TEMPLATE"
    exit 1
fi

print_status "Creating template '$TEMPLATE_NAME' from '$BASE_TEMPLATE'..."

# Copy base template
cp -r "$REPO_ROOT/$BASE_TEMPLATE" "$TEMPLATE_DIR"

# Create template-specific customizations
case "$TEMPLATE_NAME" in
    "api-service")
        print_status "Configuring API service template..."
        
        # Remove frontend-specific agents
        rm -f "$TEMPLATE_DIR/agents/frontend.json"
        rm -f "$TEMPLATE_DIR/agents/vercel-browser.json"
        
        # Create API-specific agent customizations
        cat > "$TEMPLATE_DIR/agent-customizations.md" << 'EOF'
# API Service Template Customizations

## Agent Transformations

### resource-management.json → endpoint-management.json
```json
{
  "name": "endpoint-management",
  "description": "API endpoint CRUD operations and route management specialist",
  "prompt": "You are an API endpoint management specialist for {{PROJECT_NAME}}. Handle REST API endpoint creation, route management, request/response validation, middleware integration, and API documentation. Focus on {{BACKEND_FRAMEWORK}} best practices, {{DATABASE}} operations, error handling, and API security. Ensure proper HTTP status codes, request validation, and comprehensive API documentation.",
  "resources": [
    "file://{{BACKEND_DIR}}/routes/**/*.{{FILE_EXT}}",
    "file://{{BACKEND_DIR}}/controllers/**/*.{{FILE_EXT}}",
    "file://{{BACKEND_DIR}}/middleware/**/*.{{FILE_EXT}}",
    "file://{{BACKEND_DIR}}/models/**/*.{{FILE_EXT}}"
  ]
}
```

### user-workflow.json → request-workflow.json
```json
{
  "name": "request-workflow",
  "description": "API request/response workflow and data flow specialist",
  "prompt": "You are a request workflow specialist for {{PROJECT_NAME}}. Handle API request processing, response formatting, data validation, error handling, and workflow optimization. Focus on {{BACKEND_FRAMEWORK}} middleware, request parsing, response serialization, and API performance. Ensure proper error responses, data validation, and efficient request processing.",
  "resources": [
    "file://{{BACKEND_DIR}}/middleware/**/*.{{FILE_EXT}}",
    "file://{{BACKEND_DIR}}/utils/**/*.{{FILE_EXT}}",
    "file://{{BACKEND_DIR}}/validators/**/*.{{FILE_EXT}}"
  ]
}
```
EOF
        ;;
        
    "mobile-app")
        print_status "Configuring mobile app template..."
        
        # Remove web-specific agents
        rm -f "$TEMPLATE_DIR/agents/vercel-browser.json"
        
        cat > "$TEMPLATE_DIR/agent-customizations.md" << 'EOF'
# Mobile App Template Customizations

## Agent Transformations

### resource-management.json → screen-management.json
```json
{
  "name": "screen-management",
  "description": "Mobile screen and component management specialist",
  "prompt": "You are a mobile screen management specialist for {{PROJECT_NAME}}. Handle mobile screen creation, navigation flows, component management, state management, and responsive design. Focus on {{TECH_STACK}} best practices, mobile UI patterns, accessibility, and performance optimization. Ensure proper navigation, state persistence, and mobile-optimized user experiences.",
  "resources": [
    "file://{{FRONTEND_DIR}}/screens/**/*.{{FILE_EXT}}",
    "file://{{FRONTEND_DIR}}/components/**/*.{{FILE_EXT}}",
    "file://{{FRONTEND_DIR}}/navigation/**/*.{{FILE_EXT}}"
  ]
}
```

### user-workflow.json → navigation-workflow.json
```json
{
  "name": "navigation-workflow",
  "description": "Mobile navigation and user flow specialist",
  "prompt": "You are a mobile navigation specialist for {{PROJECT_NAME}}. Handle navigation flows, screen transitions, deep linking, tab navigation, and user journey optimization. Focus on {{TECH_STACK}} navigation patterns, mobile UX best practices, and performance. Ensure smooth transitions, proper back button handling, and intuitive navigation patterns.",
  "resources": [
    "file://{{FRONTEND_DIR}}/navigation/**/*.{{FILE_EXT}}",
    "file://{{FRONTEND_DIR}}/screens/**/*.{{FILE_EXT}}"
  ]
}
```
EOF
        ;;
        
    "desktop-app")
        print_status "Configuring desktop app template..."
        
        cat > "$TEMPLATE_DIR/agent-customizations.md" << 'EOF'
# Desktop App Template Customizations

## Agent Transformations

### resource-management.json → window-management.json
```json
{
  "name": "window-management", 
  "description": "Desktop window and application state management specialist",
  "prompt": "You are a desktop application specialist for {{PROJECT_NAME}}. Handle window management, application state, menu systems, file operations, and native integrations. Focus on {{TECH_STACK}} desktop patterns, system integration, and performance. Ensure proper window lifecycle, native feel, and desktop-specific features.",
  "resources": [
    "file://{{FRONTEND_DIR}}/windows/**/*.{{FILE_EXT}}",
    "file://{{FRONTEND_DIR}}/main/**/*.{{FILE_EXT}}",
    "file://{{FRONTEND_DIR}}/native/**/*.{{FILE_EXT}}"
  ]
}
```
EOF
        ;;
        
    "data-pipeline")
        print_status "Configuring data pipeline template..."
        
        # Remove frontend agents
        rm -f "$TEMPLATE_DIR/agents/frontend.json"
        rm -f "$TEMPLATE_DIR/agents/vercel-browser.json"
        
        cat > "$TEMPLATE_DIR/agent-customizations.md" << 'EOF'
# Data Pipeline Template Customizations

## Agent Transformations

### resource-management.json → data-processing.json
```json
{
  "name": "data-processing",
  "description": "Data processing and ETL pipeline specialist", 
  "prompt": "You are a data processing specialist for {{PROJECT_NAME}}. Handle ETL pipelines, data transformation, batch processing, stream processing, and data validation. Focus on {{TECH_STACK}} data processing patterns, {{DATABASE}} operations, error handling, and monitoring. Ensure data quality, processing efficiency, and proper error recovery.",
  "resources": [
    "file://{{BACKEND_DIR}}/pipelines/**/*.{{FILE_EXT}}",
    "file://{{BACKEND_DIR}}/processors/**/*.{{FILE_EXT}}",
    "file://{{BACKEND_DIR}}/validators/**/*.{{FILE_EXT}}"
  ]
}
```

### user-workflow.json → pipeline-workflow.json
```json
{
  "name": "pipeline-workflow",
  "description": "Data pipeline orchestration and workflow specialist",
  "prompt": "You are a pipeline workflow specialist for {{PROJECT_NAME}}. Handle pipeline orchestration, job scheduling, dependency management, monitoring, and error recovery. Focus on {{TECH_STACK}} workflow patterns, data lineage, and operational excellence. Ensure reliable pipeline execution, proper monitoring, and efficient resource utilization.",
  "resources": [
    "file://{{BACKEND_DIR}}/workflows/**/*.{{FILE_EXT}}",
    "file://{{BACKEND_DIR}}/schedulers/**/*.{{FILE_EXT}}",
    "file://config/**/*.{{FILE_EXT}}"
  ]
}
```
EOF
        ;;
        
    "library")
        print_status "Configuring library template..."
        
        # Remove app-specific agents
        rm -f "$TEMPLATE_DIR/agents/vercel-browser.json"
        rm -f "$TEMPLATE_DIR/agents/calendar-integration.json"
        rm -f "$TEMPLATE_DIR/agents/auth-troubleshoot.json"
        
        cat > "$TEMPLATE_DIR/agent-customizations.md" << 'EOF'
# Library Template Customizations

## Agent Transformations

### resource-management.json → api-management.json
```json
{
  "name": "api-management",
  "description": "Library API design and interface management specialist",
  "prompt": "You are a library API specialist for {{PROJECT_NAME}}. Handle public API design, interface definitions, documentation generation, versioning, and backward compatibility. Focus on {{TECH_STACK}} best practices, clean interfaces, comprehensive documentation, and developer experience. Ensure consistent API design, proper error handling, and excellent documentation.",
  "resources": [
    "file://{{FRONTEND_DIR}}/index.{{FILE_EXT}}",
    "file://{{FRONTEND_DIR}}/lib/**/*.{{FILE_EXT}}",
    "file://docs/**/*.md"
  ]
}
```
EOF
        ;;
        
    *)
        print_warning "Unknown template type '$TEMPLATE_NAME'. Creating generic template."
        ;;
esac

# Update template metadata
cat > "$TEMPLATE_DIR/template-info.json" << EOF
{
  "name": "$TEMPLATE_NAME",
  "description": "Kiro CLI template for $TEMPLATE_NAME projects",
  "type": "$TEMPLATE_NAME",
  "baseTemplate": "$BASE_TEMPLATE",
  "created": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "version": "1.0.0"
}
EOF

print_success "Template '$TEMPLATE_NAME' created successfully at $TEMPLATE_DIR"
print_status "Next steps:"
echo "  1. Review and customize agents in $TEMPLATE_DIR/agents/"
echo "  2. Update steering documents in $TEMPLATE_DIR/steering/"
echo "  3. Test the template: cd test-project && $TEMPLATE_DIR/install-kiro-template.sh"
