---
name: virtual-dev-team
description: Master orchestration for the full virtual dev team workflow - from research through implementation and review. Use when starting a new feature or product that requires comprehensive planning and parallel implementation.
---

# Virtual Dev Team

Orchestrate a complete feature development workflow using parallel subagents - from initial research through implementation and specialist code review.

**Core principle:** Coordinate phases, ensure user checkpoints, enable pause/resume, and maximize parallel execution where safe.

## When to Use

Use this skill when:
- Starting a significant new feature or product
- Need comprehensive research before implementation
- Want parallel implementation with proper coordination
- Building across multiple repositories
- Need structured specialist code reviews

Do NOT use when:
- Simple bug fix or small change (just implement directly)
- Exploratory work without clear goal
- User already has a detailed plan (use `superpowers:parallel-dev-team` directly)

## The Workflow

```
START
  │
  ▼
RESEARCH_GATHERING ────────────► superpowers:research-gathering
  │ (user approves research)     - 4 parallel researchers
  ▼                              - Consolidator synthesizes
PRD_DEVELOPMENT ───────────────► superpowers:prd-development
  │ (user approves PRD)          - Iterative user collaboration
  ▼                              - One question at a time
TASK_DECOMPOSITION ────────────► superpowers:task-decomposition
  │ (user approves plan)         - Dependency graph
  ▼                              - Parallelization groups
IMPLEMENTATION ────────────────► superpowers:parallel-dev-team
  │ (all tasks complete)         - Parallel implementers
  ▼                              - Test engineers after each
REVIEW ────────────────────────► Specialist reviewers
  │ (all reviewers approve)      - Spec compliance (always)
  ▼                              - Architect/Security/Performance (smart selection)
COMPLETE
```

## User Checkpoints

| Checkpoint | User Action | Can Go Back? |
|------------|-------------|--------------|
| After Research | Approve / Request more research | Yes |
| After PRD | Approve / Revise PRD | Yes |
| After Plan | Approve / Adjust plan | Yes |
| During Implementation | Pause / Continue / Abort | Yes |
| After Review | Accept / Request changes | Yes |
| Final | Merge / Hold | - |

**Critical:** Never proceed past a checkpoint without explicit user approval.

## Starting a New Feature

### 1. Initialize Session

When user invokes `/dev-team` or requests a new feature:

1. **Create feature directory:**
   ```
   docs/journals/YYYY-MM-DD-<feature-slug>/
   ```

2. **Create session state file:**
   `docs/journals/<feature>/00-session-state.json`
   ```json
   {
     "feature": "<feature-name>",
     "slug": "<feature-slug>",
     "phase": "RESEARCH_GATHERING",
     "started": "<timestamp>",
     "repos": [],
     "research_doc": null,
     "prd_doc": null,
     "task_plan": null,
     "tasks": {},
     "review_round": 0,
     "review_status": null
   }
   ```

3. **Gather initial context from user:**
   - What feature/product are you building?
   - Which repos are involved?
   - Any specific constraints or requirements?
   - Relevant external documentation URLs?

### 2. Research Phase

Invoke `superpowers:research-gathering`:

1. Dispatch 4 parallel researchers:
   - Architecture Researcher
   - Dependencies Researcher
   - Features Researcher
   - External Docs Researcher

2. Wait for all to complete

3. Dispatch Research Consolidator

4. **User Checkpoint:**
   - Present research synthesis
   - Ask: "Does this capture the necessary context? Any gaps?"
   - User approves or requests more research

5. Update session state:
   ```json
   {
     "phase": "PRD_DEVELOPMENT",
     "research_doc": "docs/journals/<feature>/01-research/synthesis.md"
   }
   ```

### 3. PRD Development Phase

Invoke `superpowers:prd-development`:

1. PRD agent synthesizes research + user input
2. Iterative refinement (one question at a time)
3. Each section validated with user

