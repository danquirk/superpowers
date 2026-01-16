---
name: parallel-dev-team
description: Use to execute a task plan with maximum parallelization, dispatching implementer agents for ready tasks and test engineers after each implementation
---

# Parallel Dev Team

Execute a task plan with maximum parallelization while respecting dependencies, spawning test engineers after each implementation and specialist reviewers at checkpoints.

**Core principle:** Parallel where possible + sequential where required + continuous testing = fast, reliable implementation

## When to Use

Use this skill when:
- Task plan is approved and ready for execution
- Tasks have clear dependencies and parallelization groups
- Want to maximize implementation speed with parallel agents
- Need coordinated implementation across tasks/repos

Do NOT use when:
- Task plan isn't finalized (use `superpowers:task-decomposition` first)
- Single simple task (just implement directly)
- Exploratory or uncertain work

## Prerequisites

Before starting parallel implementation:
1. Task plan exists and is approved
2. Dependency graph is defined
3. Parallelization groups are identified
4. Journal directory exists: `docs/journals/YYYY-MM-DD-<feature>/`

## The Process

```
1. Load task plan
2. Parse dependency graph and parallelization groups
3. Initialize session state
4. For each parallelization group (in order):
   a. Identify ready tasks (dependencies met)
   b. Dispatch implementer agents in parallel
   c. For each completed implementation:
      - Dispatch test engineer agent
      - Update progress
   d. Wait for all in group to complete
   e. Run checkpoint review if configured
5. After all tasks complete:
   - Dispatch specialist reviewers
   - Consolidate feedback
   - Loop back if changes needed
6. Mark implementation complete
```

## Execution Flow

```
Group 1 (sequential - foundation)
    │
    ├─ Dispatch Implementer for T1
    ├─ T1 completes → Dispatch Test Engineer
    ├─ Test Engineer completes
    │
    ▼
Group 2 (parallel)
    │
    ├─ Dispatch Implementer for T2 ─┬─ T2 completes → Test Engineer
    ├─ Dispatch Implementer for T3 ─┴─ T3 completes → Test Engineer
    │  (running in parallel)
    │
    ▼ (wait for all in group)
Group 3 (sequential)
    │
    ├─ Dispatch Implementer for T4
    ├─ T4 completes → Dispatch Test Engineer
    │
    ▼
Review Phase
    │
    ├─ Dispatch Spec Compliance Reviewer (always)
    ├─ Dispatch relevant specialist reviewers (smart selection)
    │  (running in parallel)
    │
    ▼
    Consolidate feedback
    │
    ├─ All approved → Complete
    └─ Changes needed → Dispatch fix agents → Re-review
```

## Dispatching Implementers

