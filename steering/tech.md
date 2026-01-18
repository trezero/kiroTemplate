# Technical Architecture

## Technology Stack

### Frontend
- **Framework:** React 18 + TypeScript + Vite
- **Routing:** Wouter (lightweight React router)
- **Styling:** TailwindCSS + shadcn/ui components
- **State Management:** React Query for server state, React Context for auth
- **Build Tool:** Vite for fast development and optimized builds
- **UI Components:** shadcn/ui component library with Radix UI primitives

### Backend
- **Runtime:** Node.js + Express.js + TypeScript
- **Authentication:** Firebase Auth with session management
- **API:** RESTful endpoints with Zod validation
- **File Structure:** Modular services with clear separation of concerns

### Databases (Three-Layer Architecture)
- **Layer 1 - PostgreSQL:** Source of truth for all entities (users, tasks, meetings, focus_sessions)
- **Layer 2 - Neo4j:** Knowledge graph for relationship intelligence (task → meeting, task → person)
- **Layer 3 - Qdrant:** Vector store for semantic similarity and duplicate detection

### AI & Intelligence
- **Primary AI:** Gemini 2.5 Flash (cloud) with fallback to Ollama (local)
- **AI Evaluation Pipeline:** Entity extraction, relationship inference, priority estimation
- **Agentic RAG:** Smart retrieval strategy selection (graph vs vector vs SQL)
- **Embeddings:** Gemini embeddings for vector similarity

### External Integrations
- **Calendar:** Multi-account Google Calendar and Microsoft Outlook OAuth integration
- **Meeting Links:** Automatic extraction of Teams/Meet/Zoom URLs from calendar events
- **Timezone Handling:** Proper timezone conversion for cross-platform calendar events
- **Future:** Meeting transcription and action item extraction

## Data Models

### Core Entities

#### User Profile
```typescript
interface UserProfile {
  id: string;
  userId: string;
  relationshipMode: "quiet" | "guided" | "active";
  isOnboarded: boolean;
}
```

#### Task
```typescript
interface Task {
  id: string;
  userId: string;
  title: string;
  description?: string;
  priority: "high" | "medium" | "low";
  status: "pending" | "in_progress" | "blocked" | "completed";
  dueDate?: string;
  energyLevel?: "high" | "medium" | "low";
  estimatedMinutes?: number;
  taskType?: string;
  relatedLink?: string;
}
```

#### Focus Session
```typescript
interface FocusSession {
  id: string;
  userId: string;
  taskId?: string;
  status: "active" | "ended";
  relationshipMode: "quiet" | "guided" | "active";
  interventionStyle: "gentle" | "moderate" | "direct";
  startedAt: Date;
  plannedEndAt: Date;
  endedAt?: Date;
  stage: number; // 0-3 for drift stages
  lastStageAt?: Date;
  snoozeCount: number;
  extendCount: number;
  lastUserActionAt: Date;
  notes?: string;
  meta: object; // JSON for additional data
}
```

#### Meeting
```typescript
interface Meeting {
  id: string;
  userId: string;
  title: string;
  description?: string;
  startTime: string;
  endTime: string;
  attendees?: string;
  notes?: string;
  actionItems?: string;
}
```

#### Calendar Account
```typescript
interface CalendarAccount {
  id: string;
  userId: string;
  provider: "google" | "microsoft";
  connectorId?: string;
  accountEmail: string;
  accountLabel?: string;
  isEnabled: boolean;
  lastSyncAt?: Date;
  enabledCalendars: string; // JSON array
  accessToken?: string;
  refreshToken?: string;
  tokenExpiresAt?: Date;
  metadata: string; // JSON object
  createdAt: Date;
}
```

#### User Settings
```typescript
interface UserSettings {
  // Profile
  name: string;
  email: string;
  timezone: string;
  
  // Focus & Energy
  peakEnergyStart: string;
  peakEnergyEnd: string;
  focusDuration: number;
  breakDuration: number;
  
  // Focus Drift Guardrails
  enableDriftDetection: boolean;
  driftSensitivity: "low" | "medium" | "high";
  interventionStyle: "gentle" | "moderate" | "direct";
  
  // Calendars & Time
  connectedCalendars: string[];
  workingHoursStart: string;
  workingHoursEnd: string;
  
  // Notifications
  enableNotifications: boolean;
  notificationSound: boolean;
  quietHoursStart: string;
  quietHoursEnd: string;
  
  // Meetings & Capture
  autoCapture: boolean;
  captureActionItems: boolean;
  
  // Privacy & Data
  dataRetentionDays: number;
  shareAnalytics: boolean;
  
  // Advanced
  experimentalFeatures: boolean;
  debugMode: boolean;
}
```