4. **User Checkpoint:**
   - Present complete PRD
   - Ask: "Is this PRD ready for task planning?"
   - User approves or revises

5. Update session state:
   ```json
   {
     "phase": "TASK_DECOMPOSITION",
     "prd_doc": "docs/plans/YYYY-MM-DD-<feature>-prd.md"
   }
   ```

### 4. Task Decomposition Phase

Invoke `superpowers:task-decomposition`:

1. Break PRD into discrete tasks
2. Build dependency graph
3. Create parallelization groups
4. Define acceptance criteria per task

5. **User Checkpoint:**
   - Present task plan with dependency graph
   - Ask: "Does this plan look right? Any tasks missing or wrong?"
   - User approves or adjusts

6. Update session state:
   ```json
   {
     "phase": "IMPLEMENTATION",
     "task_plan": "docs/plans/YYYY-MM-DD-<feature>-tasks.md",
     "tasks": {
       "T1": {"status": "pending"},
       "T2": {"status": "pending"},
       ...
     }
   }
   ```

### 5. Implementation Phase

Invoke `superpowers:parallel-dev-team`:

1. Execute tasks respecting dependencies
2. Parallel implementers where safe
3. Test engineer after each implementation
4. Update task status in session state

5. **User Checkpoint (periodic):**
   - Show progress summary
   - Allow pause/continue/abort
   - Surface blocked agents for user input

6. Update session state as tasks complete:
   ```json
   {
     "tasks": {
       "T1": {"status": "complete", "commit": "abc123", "tests": "pass"},
       "T2": {"status": "complete", "commit": "def456", "tests": "pass"},
       ...
     }
   }
   ```

### 6. Review Phase

After all tasks complete:

1. **Gather change summary:**
   - Git diff from start
   - Files changed
   - All commits

2. **Smart reviewer selection:**
   | Reviewer | Invoke When |
   |----------|-------------|
   | Spec Compliance | Always |
   | Security | Auth, crypto, input handling, API code changed |
   | Performance | DB access, loops, data structures, caching changed |
   | Architect | New modules, interfaces, cross-cutting changes |

3. **Dispatch selected reviewers in parallel**

4. **Consolidate feedback:**
   - Merge findings by severity
   - Critical issues block
   - Important issues should be addressed
   - Minor issues are noted

5. **User Checkpoint:**
   - Present consolidated review
   - If changes requested: dispatch fix agents, re-review (max 3 rounds)
   - User accepts or requests more changes

6. Update session state:
   ```json
   {
     "phase": "COMPLETE",
     "review_round": 1,
     "review_status": "APPROVED"
   }
   ```

### 7. Completion

1. **Generate decision record:**
   `docs/journals/<feature>/06-decisions/decision-record.md`
   - Key decisions from all phases
   - Alternatives considered
   - Lessons learned
   - Links to source journals

2. **Final summary to user:**
   - Implementation complete
   - All tests passing
   - Reviews approved
   - Ready for merge

## Resuming a Session

When resuming (detected via hook or user request):

1. **Load session state:**
   Read `docs/journals/<feature>/00-session-state.json`

2. **Identify current phase and progress**

3. **Summarize state to user:**
   ```
   Resuming: <feature>
   Phase: <current-phase>
   Progress: <summary>

   Continue from here?
   ```

4. **Pick up from last checkpoint:**
   - If mid-phase, check agent journals for blocked status
   - Resume blocked agents with user input
   - Or restart phase if necessary

## Session State Management

### State File Location
`docs/journals/<feature>/00-session-state.json`

