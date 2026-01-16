# Virtual Dev Team Skill Tests

PowerShell tests for the virtual-dev-team workflow and related skills.

## Overview

This test suite verifies that virtual-dev-team skills are loaded correctly and Claude follows them as expected. Tests invoke Claude Code in headless mode (`claude -p`) and verify the behavior.

## Requirements

- Claude Code CLI installed and in PATH (`claude --version` should work)
- Local superpowers plugin installed (see main README for installation)
- PowerShell 5.1+ (Windows) or PowerShell Core 7+ (cross-platform)

## Running Tests

### Run all tests:
```powershell
.\run-tests.ps1
```

### Run specific test:
```powershell
.\run-tests.ps1 -Test "virtual-dev-team"
```

### Run with verbose output:
```powershell
.\run-tests.ps1 -VerboseOutput
```

## Test Files

### test-helpers.ps1
Common functions for skills testing:
- `Invoke-Claude "prompt" [timeout]` - Run Claude with prompt
- `Assert-Contains $output "pattern" "name"` - Verify pattern exists
- `Assert-NotContains $output "pattern" "name"` - Verify pattern absent
- `Assert-Order $output "patternA" "patternB" "name"` - Verify order
- `New-TestProject` - Create temp test directory
- `Remove-TestProject` - Clean up test directory

### test-virtual-dev-team.ps1
Tests for the master orchestration skill:
- Skill loading and recognition
- Workflow phases described correctly
- User checkpoints mentioned
- Parallel research agents
- Specialist reviewers
- Journaling support
- Session state management
- Sub-skill integration

### test-research-gathering.ps1
Tests for the research gathering skill:
- Skill loading
- Four researcher types described
- Parallel execution mentioned
- Consolidation step
- Research journaling

## Adding New Tests

1. Create new test file: `test-<skill-name>.ps1`
2. Source test-helpers.ps1 at the start
3. Use `Start-TestSuite` and `Complete-TestSuite`
4. Write tests using `Invoke-Claude` and assertions
5. Call `Add-TestResult` for each test

## Example Test

```powershell
$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\test-helpers.ps1"

Start-TestSuite "my-skill"

Write-Host "Test 1: Skill loading..."
$output = Invoke-Claude "What is the my-skill skill?" 60

$passed = Assert-Contains $output "my-skill" "Skill is recognized"
Add-TestResult "Skill loading" $passed

$success = Complete-TestSuite
exit $(if ($success) { 0 } else { 1 })
```

## Notes

- Tests verify skill *instructions*, not full execution
- Full workflow execution tests would be very slow (10-30+ minutes)
- Focus on verifying key skill requirements
- Tests should be deterministic
- Avoid testing implementation details
