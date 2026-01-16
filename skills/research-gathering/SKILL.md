---
name: research-gathering
description: Use when starting a new feature/product to gather comprehensive context about codebase(s), dependencies, constraints, and documentation before specification begins
---

# Research Gathering

Dispatch parallel researcher agents to gather comprehensive context about the codebase(s), dependencies, constraints, and relevant documentation before product specification begins.

**Core principle:** Parallel specialized researchers + consolidation = comprehensive context without blind spots

## When to Use

Use this skill when:
- Starting a new feature or product
- Working with unfamiliar codebase(s)
- Need to understand existing architecture before making changes
- Building something that spans multiple repositories
- User describes what they want to build at a high level

Do NOT use when:
- Making a small, localized change
- You already have comprehensive context
- The task is purely exploratory (use Task tool with Explore agent instead)

## The Process

```
1. User describes what they want to build (high level)
2. User identifies repos involved (or you help identify them)
3. Create journal directory: docs/journals/YYYY-MM-DD-<feature>/
4. Dispatch 4 researcher agents in parallel:
   - Architecture Researcher
   - Dependencies Researcher
   - Features Researcher
   - Docs Researcher
5. Each researcher writes findings to their journal
6. Dispatch Consolidator agent to merge findings
7. Present research synthesis to user for validation
8. User confirms or requests additional research
```

## Researcher Types

### 1. Architecture Researcher
**Focus:** Code structure, patterns, conventions, module boundaries, data flow

**Prompt:** `./architecture-researcher-prompt.md`

**Discovers:**
- Directory structure and organization
- Key modules and their responsibilities
- Design patterns in use
- Data flow between components
- Entry points and API boundaries
- Naming conventions and coding style

### 2. Dependencies Researcher
**Focus:** External deps, internal deps, version constraints, compatibility

**Prompt:** `./dependencies-researcher-prompt.md`

**Discovers:**
- External package dependencies and versions
- Internal module dependencies
- Version constraints and compatibility issues
- Dependency conflicts or concerns
- Build/runtime requirements
- Security advisories on dependencies

### 3. Features Researcher
**Focus:** Existing features, how they work, integration points

**Prompt:** `./features-researcher-prompt.md`

**Discovers:**
- Existing feature inventory
- How features are implemented
- Integration points and extension mechanisms
- Feature flags and configuration
- User-facing vs internal features
- Shared components and utilities

### 4. Docs Researcher
**Focus:** README, API docs, design docs, external references

**Prompt:** `./docs-researcher-prompt.md`

**Discovers:**
- README and getting started guides
- API documentation
- Architecture/design documents
- External API docs that are relevant
- Relevant standards or specifications
- Existing decision records (ADRs)

## Multi-Repo Handling

When multiple repositories are involved:
- Each researcher receives the list of repos
- Architecture researcher maps cross-repo dependencies
- Features researcher identifies shared components
- Output includes both per-repo AND cross-repo findings
- Consolidator highlights cross-repo concerns

## Journaling Requirements

**Each researcher writes to:** `docs/journals/<feature>/01-research/<researcher-name>.md`

**Journal must include:**
- Progress header (Status, Current Step, Blocked?)
- Summary (2-3 sentences of key findings)
- Key Findings (bullet points)
- Full Detail (search queries, files examined, reasoning)

**Consolidator writes:** `docs/journals/<feature>/01-research/research-synthesis.md`

## Dispatch Instructions

Dispatch all 4 researchers in parallel using the Task tool:

```
Task tool (general-purpose):
  description: "Architecture research for [feature]"
  prompt: [Full content of ./architecture-researcher-prompt.md with context filled in]

Task tool (general-purpose):
  description: "Dependencies research for [feature]"
  prompt: [Full content of ./dependencies-researcher-prompt.md with context filled in]

Task tool (general-purpose):
  description: "Features research for [feature]"
  prompt: [Full content of ./features-researcher-prompt.md with context filled in]

Task tool (general-purpose):
  description: "Docs research for [feature]"
  prompt: [Full content of ./docs-researcher-prompt.md with context filled in]
```

After all 4 complete, dispatch consolidator:

```
Task tool (general-purpose):
  description: "Consolidate research for [feature]"
  prompt: [Full content of ./research-consolidator-prompt.md with researcher outputs]
```

## Output

**Research Synthesis Document:** `docs/research/YYYY-MM-DD-<project>-research.md`

```markdown
# Research Synthesis: [Feature Name]

**Date:** YYYY-MM-DD
**Repos:** [list]
**Researchers:** Architecture, Dependencies, Features, Docs

## Executive Summary
[2-3 paragraphs summarizing key findings across all researchers]

## Architecture Overview
[Key findings from architecture researcher]

## Dependencies & Constraints
[Key findings from dependencies researcher]

## Existing Features & Integration Points
[Key findings from features researcher]

## Relevant Documentation
[Key findings from docs researcher]

## Cross-Cutting Concerns
[Issues that span multiple areas]

## Gaps & Open Questions
[What we still don't know, questions for user]

## Recommendations for Next Phase
[Suggestions for PRD development]
```

## User Validation

After presenting the synthesis:
- Ask user if findings match their understanding
- Ask if any areas need deeper research
- Clarify any open questions
- Get explicit approval before proceeding to PRD phase

## Red Flags

**Never:**
- Skip a researcher type (even if you think it's not needed)
- Proceed to PRD without user validation of research
- Let researchers work sequentially (dispatch in parallel)
- Have researchers read each other's work (they work independently)
- Guess at findings (ask user if stuck)

**If a researcher gets stuck:**
- Write to journal: "Blocked: [specific question]"
- Update Progress header with blocked status
- Ask user for guidance before proceeding

## Integration

**Next phase:** After research is validated, use `superpowers:prd-development` to synthesize findings into a PRD.

**Part of:** `superpowers:virtual-dev-team` workflow
