# Journal Template

Standard format for all virtual-dev-team agent journals. Each agent MUST follow this structure.

## The Three-Tier Structure

Every journal has three tiers of content:

### Tier 1: Progress Header (machine-readable)
```markdown
## Progress
- **Status:** Working | Complete | Blocked
- **Task:** [what this agent is doing]
- **Started:** [timestamp]
- **Current Step:** [what's happening now]
- **Blocked?:** No | Yes - "[specific question]"
```

This header enables:
- On-demand status aggregation across agents
- Quick scanning by orchestrator
- Resume detection

### Tier 2: Summary + Key Findings (for handoffs)
```markdown
## Session Info
- **Agent:** [agent type]
- **Phase:** [which phase]
- **Repo/Feature:** [context]

---

## Summary
[2-3 sentences: What was done, key decisions, outcome]

## Key Findings
- [Bullet: Most important discovery/decision]
- [Bullet: Second most important]
- [Bullet: Third if needed]
```

This tier is included when other agents read this journal. It provides enough context without overwhelming.

### Tier 3: Full Detail (available on demand)
```markdown
---

## Full Detail

[Complete thinking, all observations, alternatives considered, raw data]
```

This tier is only read when an agent needs to dig deeper into reasoning or debug an issue.

---

## Journal Templates by Agent Type

### Research Agent Journal

```markdown
# [Research Type] Research - [Feature Name]

## Progress
- **Status:** Working | Complete | Blocked
- **Task:** [Architecture/Dependencies/Features/External Docs] Research
- **Started:** [timestamp]
- **Current Step:** [what you're examining]
- **Blocked?:** No | Yes - "[question]"

## Session Info
- **Agent:** [Type] Researcher
- **Feature:** [name]
- **Repos:** [list]

---

## Summary
[2-3 sentences: What you found, key insights]

## Key Findings
- [Most important discovery]
- [Second most important]
- [Third if needed]

---

## Full Detail

### Files Examined
| File | Why | Finding |
|------|-----|---------|
| [path] | [reason] | [what you learned] |

### Observations
[Detailed notes on what you found]

### Questions for PRD
[Things that need clarification or decisions]

### Raw Notes
[Unprocessed observations if useful]
```

### PRD Development Journal

```markdown
# PRD Development Journal - [Feature Name]

## Progress
- **Status:** Working | Complete | Blocked
- **Task:** PRD Development
- **Started:** [timestamp]
- **Current Step:** [which section/question]
- **Blocked?:** No | Yes - "[question]"

## Session Info
- **Agent:** PRD Developer
- **Feature:** [name]
- **Research:** [link to synthesis]

---

## Summary
[2-3 sentences: PRD approach, key decisions, outcome]

## Key Findings
- [Key requirement decision]
- [Scope decision]
- [Technical constraint identified]

---

## Full Detail

### Research Synthesis Used
[Key points from research that informed PRD]

### User Collaboration Log
| Question | User Response | Impact on PRD |
|----------|---------------|---------------|
| [question asked] | [what user said] | [how it changed PRD] |

### Requirement Traceability
| Requirement | Source | Research Finding |
|-------------|--------|------------------|
| FR-1 | User input | - |
| FR-2 | Research | [which finding] |

### Scope Decisions
| In Scope | Out of Scope | Rationale |
|----------|--------------|-----------|
| [item] | | [why] |
| | [item] | [why] |

### Alternatives Considered
[Options not taken and why]
```

### Task Decomposition Journal

```markdown
# Task Decomposition Journal - [Feature Name]

## Progress
- **Status:** Working | Complete | Blocked
- **Task:** Task Decomposition
- **Started:** [timestamp]
- **Current Step:** [what you're breaking down]
- **Blocked?:** No | Yes - "[question]"

## Session Info
- **Agent:** Task Planner
- **PRD:** [link]
- **Feature:** [name]

---

## Summary
[2-3 sentences: How requirements became tasks, key dependencies]

## Key Findings
- [Number of tasks created]
- [Key dependency discovered]
- [Parallelization opportunity]

---

## Full Detail

### Requirements Breakdown
| Requirement | Tasks | Rationale |
|-------------|-------|-----------|
| FR-1 | T1, T2 | [why this split] |
| FR-2 | T3 | [why] |

### Dependency Reasoning
| Dependency | Why |
|------------|-----|
| T2 depends on T1 | [reason] |

### Task Sizing Decisions
| Decision | Reasoning |
|----------|-----------|
| Split T2 into T2a, T2b | [why] |

### Parallelization Analysis
[Which tasks can run together and why]
```

