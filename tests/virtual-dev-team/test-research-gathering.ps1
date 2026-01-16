# Test: research-gathering skill
# Verifies that the research gathering skill is loaded correctly

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\test-helpers.ps1"

Start-TestSuite "research-gathering skill"

# Test 1: Verify skill can be loaded
Write-Host "Test 1: Skill loading..."
$output = Invoke-Claude "What is the research-gathering skill? Describe its purpose briefly." 60

$passed = Assert-Contains $output "research" "Skill is recognized"
Add-TestResult "Skill loading" $passed
if (-not $passed) { exit 1 }

Write-Host ""

# Test 2: Verify 4 researcher types
Write-Host "Test 2: Researcher types..."
$output = Invoke-Claude "What are the 4 types of researchers in the research-gathering skill?" 60

$passed = $true
$passed = $passed -and (Assert-Contains $output "architecture|Architecture" "Mentions architecture researcher")
$passed = $passed -and (Assert-Contains $output "dependencies|Dependencies" "Mentions dependencies researcher")
$passed = $passed -and (Assert-Contains $output "features|Features" "Mentions features researcher")
$passed = $passed -and (Assert-Contains $output "docs|documentation|external" "Mentions docs researcher")

Add-TestResult "Four researcher types" $passed
if (-not $passed) { exit 1 }

Write-Host ""

# Test 3: Verify parallel execution
Write-Host "Test 3: Parallel execution..."
$output = Invoke-Claude "Are the researchers in research-gathering dispatched in parallel or sequentially?" 60

$passed = Assert-Contains $output "parallel" "Mentions parallel execution"
Add-TestResult "Parallel execution" $passed
if (-not $passed) { exit 1 }

Write-Host ""

# Test 4: Verify consolidation step
Write-Host "Test 4: Research consolidation..."
$output = Invoke-Claude "What happens after all researchers complete in research-gathering? Is there a consolidation step?" 60

$passed = $true
$passed = $passed -and (Assert-Contains $output "consolidat|synthesiz|combin" "Mentions consolidation")

Add-TestResult "Research consolidation" $passed
if (-not $passed) { exit 1 }

Write-Host ""

# Test 5: Verify journaling
Write-Host "Test 5: Research journaling..."
$output = Invoke-Claude "Do researchers in research-gathering write journals? Where?" 60

$passed = $true
$passed = $passed -and (Assert-Contains $output "journal" "Mentions journals")
$passed = $passed -and (Assert-Contains $output "01-research" "Mentions research directory")

Add-TestResult "Research journaling" $passed
if (-not $passed) { exit 1 }

Write-Host ""

$success = Complete-TestSuite

if ($success) {
    Write-Host "=== All research-gathering skill tests passed ===" -ForegroundColor Green
    exit 0
} else {
    Write-Host "=== Some tests failed ===" -ForegroundColor Red
    exit 1
}