## API Endpoints

### Authentication & Users
- `GET /api/auth/user` - Get current authenticated user
- `GET /api/users/:id/profile` - Get user profile
- `PATCH /api/users/:id/profile` - Update user profile
- `PATCH /api/users/:id/relationship-mode` - Update relationship mode

### Tasks Management
- `GET /api/tasks` - List all tasks for user
- `GET /api/tasks/recommendations` - Get AI task recommendations
- `GET /api/tasks/:id` - Get specific task
- `POST /api/tasks` - Create new task
- `PATCH /api/tasks/:id` - Update task
- `DELETE /api/tasks/:id` - Delete task
- `GET /api/tasks/:taskId/focus-history` - Get focus session history for task
- `GET /api/tasks/:taskId/focus-stats` - Get focus statistics for task

### Focus Sessions
- `GET /api/focus/sessions/active` - Get active focus session
- `GET /api/focus/sessions` - Get all focus sessions for user
- `POST /api/focus/sessions` - Start new focus session
- `PATCH /api/focus/sessions/:id` - Update focus session (end, extend, add notes)

### Meetings Management
- `GET /api/meetings` - List all meetings for user
- `GET /api/meetings/:id` - Get specific meeting
- `POST /api/meetings` - Create new meeting
- `PATCH /api/meetings/:id` - Update meeting
- `DELETE /api/meetings/:id` - Delete meeting
- `POST /api/meetings/transcribe` - Transcribe meeting audio
- `POST /api/meetings/create` - Create meeting from calendar event

### Calendar Integration
- `GET /api/calendar/accounts` - List connected calendar accounts
- `GET /api/calendar/accounts/sync` - Sync calendar accounts
- `GET /api/calendar/accounts/available` - Get available calendar providers
- `POST /api/calendar/accounts` - Connect new calendar account
- `PATCH /api/calendar/accounts/:id` - Update calendar account
- `DELETE /api/calendar/accounts/:id` - Disconnect calendar account
- `GET /api/calendar/status` - Get calendar sync status
- `GET /api/calendar/events` - Get calendar events
- `GET /api/calendar/events/today` - Get today's events
- `GET /api/calendar/events/date/:date` - Get events for specific date
- `POST /api/calendar/events` - Create calendar event
- `PATCH /api/calendar/events/:id` - Update calendar event
- `DELETE /api/calendar/events/:id` - Delete calendar event
- `GET /api/calendar/freebusy` - Get free/busy information
- `GET /api/calendar/list` - List available calendars
- `GET /api/calendar/connected` - Get connected calendar info
- `GET /api/calendar/google/list` - List Google calendars
- `GET /api/calendar/microsoft/list` - List Microsoft calendars

### OAuth Authentication
- `GET /api/auth/google` - Initiate Google OAuth flow
- `GET /api/auth/google/callback` - Handle Google OAuth callback
- `GET /api/auth/microsoft` - Initiate Microsoft OAuth flow
- `GET /api/auth/microsoft/callback` - Handle Microsoft OAuth callback

### Conversations & AI
- `GET /api/conversations` - Get conversation history
- `POST /api/conversations/messages` - Send message to AI assistant

### Contacts Management
- `GET /api/contacts` - List contacts
- `POST /api/contacts/import` - Import contacts from calendar

### Settings & Configuration
- `GET /api/settings` - Get user settings
- `PATCH /api/settings` - Update user settings
- `GET /api/config` - Get application configuration

### Local AI (Ollama)
- `GET /api/ollama/status` - Check Ollama status
- `GET /api/ollama/models` - List available models
- `POST /api/ollama/pull` - Pull new model
- `POST /api/ollama/configure` - Configure Ollama settings

### Analytics
- `GET /api/analytics/task-type/:taskType` - Get analytics for task type

## Architecture Overview

### Three-Layer Data Model
Continuum uses a sophisticated three-layer storage architecture for relationship intelligence:

1. **PostgreSQL (Transactional Layer):** ACID-compliant source of truth
2. **Neo4j (Relationship Layer):** Graph database for entity connections
3. **Qdrant (Semantic Layer):** Vector embeddings for similarity search