### Implementer Journal

```markdown
# Task [N] Implementation Journal - [Feature Name]

## Progress
- **Status:** Working | Complete | Blocked
- **Task:** [task name]
- **Started:** [timestamp]
- **Current Step:** [what you're implementing]
- **Blocked?:** No | Yes - "[question]"

## Session Info
- **Agent:** Implementer
- **Task:** [N]
- **Repo:** [repo name]

---

## Summary
[2-3 sentences: What you implemented, key decisions]

## Key Findings
- [Implementation approach chosen]
- [Key decision made]
- [Issue resolved]

---

## Full Detail

### Approach
[How you decided to implement this]

### Alternatives Considered
| Approach | Pros | Cons | Decision |
|----------|------|------|----------|
| [A] | | | Chosen/Rejected |

### Implementation Notes
[Details about what you did and why]

### Issues Encountered
| Issue | Resolution |
|-------|------------|
| [issue] | [how fixed] |

### Deviations from Plan
| Planned | Actual | Reason |
|---------|--------|--------|
| [plan said] | [you did] | [why] |
```

### Test Engineer Journal

```markdown
# Test Engineer Journal - Task [N]

## Progress
- **Status:** Working | Complete | Blocked
- **Task:** Tests for Task [N]
- **Started:** [timestamp]
- **Current Step:** [what you're testing]
- **Blocked?:** No | Yes - "[question]"

## Session Info
- **Agent:** Test Engineer
- **Testing Task:** [N]
- **Implementation By:** [implementer if known]

---

## Summary
[2-3 sentences: Test coverage, any gaps]

## Key Findings
- [Coverage achieved]
- [Edge case discovered]
- [Issue found in implementation]

---

## Full Detail

### Test Strategy
[How you approached testing]

### Coverage Analysis
| Acceptance Criterion | Test(s) | Status |
|---------------------|---------|--------|
| [Criterion 1] | test_xxx | Pass |

### Edge Cases Tested
| Edge Case | Test | Result |
|-----------|------|--------|
| Empty input | test_empty | Pass |

### Issues Found
| Issue | Severity | Reported? |
|-------|----------|-----------|
| [issue] | [low/med/high] | [yes/no] |

### Test Files Created/Modified
- [path/to/test.ts]
```

### Reviewer Journal

```markdown
# [Review Type] Review - [Feature Name]

## Progress
- **Status:** Working | Complete
- **Started:** [timestamp]
- **Verdict:** APPROVED | CHANGES_REQUESTED

## Session Info
- **Agent:** [Architect/Security/Performance] Reviewer
- **Feature:** [name]
- **Files Reviewed:** [count]

---

## Summary
[2-3 sentences: Overall assessment]

## Key Findings
- [Critical issue if any]
- [Key concern or strength]

---

## Full Detail

### Files Examined
| File | Why Examined | Assessment |
|------|--------------|------------|
| [path] | [reason] | [good/concern] |

### Implementation Context Considered
[What you learned from implementer journals]

### Findings

#### Critical (must fix)
[None or list with file:line]

#### Important (should fix)
- `path/file.ts:45` - [Issue]
  - **Problem:** [What's wrong]
  - **Impact:** [Why it matters]
  - **Suggestion:** [How to fix]

#### Minor (consider)
- [Observations]

### Strengths
[What was done well]

### Reasoning
[How you arrived at your verdict]
```

---

## Key Principles

1. **Progress header first** - Always at the top, always updated
2. **Summary is for others** - Write it so another agent can understand quickly
3. **Key findings are bullets** - Scannable, prioritized
4. **Full detail is for debugging** - Complete but not passed by default
5. **Update status immediately** - When blocked, say so; when done, say so
6. **Be specific** - File paths, line numbers, concrete examples