### State Schema
```json
{
  "feature": "string - human readable name",
  "slug": "string - URL-safe identifier",
  "phase": "RESEARCH_GATHERING | PRD_DEVELOPMENT | TASK_DECOMPOSITION | IMPLEMENTATION | REVIEW | COMPLETE",
  "started": "ISO timestamp",
  "repos": ["array of repo names involved"],
  "research_doc": "path to research synthesis or null",
  "prd_doc": "path to PRD or null",
  "task_plan": "path to task plan or null",
  "tasks": {
    "T1": {
      "status": "pending | in_progress | complete | blocked",
      "agent_id": "optional - for tracking",
      "commit": "optional - commit hash when complete",
      "tests": "optional - pass/fail"
    }
  },
  "review_round": "number - current review iteration",
  "review_status": "null | IN_PROGRESS | CHANGES_REQUESTED | APPROVED",
  "blocked_agents": ["array of blocked agent descriptions"]
}
```

## Journaling Structure

All agents write to:
```
docs/journals/<feature>/
├── 00-session-state.json           # Machine state (orchestrator owns)
├── 01-research/
│   ├── architecture.md             # Architecture researcher
│   ├── dependencies.md             # Dependencies researcher
│   ├── features.md                 # Features researcher
│   ├── external-docs.md            # Docs researcher
│   └── synthesis.md                # Consolidated research
├── 02-prd/
│   └── prd-journal.md              # PRD development decisions
├── 03-planning/
│   └── decomposition-journal.md    # Task decomposition reasoning
├── 04-implementation/
│   ├── task-1-implementer.md       # Per-task implementer journals
│   ├── task-1-test-engineer.md
│   ├── task-2-implementer.md
│   └── implementation-summary.md   # Aggregated progress
├── 05-review/
│   ├── spec-compliance.md          # Spec reviewer findings
│   ├── architect.md                # Architect reviewer findings
│   ├── security.md                 # Security reviewer findings
│   └── performance.md              # Performance reviewer findings
└── 06-decisions/
    └── decision-record.md          # Final consolidated decisions
```

## Multi-Repo Coordination

When working across repos:

1. **Track repos in session state**
2. **Assign tasks to specific repos**
3. **Per-repo commits** with cross-references:
   ```
   feat(api): add user authentication endpoint

   Related: repo-b#abc123 (frontend auth components)
   Part of: virtual-dev-team/<feature>
   ```
4. **Coordinate commit order** for dependencies

## Handling Blocked Agents

When an agent reports "Blocked":

1. Check their journal for the specific question
2. **Immediately surface to user**
3. Get user's answer
4. Resume agent with context (or dispatch new agent)
5. Update session state

**Never let blocked agents pile up silently.**

## Failure Recovery

| Failure | Detection | Recovery |
|---------|-----------|----------|
| Agent timeout | No output for extended period | Check journal, offer retry |
| Agent error | Tool/API error returned | Log details, ask user |
| Agent confused | Self-reported uncertainty | Surface question to user |
| Invalid output | Doesn't match expected format | Retry with clarification |
| Repeated failures | Same task fails 2+ times | Full context to user |
| Review loop > 3 | Counter exceeds threshold | Pause, show history to user |

## Red Flags

**Never:**
- Proceed past user checkpoint without approval
- Let blocked agents accumulate without surfacing
- Skip test engineer after implementation
- Proceed with critical review findings unaddressed
- Exceed 3 review rounds without user intervention
- Modify session state without journaling the reason

**Always:**
- Update session state after each phase transition
- Surface questions to user promptly
- Maintain traceability (requirement → task → code → test)
- Generate decision record at completion

## Integration

**Sub-skills used:**
- `superpowers:research-gathering` - Phase 1
- `superpowers:prd-development` - Phase 2
- `superpowers:task-decomposition` - Phase 3
- `superpowers:parallel-dev-team` - Phase 4
- Specialist reviewer prompts - Phase 5

**Reviewer prompts:**
- `skills/subagent-driven-development/spec-reviewer-prompt.md`
- `skills/subagent-driven-development/architect-reviewer-prompt.md`
- `skills/subagent-driven-development/security-reviewer-prompt.md`
- `skills/subagent-driven-development/performance-reviewer-prompt.md`

## Invocation

Use via `/dev-team` command or when user requests a comprehensive feature implementation with the full workflow.
