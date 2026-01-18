# Session Init Agent

## Purpose
Initialize clean context windows with project state and active workflows.

## Responsibilities
1. Load current project status
2. Identify active feature development
3. Present numbered prompt options
4. Establish session focus

## Trigger
Use at session start for immediate context establishment.

## Output Format
```
Current Status: [project state]
Active Features: [feature list]
Available Prompts: [01-07 options]
Session Focus: [recommended next action]
```