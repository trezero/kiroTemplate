# Product Overview

## Project Status Reference
**IMPORTANT:** Always check `docs/projectStatus.md` for the current state of all components, testing status, and known issues before starting any development work.

## Product Purpose
[Define your product's core purpose and value proposition here]

**Core Differentiator:** [What makes your product unique in the market]

## Target Users
- **Primary:** Adults with ADHD who are knowledge workers
- **Characteristics:** High cognitive load, multiple responsibilities
- **Core Struggles:**
  - Task initiation and context switching
  - Overrunning time blocks and focus drift
  - Forgetting downstream consequences
  - Low working memory for tasks and commitments
  - Priority blindness (everything feels urgent or nothing does)
  - Decision fatigue from constant re-evaluation

## Key Features

### Phase 1 (Current Implementation)
- **Server-Authoritative Focus Sessions:** Timer-based focus tracking with drift detection
- **Multi-Stage Drift Nudges:** Gentle → Tradeoff → Circuit Breaker interventions
- **AI Evaluation Pipeline:** Automatic entity extraction, relationship inference, priority/duration estimation
- **Knowledge Graph Intelligence:** Neo4j-powered relationship understanding between tasks, meetings, people
- **Agentic RAG Service:** Smart retrieval across graph, vector, and SQL data sources
- **Tasks with Relationship Context:** AI-suggested fields with confidence scoring and explanations
- **Calendar Integration:** Multi-account Google Calendar and Microsoft Outlook with event aggregation
- **Conversation Interface:** Persistent chat with context-aware AI responses
- **Relationship Modes:** Quiet/Guided/Active assistant behavior settings
- **Daily/Missed Day Recaps:** Reflection without guilt or shame
- **Kanban Task View:** Visual task management with automatic status detection based on focus history
- **Priority-Based Task Sorting:** High → Medium → Low priority ordering
- **Blocked Task Indicators:** Visual indicators for blocked tasks across all views

### Phase 2 (Planned)
- Real meeting transcription and action item extraction
- Background scheduler for out-of-app notifications
- Enhanced graph capabilities and pattern detection
- Mobile-responsive UI

## Business Objectives
- **Primary Goal:** Build long-term trust through transparency and autonomy
- **Success Philosophy:** The user feels confident focusing on what they are doing now because Continuum understands the whole picture and is watching everything else
- **Key Metrics (Qualitative):**
  - User reports higher confidence staying focused
  - User switches tasks closer to planned times
  - Reduced repeated snoozing over time
  - Increased trust in "Now" recommendation

## User Journey
1. **Onboarding:** Email auth → Relationship Mode selection → Settings configuration
2. **Daily Flow:** 
   - Open "Now" screen for single recommendation
   - Start focus session with planned duration
   - Receive gentle drift nudges with graph-powered consequences
   - Capture thoughts/tasks via Conversation interface
   - Review daily recap for reflection
3. **Task Management:** 
   - AI-evaluated task creation with relationship inference
   - Toggle between List and Kanban views
   - Priority-based sorting with blocked task indicators
   - Automatic status detection (pending → in_progress based on focus history)
4. **Meeting Integration:** Calendar sync with action item extraction
5. **Settings Management:** Granular control over assistant behavior and notifications

## Success Criteria
**Trust Signal Achievement:** "You are allowed to focus. I've got the rest."

**Behavioral Indicators:**
- User consistently uses single-task recommendations from "Now" screen
- Drift interventions lead to conscious switching decisions rather than endless snoozing
- User captures thoughts without friction during active focus
- Graph-powered context helps user understand why tasks matter
- User feels supported rather than judged by the system
- User effectively uses both List and Kanban views for different workflows

**Technical Success:**
- Graph coverage: >40% of tasks with relationship edges
- Consequence modeling: >60% of Stage 2 nudges use graph data
- Sync performance: p95 <10s, p99 <30s for PostgreSQL → Neo4j → Qdrant
- Task status accuracy: >90% of tasks with focus history correctly appear in "In Progress"

## Current Feature Set

### Task Management
- **Dual View System:** Toggle between List and Kanban views
- **Smart Status Detection:** Tasks automatically move to "In Progress" when focus sessions exist
- **Priority Sorting:** High → Medium → Low across all views
- **Blocked Task Indicators:** Visual alerts for blocked tasks
- **Focus Integration:** Direct focus session start from task cards
- **AI-Powered Creation:** Automatic priority, energy level, and duration estimation

### Focus Sessions
- **Server-Authoritative Timing:** Accurate time tracking with drift detection
- **Multi-Stage Interventions:** Progressive nudges (0-3 stages)
- **Task Completion Integration:** Mark complete button ends session and updates task
- **Notes Capture:** Session-specific notes with localStorage backup
- **History Tracking:** Complete focus session history per task

### Calendar Integration
- **Multi-Provider Support:** Google Calendar and Microsoft Outlook
- **Multi-Account Management:** Connect multiple accounts per provider
- **Timezone Handling:** Proper timezone conversion and display
- **Meeting Link Extraction:** Automatic Teams/Meet/Zoom URL detection
- **Event Aggregation:** Unified view across all connected calendars

### AI Assistant
- **Relationship Intelligence:** Context-aware responses using knowledge graph
- **Conversation Persistence:** Chat history maintained across sessions
- **Agentic RAG:** Smart retrieval from multiple data sources
- **Consequence Modeling:** Graph-powered understanding of task dependencies

### Settings & Customization
- **Relationship Modes:** Quiet/Guided/Active assistant behavior
- **Focus Preferences:** Duration, break times, intervention styles
- **Calendar Configuration:** Account management and sync preferences
- **Privacy Controls:** Data retention and sharing preferences
