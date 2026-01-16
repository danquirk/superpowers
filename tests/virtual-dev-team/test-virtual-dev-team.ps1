# Test: virtual-dev-team skill
# Verifies that the master orchestration skill is loaded correctly and describes the workflow

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\test-helpers.ps1"

Start-TestSuite "virtual-dev-team skill"

# Test 1: Verify skill can be loaded
Write-Host "Test 1: Skill loading..."
$output = Invoke-Claude "What is the virtual-dev-team skill? Describe its main purpose briefly." 60

$passed = Assert-Contains $output "virtual-dev-team" "Skill is recognized"
Add-TestResult "Skill loading" $passed
if (-not $passed) { exit 1 }

Write-Host ""

# Test 2: Verify workflow phases are described
Write-Host "Test 2: Workflow phases..."
$output = Invoke-Claude "What are the main phases in the virtual-dev-team workflow? List them in order." 60

$passed = $true
$passed = $passed -and (Assert-Contains $output "research|Research" "Mentions research phase")
$passed = $passed -and (Assert-Contains $output "PRD|requirements" "Mentions PRD phase")
$passed = $passed -and (Assert-Contains $output "task|decomposition|planning" "Mentions task decomposition")
$passed = $passed -and (Assert-Contains $output "implementation|implement" "Mentions implementation")
$passed = $passed -and (Assert-Contains $output "review" "Mentions review phase")

Add-TestResult "Workflow phases described" $passed
if (-not $passed) { exit 1 }

Write-Host ""

# Test 3: Verify user checkpoints are mentioned
Write-Host "Test 3: User checkpoints..."
$output = Invoke-Claude "Does the virtual-dev-team workflow have user checkpoints? What does the user approve?" 60

$passed = Assert-Contains $output "checkpoint|approve|approval|user" "Mentions user checkpoints"
Add-TestResult "User checkpoints" $passed
if (-not $passed) { exit 1 }

Write-Host ""

# Test 4: Verify parallel research agents
Write-Host "Test 4: Parallel research agents..."
$output = Invoke-Claude "How many researcher agents does virtual-dev-team use in the research phase? What types are they?" 60

$passed = $true
$passed = $passed -and (Assert-Contains $output "4|four" "Mentions 4 researchers")
$passed = $passed -and (Assert-Contains $output "architecture|Architecture" "Mentions architecture researcher")
$passed = $passed -and (Assert-Contains $output "dependencies|Dependencies" "Mentions dependencies researcher")

Add-TestResult "Parallel research agents" $passed
if (-not $passed) { exit 1 }

Write-Host ""

# Test 5: Verify specialist reviewers
Write-Host "Test 5: Specialist reviewers..."
$output = Invoke-Claude "What specialist code reviewers does virtual-dev-team support? List the types." 60

$passed = $true
$passed = $passed -and (Assert-Contains $output "architect|Architect" "Mentions architect reviewer")
$passed = $passed -and (Assert-Contains $output "security|Security" "Mentions security reviewer")
$passed = $passed -and (Assert-Contains $output "performance|Performance" "Mentions performance reviewer")

Add-TestResult "Specialist reviewers" $passed
if (-not $passed) { exit 1 }

Write-Host ""

# Test 6: Verify journaling is mentioned
Write-Host "Test 6: Journaling support..."
$output = Invoke-Claude "Does virtual-dev-team include journaling? Where are journals stored?" 60

$passed = $true
$passed = $passed -and (Assert-Contains $output "journal" "Mentions journals")
$passed = $passed -and (Assert-Contains $output "docs/journals|docs\\journals" "Mentions journal location")

Add-TestResult "Journaling support" $passed
if (-not $passed) { exit 1 }

Write-Host ""

# Test 7: Verify session state for pause/resume
Write-Host "Test 7: Session state management..."
$output = Invoke-Claude "Can you pause and resume a virtual-dev-team workflow? How is state tracked?" 60

$passed = $true
$passed = $passed -and (Assert-Contains $output "state|session|resume|pause" "Mentions state management")
$passed = $passed -and (Assert-Contains $output "json|JSON|session-state" "Mentions state file")

Add-TestResult "Session state management" $passed
if (-not $passed) { exit 1 }

Write-Host ""

# Test 8: Verify sub-skills are referenced
Write-Host "Test 8: Sub-skill integration..."
$output = Invoke-Claude "What other superpowers skills does virtual-dev-team use internally?" 60

$passed = $true
$passed = $passed -and (Assert-Contains $output "research-gathering" "Mentions research-gathering skill")
$passed = $passed -and (Assert-Contains $output "prd-development|PRD" "Mentions prd-development skill")
$passed = $passed -and (Assert-Contains $output "task-decomposition" "Mentions task-decomposition skill")
$passed = $passed -and (Assert-Contains $output "parallel-dev-team" "Mentions parallel-dev-team skill")

Add-TestResult "Sub-skill integration" $passed
if (-not $passed) { exit 1 }

Write-Host ""

$success = Complete-TestSuite

if ($success) {
    Write-Host "=== All virtual-dev-team skill tests passed ===" -ForegroundColor Green
    exit 0
} else {
    Write-Host "=== Some tests failed ===" -ForegroundColor Red
    exit 1
}
