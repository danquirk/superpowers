# Run all virtual-dev-team skill tests
# Usage: .\run-tests.ps1 [-Test <name>] [-Verbose]

param(
    [string]$Test = "",
    [switch]$VerboseOutput
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Track results
$totalTests = 0
$passedTests = 0
$failedTests = @()

Write-Host ""
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host "  Virtual Dev Team Skill Tests" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host ""

# Get test files
$testFiles = Get-ChildItem -Path $ScriptDir -Filter "test-*.ps1" | Where-Object { $_.Name -ne "test-helpers.ps1" }

if ($Test) {
    $testFiles = $testFiles | Where-Object { $_.Name -like "*$Test*" }
    if ($testFiles.Count -eq 0) {
        Write-Host "No tests found matching: $Test" -ForegroundColor Red
        exit 1
    }
}

Write-Host "Found $($testFiles.Count) test file(s):" -ForegroundColor Gray
foreach ($file in $testFiles) {
    Write-Host "  - $($file.Name)" -ForegroundColor Gray
}
Write-Host ""

# Run each test
foreach ($testFile in $testFiles) {
    $totalTests++
    Write-Host "Running: $($testFile.Name)..." -ForegroundColor Yellow
    Write-Host ""

    try {
        $result = & $testFile.FullName

        if ($LASTEXITCODE -eq 0) {
            $passedTests++
            Write-Host "PASSED: $($testFile.Name)" -ForegroundColor Green
        } else {
            $failedTests += $testFile.Name
            Write-Host "FAILED: $($testFile.Name)" -ForegroundColor Red
        }
    } catch {
        $failedTests += $testFile.Name
        Write-Host "ERROR: $($testFile.Name) - $($_.Exception.Message)" -ForegroundColor Red
    }

    Write-Host ""
    Write-Host "---" -ForegroundColor Gray
    Write-Host ""
}

# Summary
Write-Host ""
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host "  Test Summary" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Total:  $totalTests" -ForegroundColor White
Write-Host "Passed: $passedTests" -ForegroundColor Green
Write-Host "Failed: $($failedTests.Count)" -ForegroundColor $(if ($failedTests.Count -gt 0) { "Red" } else { "Green" })

if ($failedTests.Count -gt 0) {
    Write-Host ""
    Write-Host "Failed tests:" -ForegroundColor Red
    foreach ($failed in $failedTests) {
        Write-Host "  - $failed" -ForegroundColor Red
    }
    Write-Host ""
    exit 1
}

Write-Host ""
Write-Host "All tests passed!" -ForegroundColor Green
Write-Host ""
exit 0
