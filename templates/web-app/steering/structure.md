# Project Structure

## Directory Layout

### Root Structure
```
continuum/
├── client/                 # React frontend (Vite + TypeScript)
├── server/                 # Express backend (Node.js + TypeScript)
├── shared/                 # Shared types and schemas
├── docs/                   # Documentation
├── _bmad-output/          # Implementation artifacts and planning
├── .kiro/                 # Kiro CLI configuration and steering
└── docker-compose.yml     # Local development services
```

### Client Structure (`client/src/`)
```
client/src/
├── main.tsx               # React bootstrap
├── App.tsx                # App routes + layout wiring
├── components/
│   ├── ui/               # shadcn/ui components
│   ├── app-layout.tsx    # Main shell
│   ├── top-nav.tsx       # Top navigation
│   └── settings-layout.tsx # Settings shell
├── pages/
│   ├── now.tsx           # Focus state screen
│   ├── tasks.tsx         # Task management (List + Kanban views)
│   ├── meetings.tsx      # Meeting management
│   ├── conversation.tsx  # Chat interface
│   ├── settings/         # Settings screens (10 screens)
│   └── auth/            # Authentication flows
├── lib/
│   ├── queryClient.ts    # React Query setup
│   ├── theme-provider.tsx # Theme provider
│   └── auth-context.tsx  # Auth context
└── index.css             # Global styles + Tailwind
```

### Server Structure (`server/`)
```
server/
├── index.ts              # Server entrypoint
├── routes.ts             # API routes registration (57+ endpoints)
├── config.ts             # Environment configuration
├── db.ts                 # Database connection
├── storage.ts            # Database CRUD operations
├── ai-service.ts         # AI provider switching
├── ollama-client.ts      # Local AI client
├── google-oauth.ts       # Google Calendar OAuth integration
├── microsoft-oauth.ts    # Microsoft Graph OAuth integration
├── graph/               # Knowledge graph services
│   ├── graph-service.ts  # Neo4j client wrapper
│   ├── query-templates.ts # Cypher queries
│   └── sync.ts          # PostgreSQL → Neo4j sync
├── vector/              # Vector search services
│   ├── vector-service.ts # Qdrant client wrapper
│   └── embeddings.ts    # Embedding generation
├── ai/                  # AI evaluation services
│   ├── evaluation-service.ts # Entity extraction
│   ├── agentic-rag.ts   # Strategy selection
│   └── consequence-modeling.ts # Graph-powered consequences
└── sync/                # Sync orchestrator
    ├── orchestrator.ts   # Event-driven sync
    └── retry-queue.ts    # Failure handling
```

### Shared Structure (`shared/`)
```
shared/
├── schema.ts             # Drizzle ORM schema (source of truth)
├── models/
│   ├── auth.ts          # Authentication types
│   └── chat.ts          # Chat types
├── focus/               # Focus state machine (planned)
│   ├── types.ts         # Focus session types
│   ├── rules.ts         # Threshold logic
│   └── machine.ts       # State transitions
└── graph/               # Graph query types (planned)
    ├── types.ts         # Graph node/edge types
    └── templates.ts     # Query templates
```

## File Naming Conventions

### General Rules
- Use kebab-case for files and directories
- Use PascalCase for React components
- Use camelCase for TypeScript files and functions
- Use UPPER_CASE for environment variables

### Specific Patterns
- Pages: `kebab-case.tsx` (e.g., `focus-drift.tsx`)
- Components: `PascalCase.tsx` (e.g., `TaskCard.tsx`)
- Services: `kebab-case.ts` (e.g., `ai-service.ts`)
- Types: `kebab-case.ts` (e.g., `auth-types.ts`)

## Module Organization

### Frontend Modules
- **Pages:** Route-level components in `pages/`
- **Components:** Reusable UI components in `components/`
- **Lib:** Utilities and providers in `lib/`
- **Hooks:** Custom React hooks (when needed)

### Backend Modules
- **Routes:** API endpoint definitions in `routes.ts`
- **Services:** Business logic in dedicated service files
- **Storage:** Database operations in `storage.ts`
- **AI:** AI-related services in `ai/` directory

### Shared Modules
- **Schema:** Single source of truth for data models
- **Types:** Shared TypeScript interfaces
- **Utilities:** Common functions used by both client and server