### Knowledge Graph Schema
```cypher
(:Task)-[:ORIGINATED_FROM {confidence}]->(Meeting)
(:Task)-[:BLOCKED_BY {confidence}]->(Task)
(:Task)-[:ASSIGNED_TO {confidence}]->(Person)
(:Task)-[:ABOUT]->(Topic)
(:FocusSession)-[:WORKED_ON]->(Task)
```

### Sync Orchestrator
Event-driven synchronization between layers:
- PostgreSQL writes trigger events
- Parallel sync to Neo4j + Qdrant
- Exponential backoff retry on failures
- Graceful degradation when graph services unavailable

### Focus Session State Machine
```
ACTIVE → Stage 0 (Normal)
      → Stage 1 (Gentle nudge)
      → Stage 2 (Tradeoff awareness)
      → Stage 3 (Circuit breaker)
      → ENDED
```

### Task Status Logic
- **pending**: New tasks without focus history
- **in_progress**: Tasks with focus session history (auto-determined)
- **blocked**: Explicitly marked as blocked
- **completed**: Finished tasks

## Development Environment

### Prerequisites
- Node.js 18+
- PostgreSQL 15+
- Docker (for Neo4j and Qdrant)
- Git

### Setup Commands
```bash
npm install                    # Install dependencies
npm run db:push               # Push schema to PostgreSQL
docker-compose up -d neo4j    # Start Neo4j
docker-compose up -d qdrant   # Start Qdrant
npm run dev                   # Start development server
```

### Environment Variables
```bash
DATABASE_URL=postgresql://...
NEO4J_URI=bolt://localhost:7687
QDRANT_URL=http://localhost:6333
GEMINI_API_KEY=...
GOOGLE_CLIENT_ID=...
GOOGLE_CLIENT_SECRET=...
MICROSOFT_CLIENT_ID=...
MICROSOFT_CLIENT_SECRET=...
```

## Code Standards

### File Organization
- `client/src/` - React frontend
- `server/` - Express backend
- `shared/` - Shared types and schemas
- `docs/` - Documentation

### TypeScript Standards
- Strict mode enabled
- Zod for runtime validation
- Drizzle ORM for type-safe database queries
- Shared types between client and server

### API Design
- RESTful endpoints with consistent naming
- Zod validation for all inputs
- Structured error responses
- User-scoped data access

### Component Architecture
- Functional components with hooks
- shadcn/ui for consistent design system
- Separation of concerns (UI, logic, data)
- Reusable components in `components/ui/`

## Testing Strategy

### Current Testing
- TypeScript compilation checks
- Manual testing workflows
- Integration testing for API endpoints

### Planned Testing
- Unit tests for core services
- Integration tests for AI evaluation pipeline
- End-to-end tests for critical user flows
- Performance tests for graph queries

## Deployment Process

### Cloud Deployment (Production)
- **Platform:** Railway, Google Cloud Run, or similar
- **Database:** Managed PostgreSQL
- **Graph:** Neo4j Aura (managed cloud)
- **Vector:** Qdrant Cloud (managed service)
- **Monitoring:** Structured logging with request IDs

### Local Deployment (Privacy Mode)
- **Mode:** `CONTINUUM_MODE=local`
- **Database:** Local PostgreSQL
- **Graph:** Neo4j Community Edition (Docker)
- **Vector:** Self-hosted Qdrant (Docker)
- **AI:** Ollama for fully private inference

## Performance Requirements

### Response Times
- API endpoints: <200ms p95
- Graph queries: <100ms for 1-2 hop traversals
- Vector searches: <200ms for semantic similarity
- Background sync: PostgreSQL → Neo4j + Qdrant within 5 seconds

### Scalability
- Single-user focused (Phase 1)
- Designed for eventual multi-tenant scaling
- Horizontal scaling via microservices architecture

## Security Considerations

### Authentication & Authorization
- Firebase Authentication with secure sessions
- User-scoped data access across all layers
- OAuth tokens encrypted at rest
- No cross-user data access

### Data Protection
- All sensitive configuration via environment variables
- Encrypted storage for OAuth tokens
- User data isolation in PostgreSQL, Neo4j, and Qdrant
- Optional local deployment for maximum privacy

### API Security
- Input validation with Zod schemas
- Rate limiting on API endpoints
- CORS configuration for frontend access
- Secure session management
