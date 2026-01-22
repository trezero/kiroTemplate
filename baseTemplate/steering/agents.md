# Specialized Development Agents

## Overview

Continuum includes 13 specialized Kiro CLI agents designed for different aspects of development. Each agent has focused expertise, curated resources, and specific tool permissions to maximize productivity in their domain.

**Automatic Delegation:** The default agent can automatically delegate tasks to specialized agents using the `use_subagent` tool based on task requirements and domain expertise.

## Available Agents

### 1. Frontend Development Agent (`frontend-dev`)
**Purpose:** React/TypeScript UI development specialist
**Auto-Delegate When:** 
- Modifying React components or pages
- Working with UI/UX, styling, or shadcn/ui components
- Implementing frontend state management or React Query
- Tasks mentioning: "component", "UI", "frontend", "React", "styling", "Tailwind"

**Key Resources:**
- All steering documentation
- Client-side TypeScript files
- Shared schema definitions
- Tailwind configuration

**Example Usage:**
```bash
kiro-cli --agent frontend-dev
> Add a loading state to the task cards in Kanban view
```

### 2. API Development Agent (`api-dev`)
**Purpose:** Backend Express.js and PostgreSQL specialist
**Auto-Delegate When:**
- Creating or modifying API endpoints
- Working with server-side logic or database queries
- Implementing validation or authentication
- Tasks mentioning: "API", "endpoint", "backend", "server", "route", "validation"

**Key Resources:**
- Server-side TypeScript files
- Database schema definitions
- All steering documentation

**Example Usage:**
```bash
kiro-cli --agent api-dev
> Add a new endpoint to bulk update task priorities
```

### 3. Database Schema Agent (`db-schema`)
**Purpose:** PostgreSQL schema and migration specialist
**Auto-Delegate When:**
- Modifying database schema or tables
- Creating migrations or database changes
- Working with Drizzle ORM schema
- Tasks mentioning: "database", "schema", "migration", "table", "SQL", "Drizzle"

**Key Resources:**
- Schema definitions
- Storage layer implementation
- Drizzle configuration

**Example Usage:**
```bash
kiro-cli --agent db-schema
> Add a new field to track task creation source
```

### 4. Focus System Agent (`focus-system`)
**Purpose:** Focus session and drift detection specialist
**Auto-Delegate When:**
- Working on focus sessions, timing, or drift detection
- Modifying the "Now" screen or focus-related features
- Implementing intervention strategies
- Tasks mentioning: "focus", "session", "drift", "timer", "intervention", "now screen"

**Key Resources:**
- Focus session components
- Server-side focus logic
- Schema definitions

**Example Usage:**
```bash
kiro-cli --agent focus-system
> Implement a "deep focus" mode with longer sessions
```

### 5. Calendar Integration Agent (`calendar-integration`)
**Purpose:** Multi-provider calendar OAuth and sync specialist
**Auto-Delegate When:**
- Working with calendar APIs (Google/Microsoft)
- Managing OAuth flows or token handling
- Implementing meeting or event features
- Debugging timezone or event synchronization issues
- Tasks mentioning: "calendar", "OAuth", "Google", "Microsoft", "meeting", "event", "sync", "timezone"

**Key Resources:**
- Calendar OAuth implementations (Google + Microsoft)
- Calendar integration documentation
- Common pitfalls guide
- Meeting management components
- Postman testing collections

**Special Capabilities:**
- Generates Postman collections for calendar APIs
- Creates OAuth flow tests
- Debugs timezone conversion issues
- Validates event metadata and grouping
- Handles multi-account scenarios

**Example Usage:**
```bash
kiro-cli --agent calendar-integration
> Add support for recurring meeting detection
> Debug why events from Iva Kalova aren't showing
> Generate Postman collection for testing calendar sync
```

### 6. Task Management Agent (`task-management`)
**Purpose:** Task system and Kanban view specialist
**Auto-Delegate When:**
- Working on task-related features
- Modifying List or Kanban views
- Implementing task status, priority, or organization
- Tasks mentioning: "task", "kanban", "priority", "status", "blocked", "todo"

