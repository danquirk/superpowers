# Implementer Prompt Template

Use this template when dispatching an implementer subagent for a task.

```
Task tool (general-purpose):
  description: "Implement Task N: [task name]"
  prompt: |
    You are implementing a task as part of a parallel dev team.

    ## Your Task

    **Task [N]:** [TASK_NAME]

    **Requirement:** [Requirement from PRD this implements]

    **Depends On:** [List of completed tasks this builds on]

    ## Acceptance Criteria

    - [ ] [Criterion 1 - specific and verifiable]
    - [ ] [Criterion 2]
    - [ ] [Criterion 3]
    - [ ] Tests pass

    ## Files

    - Create: [exact paths]
    - Modify: [exact paths with line ranges if known]
    - Test: [test file paths]

    ## Steps

    [PASTE FULL STEPS FROM TASK PLAN - including code snippets and commands]

    ## Context

    **Feature:** [Feature being built]
    **Working Directory:** [WORKING_DIR]
    **Repo:** [REPO_NAME]

    **Relevant Research:**
    [Key findings from research that apply to this task]

    **Related Completed Tasks:**
    [Brief summary of what T1, T2 etc. accomplished that this builds on]

    ## Journal Requirements

    Write to: `docs/journals/[FEATURE]/04-implementation/task-[N]-implementer.md`

    ```markdown
    # Task [N] Implementation Journal - [Feature Name]

    ## Progress
    - **Status:** Working | Complete | Blocked
    - **Task:** [task name]
    - **Started:** [timestamp]
    - **Current Step:** [what you're doing]
    - **Blocked?:** No | Yes - "[question]"

    ## Session Info
    - **Agent:** Implementer
    - **Task:** [N]
    - **Repo:** [repo]

    ---

    ## Summary
    [2-3 sentences: What you implemented and key decisions]

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
    | [issue] | [how you fixed it] |

    ### Deviations from Plan
    | Planned | Actual | Reason |
    |---------|--------|--------|
    | [what plan said] | [what you did] | [why] |
    ```

    ## Instructions

    1. **Read the task carefully** - Understand what's being asked
    2. **Check dependencies** - Verify the work you depend on exists
    3. **Write journal entry** - Document your approach before coding
    4. **Implement step by step** - Follow the steps in order
    5. **Test as you go** - Run tests after each significant change
    6. **Update journal** - Document decisions and issues
    7. **Self-review** - Check your work against acceptance criteria
    8. **Commit** - Commit with clear message

    ## If You're Stuck

    - Write to journal: "Blocked: [specific question]"
    - Update Progress to show blocked status
    - STOP and wait - don't guess or proceed with uncertainty

    ## If Plan Seems Wrong

    - Don't silently deviate
    - Document why the plan doesn't work
    - Ask if the deviation is acceptable
    - If minor and obviously correct, proceed but document

    ## Output

    When complete:
    1. Ensure journal is fully written
    2. Ensure code is committed
    3. Update Progress status to "Complete"
    4. Report:
       - What you implemented
       - Files changed
       - Tests status
       - Any deviations from plan
       - Any concerns
```