## Configuration Files

### Root Configuration
- `package.json` - Dependencies and scripts
- `tsconfig.json` - TypeScript configuration
- `tailwind.config.ts` - Tailwind CSS configuration
- `vite.config.ts` - Vite build configuration
- `docker-compose.yml` - Local development services

### Environment Configuration
- `.env` - Local environment variables
- `.env.example` - Environment variable template
- `server/config.ts` - Environment detection and provider config

### Database Configuration
- `drizzle.config.ts` - Drizzle ORM configuration
- `shared/schema.ts` - Database schema definitions

## Documentation Structure

### Primary Documentation (`docs/`)
- `docs/dev/prd.md` - Product Requirements Document
- `docs/dev/architecture.md` - Technical Architecture
- `docs/dev/userJourneyMaps.md` - User Journey Maps
- `docs/dev/design_guidelines.md` - Design Guidelines
- `docs/dev/ragStrategies.md` - RAG Implementation Strategies
- `docs/aiHandoff.md` - AI Agent Handoff Document

### Implementation Artifacts (`_bmad-output/`)
- `planning-artifacts/epics.md` - Epic definitions
- `implementation-artifacts/` - Story files and implementation plan
- `implementation-artifacts/sprint-status.yaml` - Progress tracking

### Steering Documents (`.kiro/steering/`)
- `product.md` - Product overview and objectives
- `tech.md` - Technical architecture summary
- `structure.md` - Project structure guide
- `calendarIntegration.md` - Calendar integration documentation
- `agents.md` - Specialized development agents guide

## Asset Organization

### Static Assets
- `client/public/` - Public assets (favicon, images)
- `client/src/assets/` - Bundled assets (if needed)

### Styling
- `client/src/index.css` - Global styles and Tailwind imports
- `client/src/components/ui/` - Component-specific styles via shadcn/ui

## Build Artifacts

### Development
- `node_modules/` - Dependencies (gitignored)
- `dist/` - Vite build output (gitignored)
- `.drizzle/` - Drizzle migration artifacts (gitignored)

### Production
- Docker images for Neo4j and Qdrant
- Built client assets served by Express
- Compiled TypeScript in production deployment

## Environment-Specific Files

### Development
- Local PostgreSQL database
- Docker containers for Neo4j and Qdrant
- Local Ollama for AI inference (optional)
- Development environment variables

### Production
- Managed PostgreSQL (Railway, Google Cloud SQL)
- Neo4j Aura (managed cloud)
- Qdrant Cloud (managed service)
- Gemini API for AI inference
- Production environment variables

### Privacy Mode (`CONTINUUM_MODE=local`)
- All services run locally
- No external API calls
- Firebase-based authentication
- Docker Compose orchestration

## Key Implementation Details

### Task Management System
- **Dual View Architecture:** List view and Kanban view with shared data layer
- **Smart Status Detection:** Tasks automatically transition to "in_progress" based on focus session history
- **Priority-Based Sorting:** Consistent high → medium → low ordering across all views
- **Blocked Task Indicators:** Visual alerts with AlertCircle icons for blocked status

### Focus Session Architecture
- **Server-Authoritative State:** All timing logic handled server-side for accuracy
- **Multi-Stage Drift Detection:** Progressive intervention system (0-3 stages)
- **Task Integration:** Direct connection between focus sessions and task status
- **Notes System:** Session-specific notes with localStorage backup

### Calendar Integration Architecture
- **Multi-Provider Support:** Unified interface for Google Calendar and Microsoft Graph APIs
- **OAuth Token Management:** Encrypted storage with automatic refresh handling
- **Timezone Normalization:** Consistent timezone handling across providers
- **Meeting Link Extraction:** Automatic detection of Teams/Meet/Zoom URLs
- **Common Pitfalls:** See `.kiro/steering/common-pitfalls.md` for detailed troubleshooting

### API Architecture
- **RESTful Design:** 57+ endpoints following consistent naming conventions
- **Zod Validation:** Runtime type checking for all API inputs
- **User Scoping:** All data access scoped to authenticated user
- **Error Handling:** Structured error responses with proper HTTP status codes
- **Debug Logging:** Enable with `DEBUG=true` environment variable for detailed request/response logs