**Key Resources:**
- Task management components
- Task-related API endpoints
- Schema definitions

**Example Usage:**
```bash
kiro-cli --agent task-management
> Add drag-and-drop functionality to Kanban columns
```

### 7. AI Integration Agent (`ai-integration`)
**Purpose:** AI evaluation pipeline and conversation specialist
**Auto-Delegate When:**
- Working with AI features, Gemini, or Ollama
- Implementing conversation or chat features
- Working on entity extraction or AI evaluation
- Tasks mentioning: "AI", "Gemini", "Ollama", "conversation", "chat", "evaluation", "RAG"

**Key Resources:**
- AI service implementations
- Conversation components
- All steering documentation

**Example Usage:**
```bash
kiro-cli --agent ai-integration
> Improve task priority prediction accuracy
```

### 8. API Testing Agent (`api-testing`) ⭐ NEW
**Purpose:** Postman collection and API test generation specialist
**Auto-Delegate When:**
- Creating or updating API tests
- Generating Postman collections
- Testing API endpoints
- Validating request/response schemas
- Tasks mentioning: "API test", "Postman", "endpoint test", "integration test", "API validation"

**Key Resources:**
- API route definitions
- Existing test files
- Postman collections
- Testing documentation

**Special Capabilities:**
- Auto-generates Postman collections from route definitions
- Creates Jest/Vitest test files for endpoints
- Identifies missing test coverage
- Generates environment files for Postman
- Creates test scripts with response validation

**Example Usage:**
```bash
kiro-cli --agent api-testing
> Generate Postman collection for all task management endpoints
> Create integration tests for calendar API
> Identify endpoints missing test coverage
```

### 9. Testing Specialist Agent (`testing-specialist`)
**Purpose:** Testing strategy and implementation specialist
**Auto-Delegate When:**
- Writing or modifying tests
- Setting up testing infrastructure
- Debugging test failures or coverage issues
- Tasks mentioning: "test", "testing", "Jest", "coverage", "debug", "spec"

**Key Resources:**
- All source code files
- Steering documentation

**Example Usage:**
```bash
kiro-cli --agent testing-specialist
> Add comprehensive tests for the focus session state machine
```

### 10. Documentation Specialist Agent (`docs-specialist`)
**Purpose:** Technical documentation and API reference specialist
**Auto-Delegate When:**
- Updating documentation or README files
- Writing guides or API documentation
- Maintaining steering docs
- Tasks mentioning: "documentation", "docs", "README", "guide", "API docs", "steering"

**Key Resources:**
- All documentation files
- Steering documentation
- README files

**Example Usage:**
```bash
kiro-cli --agent docs-specialist
> Update the API documentation with the new bulk operations
```

### 11. Deployment Specialist Agent (`deployment-specialist`)
**Purpose:** Production deployment and DevOps specialist
**Auto-Delegate When:**
- Working on deployment or infrastructure
- Configuring Docker, AWS, or cloud services
- Managing environment variables or CI/CD
- Tasks mentioning: "deploy", "deployment", "Docker", "AWS", "cloud", "environment", "CI/CD"

**Key Resources:**
- Docker configuration
- Package configuration
- Steering documentation

**Example Usage:**
```bash
kiro-cli --agent deployment-specialist
> Set up a staging environment on Railway
```

### 11. CRUD Pattern Agent (`crud-pattern`) ⭐ NEW
**Purpose:** Complete CRUD operation generation based on proven patterns
**Auto-Delegate When:**
- Creating new features requiring full CRUD operations
- Implementing database entities with UI components
- Building forms with validation and authentication
- Tasks mentioning: "CRUD", "new feature", "entity", "form", "database model", "full implementation"

**Key Resources:**
- Contexts implementation as reference pattern
- Form validation patterns documentation
- Database schema patterns
- Authentication middleware patterns

**Special Capabilities:**
- Generates complete database migrations
- Creates API routes with proper validation
- Builds React forms with null/none handling
- Implements color-coded UI components
- Adds authentication and filtering

**Example Usage:**
```bash
kiro-cli --agent crud-pattern
> Create a new "Projects" feature with full CRUD operations
> Implement a "Categories" system similar to Contexts
```

