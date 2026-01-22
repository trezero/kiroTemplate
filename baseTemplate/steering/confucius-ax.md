# Confucius AX (Agent Experience) Standards

## Architecture Overview

The Confucius SDK implements a three-layer architecture for AI agent operations:

- **AX (Agent Experience)**: Internal agent cognition and memory management
- **UX (User Experience)**: Human-agent interaction patterns
- **DX (Developer Experience)**: Tooling and traceability for development workflows

## AX Layer: Agent Experience Standards

### Hierarchical Memory Structure

#### Session Scope
- **Purpose**: Maintain high-level goal and overall context
- **Lifecycle**: Persists for entire agent session
- **Content**: Project objectives, architectural constraints, success criteria

#### Entry Scope  
- **Purpose**: Current reasoning step and immediate context
- **Lifecycle**: Active during specific sub-task execution
- **Content**: Current problem, available data, reasoning chain

#### Runnable Scope
- **Purpose**: Specific tool inputs/outputs and execution details
- **Lifecycle**: Single tool execution cycle
- **Content**: Command parameters, output parsing, error handling

### Adaptive Context Management

#### Context Monitoring
```
Context Usage Thresholds:
- Green Zone: 0-50% (Normal operation)
- Yellow Zone: 50-75% (Monitor closely)
- Red Zone: 75%+ (Trigger consolidation)
```

#### Memory Consolidation Protocol
1. **Trigger**: Context usage exceeds 75%
2. **Process**: Distill previous Entries into Context Summary
3. **Preserve**: Session Scope and current Entry Scope
4. **Archive**: Detailed execution logs to hindsight notes

### Extension-Based Tooling

#### Tool Prioritization Matrix
```
Phase 1 - Perception: read, glob, grep
Phase 2 - Analysis: Internal reasoning
Phase 3 - Action: write, shell, subagent
Phase 4 - Reflection: hindsight documentation
```

#### Extension Execution Pattern
1. **Discovery**: Use perception tools to understand current state
2. **Planning**: Apply hierarchical memory to determine actions
3. **Execution**: Minimal necessary changes only
4. **Documentation**: Update hindsight notes with learnings

### Decision Traceability

#### Step ID Format
```
CONF-{YYYYMMDD}-{HH:MM}-{NN}
Example: CONF-20260112-1154-01
```

#### Decision Log Structure
```markdown
## Step ID: CONF-{timestamp}-{sequence}
**Context**: {Entry Scope summary}
**Decision**: {What was decided}
**Rationale**: {Why this approach}
**Tools Used**: {Extension list}
**Outcome**: {Result and next steps}
```

### Hindsight Note-Taking

#### File Location
`.kiro/confucius/hindsight_notes.md`

#### Entry Format
```markdown
## Session: {date} - {high-level goal}

### What Worked
- {Successful patterns and approaches}

### What Failed  
- {Failed attempts and root causes}

### Architectural Patterns Discovered
- {Reusable patterns for future sessions}

### Context Consolidations
- {Summary of consolidated memory}
```

## Implementation Guidelines

### Memory Management
- Monitor context usage after each tool execution
- Consolidate proactively to maintain reasoning quality
- Preserve architectural decisions in hindsight notes

### Tool Usage
- Always start with perception (read/glob/grep)
- Minimize write operations to essential changes only
- Use subagents for independent parallel tasks

### Quality Assurance
- Every major sub-task must update hindsight notes
- Decision traceability required for all architectural choices
- Context summaries must preserve essential reasoning chains

## Integration with Continuum

This AX standard integrates with Continuum's existing agent system while providing enhanced memory management and traceability for complex software engineering tasks.

### Compatibility
- Works with existing Kiro CLI agent framework
- Leverages Continuum's steering document system
- Maintains compatibility with project-specific agents

### Enhancement Areas
- Provides structured memory management for large codebases
- Adds systematic hindsight learning capability
- Implements decision traceability for complex refactoring tasks