Use the Task tool to dispatch implementers. Provide FULL task context (don't make them read files).

```
Task tool (general-purpose):
  description: "Implement Task N: [task name]"
  prompt: [Full content of ./implementer-prompt.md with task details filled in]
```

**Dispatch in parallel** for tasks in same group:
- Send multiple Task tool calls in single message
- All run concurrently
- Collect results as they complete

## Dispatching Test Engineers

After each implementation completes, dispatch test engineer:

```
Task tool (general-purpose):
  description: "Write tests for Task N: [task name]"
  prompt: [Full content of ./test-engineer-prompt.md with implementation details]
```

## Smart Reviewer Selection

After implementation, determine which reviewers to invoke:

| Reviewer | Invoke When |
|----------|-------------|
| Spec Compliance | Always |
| Security | Auth, crypto, input handling, API code changed |
| Performance | DB access, loops, data structures, caching changed |
| Architect | New modules, interfaces, cross-cutting changes |

Use file paths and change types to determine relevance.

## Session State Management

Track progress in: `docs/journals/<feature>/00-session-state.json`

```json
{
  "feature": "feature-name",
  "phase": "IMPLEMENTATION",
  "current_group": 2,
  "tasks": {
    "T1": {"status": "complete", "commit": "abc123", "tests": "pass"},
    "T2": {"status": "in_progress", "agent_id": "xyz"},
    "T3": {"status": "in_progress", "agent_id": "abc"},
    "T4": {"status": "pending"},
    "T5": {"status": "pending"}
  },
  "review_round": 0,
  "blocked_agents": []
}
```

## Journaling Requirements

**Implementation summary:** `docs/journals/<feature>/04-implementation/implementation-summary.md`

Update after each task completes:

```markdown
# Implementation Summary - [Feature Name]

## Progress
- **Phase:** IMPLEMENTATION
- **Group:** 2 of 4
- **Tasks:** 3/8 complete
- **Status:** In Progress

## Completed Tasks

| Task | Implementer | Tests | Commit | Duration |
|------|-------------|-------|--------|----------|
| T1 | Complete | Pass | abc123 | 5m |
| T2 | Complete | Pass | def456 | 8m |

## In Progress

| Task | Agent | Started | Current Step |
|------|-------|---------|--------------|
| T3 | impl-3 | 14:30 | Writing tests |
| T4 | impl-4 | 14:32 | Implementing |

## Blocked

| Task | Agent | Issue | Since |
|------|-------|-------|-------|
| (none) | | | |

## Queue

| Task | Waiting On | Group |
|------|------------|-------|
| T5 | T3, T4 | 3 |

## Decisions Made

| Task | Decision | Rationale |
|------|----------|-----------|
| T2 | Used existing auth module | Matches patterns, less code |

## Issues Encountered

| Task | Issue | Resolution |
|------|-------|------------|
| T1 | Missing type definition | Added to shared types |
```

## Handling Blocked Agents

When an implementer reports "Blocked":

1. Check their journal for the question
2. Surface to user immediately
3. User provides answer
4. Resume the agent with the answer (or dispatch new agent with context)

## Review Orchestration

After all tasks complete:

1. **Gather changes:**
   - Git diff from start of implementation
   - List of files changed
   - List of commits

2. **Select reviewers:**
   - Spec Compliance: always
   - Security: if security-relevant files changed
   - Performance: if performance-relevant files changed
   - Architect: if architectural changes made

3. **Dispatch reviewers in parallel:**
   ```
   Task tool: Spec Compliance Review
   Task tool: Security Review (if selected)
   Task tool: Performance Review (if selected)
   Task tool: Architect Review (if selected)
   ```

4. **Consolidate feedback:**
   - Merge all findings
   - Categorize by severity
   - Present to user

5. **Handle changes requested:**
   - Dispatch fix agents for critical/important issues
   - Re-run relevant reviewers
   - Max 3 review rounds, then escalate to user

## Multi-Repo Coordination

When tasks span repos:
- Track which repo each task affects
- Coordinate commits (commit to each repo separately)
- Include cross-references in commit messages
- Consider repo-level parallelization

## Red Flags

**Never:**
- Dispatch tasks before dependencies complete
- Skip test engineer after implementation
- Proceed past review with critical issues
- Dispatch more than one implementer for same task
- Let review loops exceed 3 rounds without user input

**If agent stuck:**
- Surface immediately to user
- Don't let blocked agents pile up
- Provide context when resuming

## Output

**Implementation artifacts:**
- Code changes committed
- Tests written and passing
- Journals documenting all decisions
- Review feedback addressed

**After implementation approved:**
- "Implementation complete. All tasks done, tests passing, reviews approved."
- Proceed to finishing workflow

## Prompt Templates

- `./implementer-prompt.md` - Dispatch task implementer
- `./test-engineer-prompt.md` - Dispatch test writer

## Integration

**Requires:** `superpowers:task-decomposition` (task plan must exist)

**Uses:**
- `skills/subagent-driven-development/spec-reviewer-prompt.md`
- `skills/subagent-driven-development/architect-reviewer-prompt.md`
- `skills/subagent-driven-development/security-reviewer-prompt.md`
- `skills/subagent-driven-development/performance-reviewer-prompt.md`

**Part of:** `superpowers:virtual-dev-team` workflow
