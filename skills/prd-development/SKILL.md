---
name: prd-development
description: Use after research gathering to synthesize findings into a comprehensive Product Requirements Document (PRD) through iterative collaboration with the user
---

# PRD Development

Synthesize research findings into a comprehensive Product Requirements Document (PRD) through iterative collaboration with the user.

**Core principle:** Research-informed + user-collaborative + iterative validation = high-quality PRD

## When to Use

Use this skill when:
- Research gathering phase is complete and validated
- Ready to define specific requirements for a feature
- Need to formalize scope, goals, and acceptance criteria
- Moving from "what exists" to "what we're building"

Do NOT use when:
- Research hasn't been done yet (use `superpowers:research-gathering` first)
- Making a simple change that doesn't need formal requirements
- Just brainstorming without intent to implement (use `superpowers:brainstorming`)

## Prerequisites

Before starting PRD development:
1. Research synthesis document exists and is validated by user
2. User has approved the research findings
3. Journal directory exists: `docs/journals/YYYY-MM-DD-<feature>/`

## The Process

```
1. Load research synthesis document
2. Present research summary to user
3. Create PRD journal: docs/journals/<feature>/02-prd/prd-development-journal.md
4. Ask clarifying questions (ONE at a time):
   - Goals and success criteria
   - Scope boundaries (in/out)
   - User needs and stories
   - Technical constraints
   - Priority and timeline
5. Journal each Q&A and decision
6. Draft PRD sections iteratively (200-300 words each)
7. Validate each section with user
8. Finalize and save PRD document
9. User signs off on PRD
10. Write final journal entry summarizing key decisions
```

## Question Strategy

**Ask ONE question at a time.** Don't overwhelm with multiple questions.

**Prefer multiple choice** when options are clear:
- "Should this feature support: (a) single user only, (b) multi-user from start, or (c) single now with multi-user planned?"

**Open-ended for exploration:**
- "What problem is this solving for users?"
- "What would success look like?"

**Question sequence:**

1. **Goals:** "What are the top 1-3 goals for this feature?"
2. **Non-goals:** "What explicitly should NOT be in scope?"
3. **Users:** "Who will use this? What do they need?"
4. **Requirements:** For each goal, "What specific requirements would achieve this?"
5. **Constraints:** "Any technical constraints or dependencies we should know about?"
6. **Success:** "How will we know this is successful?"

## PRD Structure

The final PRD should follow this structure:

```markdown
# [Product/Feature Name] PRD

**Version:** 1.0
**Date:** YYYY-MM-DD
**Author:** [User] with AI assistance
**Status:** Draft | In Review | Approved

---

## Executive Summary

[One paragraph describing what we're building and why. Should be understandable
by anyone, not just engineers.]

---

## Background

[Context from research. Why is this needed? What problem does it solve?
Reference the research synthesis document.]

**Research Reference:** [link to research synthesis]

---

## Goals & Non-Goals

### Goals
1. [Specific, measurable goal]
2. [Another goal]

### Non-Goals
- [Explicit scope boundary - what we're NOT doing]
- [Another non-goal]

---

## User Stories

### Primary Users
[Who are the users?]

### User Stories
- As a [user type], I want [capability] so that [benefit]
- As a [user type], I want [capability] so that [benefit]

---

## Requirements

### Functional Requirements

**[FR-1] [Requirement Name]**
- Description: [What it does]
- Acceptance Criteria:
  - [ ] [Specific, verifiable criterion]
  - [ ] [Another criterion]
- Priority: Must Have | Should Have | Nice to Have

**[FR-2] [Requirement Name]**
...

### Non-Functional Requirements

**[NFR-1] Performance**
- [Specific performance requirement with numbers]

**[NFR-2] Security**
- [Specific security requirement]

**[NFR-3] Reliability**
- [Specific reliability requirement]

---

## Technical Approach

[High-level architecture, informed by research. Not detailed design, but
enough to validate feasibility.]

### Integration Points
[Where this connects to existing system, based on research]

### Dependencies
[What this depends on, from research]

---

## Multi-Repo Considerations

[If applicable: which repos affected, cross-repo dependencies, coordination needed]

---

## Success Metrics

| Metric | Target | How Measured |
|--------|--------|--------------|
| [Metric] | [Target value] | [Measurement method] |

---

## Open Questions

[Questions that need answers before or during implementation]

1. [Question]
2. [Question]

---

## Timeline & Phases

[If applicable: phased rollout, milestones]

---

## Appendix

### Research Reference
- [Research Synthesis](link)
- [Research Journals](link)

### Related Documents
- [Any other relevant docs]
```

## Journaling Requirements

**Write to:** `docs/journals/<feature>/02-prd/prd-development-journal.md`

**Journal Format:**

```markdown
# PRD Development Journal - [Feature Name]

## Progress
- **Status:** Working | Complete | Blocked
- **Started:** [timestamp]
- **Current Step:** [what you're doing now]
- **Blocked?:** No | Yes - "[specific question]"

## Session Info
- **Agent:** PRD Developer
- **Phase:** PRD Development
- **Research Doc:** [link]

---

## Summary
[2-3 sentences: Key PRD decisions and scope]

## Key Findings
- [Bullet: Major scope decision]
- [Bullet: Key requirement identified]
- [Bullet: Important constraint]

---

## Full Detail

### Q&A Log

**Q1: [Question asked]**
> User response: [Their answer]

Decision: [What we decided based on this]
Rationale: [Why]

**Q2: [Question asked]**
> User response: [Their answer]

Decision: [What we decided]
Rationale: [Why]

### Scope Decisions

| Item | In Scope? | Rationale |
|------|-----------|-----------|
| [Feature/capability] | Yes/No | [Why] |

### Requirements Evolution

[How requirements changed through discussion]

### Alternatives Considered

| Approach | Pros | Cons | Decision |
|----------|------|------|----------|
| [Approach A] | [pros] | [cons] | Chosen/Rejected |
| [Approach B] | [pros] | [cons] | Chosen/Rejected |
```

## Iterative Validation

**Present PRD in sections (200-300 words each):**

1. Present Executive Summary → validate
2. Present Goals & Non-Goals → validate
3. Present User Stories → validate
4. Present Requirements (group by area) → validate
5. Present Technical Approach → validate
6. Present Success Metrics → validate

**After each section:**
- "Does this capture your intent?"
- "Anything to add or change?"
- "Any concerns?"

**If user has changes:**
- Update section
- Journal the change and rationale
- Re-validate

## Red Flags

**Never:**
- Skip reading the research synthesis first
- Ask multiple questions at once
- Proceed without user validation of each section
- Make up requirements (always trace to user input or research)
- Finalize PRD without explicit user approval

**If stuck:**
- Write question to journal
- Set Blocked status
- Ask user for guidance

## Output

**PRD Document:** `docs/plans/YYYY-MM-DD-<feature>-prd.md`

**After PRD is approved:**
- Offer to proceed to task decomposition
- "PRD complete. Ready to break this into implementation tasks?"
- Use `superpowers:task-decomposition` for next phase

## Integration

**Requires:** `superpowers:research-gathering` (research must be done first)

**Next phase:** `superpowers:task-decomposition` (break PRD into tasks)

**Part of:** `superpowers:virtual-dev-team` workflow
