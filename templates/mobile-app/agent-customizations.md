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