### 12. Confucius-Architect Agent (`confucius-architect`)
**Purpose:** Large-scale software engineering with hierarchical memory management
**Auto-Delegate When:**
- Complex architectural refactoring across multiple files/modules
- Large codebase analysis requiring systematic exploration
- Multi-step engineering tasks needing decision traceability
- Memory-intensive operations requiring context consolidation
- Tasks mentioning: "architecture", "refactor", "large-scale", "systematic", "complex", "multi-step"

**Key Resources:**
- Confucius AX standards documentation
- Architecture documentation
- Hindsight notes for learning continuity

**Example Usage:**
```bash
kiro-cli --agent confucius-architect
> Refactor the entire AI evaluation pipeline for better modularity
```

## Automatic Agent Delegation

### How It Works
The default agent analyzes task requirements and automatically delegates to the most appropriate specialist using the `use_subagent` tool. This provides:

- **Seamless Experience:** No need to manually switch agents
- **Expert Knowledge:** Each task handled by the most qualified specialist
- **Parallel Processing:** Multiple agents can work simultaneously on different aspects

### Delegation Criteria
Tasks are automatically delegated based on:

1. **Keywords:** Specific terms that indicate domain expertise needed
2. **File Paths:** Files being modified (e.g., `client/src/` → frontend-dev)
3. **Task Type:** Nature of the work (API, UI, database, etc.)
4. **Context:** Overall scope and requirements of the task

### Example Automatic Delegations
```bash
# User request: "Add a new task status field to the database"
# → Automatically delegates to db-schema agent

# User request: "Fix the Kanban view loading state"
# → Automatically delegates to frontend-dev agent

# User request: "Create an endpoint for task bulk operations"
# → Automatically delegates to api-dev agent

# User request: "Add tests for the focus session timer"
# → Automatically delegates to testing-specialist agent
```

## Agent Selection Guidelines

### By Development Phase
- **Planning/Architecture:** Use `docs-specialist` or default agent
- **Database Changes:** Use `db-schema` agent
- **API Development:** Use `api-dev` agent
- **Frontend Development:** Use `frontend-dev` agent
- **Testing:** Use `testing-specialist` agent
- **Deployment:** Use `deployment-specialist` agent

### By Feature Area
- **Focus Sessions:** Use `focus-system` agent
- **Task Management:** Use `task-management` agent
- **Calendar Integration:** Use `calendar-integration` agent
- **AI Features:** Use `ai-integration` agent

### By Problem Type
- **UI/UX Issues:** Use `frontend-dev` agent
- **API Bugs:** Use `api-dev` agent
- **Database Performance:** Use `db-schema` agent
- **Integration Issues:** Use appropriate specialist agent
- **Documentation Updates:** Use `docs-specialist` agent

## Best Practices

### Agent Switching
```bash
# Switch to specific agent
kiro-cli --agent frontend-dev

# Or use agent swap command
/agent swap api-dev
```

### Multi-Agent Workflows
For complex features spanning multiple domains:
1. Start with `docs-specialist` for planning
2. Use `db-schema` for database changes
3. Use `api-dev` for backend implementation
4. Use `frontend-dev` for UI implementation
5. Use `testing-specialist` for comprehensive testing

### Resource Optimization
Each agent has curated resources to:
- Reduce context window usage
- Focus on relevant code areas
- Maintain domain expertise
- Speed up development cycles

## Agent Maintenance

### Updating Agents
When project structure changes:
1. Update agent resource paths
2. Modify prompts for new patterns
3. Adjust tool permissions as needed
4. Update this documentation

### Adding New Agents
For new domains or specialized needs:
1. Identify specific expertise area
2. Curate relevant resources
3. Define focused prompt
4. Set appropriate tool permissions
5. Document usage guidelines

## Integration with Steering Docs

All agents have access to steering documentation to ensure:
- Consistent architectural understanding
- Awareness of project goals and constraints
- Knowledge of existing patterns and conventions
- Alignment with ADHD-friendly design principles

This agent system provides specialized expertise while maintaining project coherence through shared steering documentation and focused resource access.
