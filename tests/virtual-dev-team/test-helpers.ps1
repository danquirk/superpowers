# Test helpers for virtual-dev-team skill tests
# PowerShell equivalent of test-helpers.sh

$ErrorActionPreference = "Stop"

# Run Claude Code with a prompt
function Invoke-Claude {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Prompt,

        [int]$TimeoutSeconds = 300
    )

    $process = Start-Process -FilePath "claude" `
        -ArgumentList "-p", "`"$Prompt`"", "--allowedTools", "Read,Glob,Grep" `
        -NoNewWindow -PassThru -Wait -RedirectStandardOutput "claude_output.txt" -RedirectStandardError "claude_error.txt"

    if ($process.ExitCode -ne 0) {
        $error = Get-Content "claude_error.txt" -Raw -ErrorAction SilentlyContinue
        Write-Warning "Claude exited with code $($process.ExitCode): $error"
    }

    $output = Get-Content "claude_output.txt" -Raw -ErrorAction SilentlyContinue
    Remove-Item "claude_output.txt", "claude_error.txt" -ErrorAction SilentlyContinue

    return $output
}

# Assert output contains pattern
function Assert-Contains {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Output,

        [Parameter(Mandatory=$true)]
        [string]$Pattern,

        [Parameter(Mandatory=$true)]
        [string]$TestName
    )

    if ($Output -match $Pattern) {
        Write-Host "  PASS: $TestName" -ForegroundColor Green
        return $true
    } else {
        Write-Host "  FAIL: $TestName" -ForegroundColor Red
        Write-Host "    Expected pattern: $Pattern" -ForegroundColor Yellow
        Write-Host "    Output was: $($Output.Substring(0, [Math]::Min(500, $Output.Length)))..." -ForegroundColor Gray
        return $false
    }
}

# Assert output does not contain pattern
function Assert-NotContains {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Output,

        [Parameter(Mandatory=$true)]
        [string]$Pattern,

        [Parameter(Mandatory=$true)]
        [string]$TestName
    )

    if ($Output -notmatch $Pattern) {
        Write-Host "  PASS: $TestName" -ForegroundColor Green
        return $true
    } else {
        Write-Host "  FAIL: $TestName" -ForegroundColor Red
        Write-Host "    Did not expect pattern: $Pattern" -ForegroundColor Yellow
        return $false
    }
}

# Assert pattern A appears before pattern B
function Assert-Order {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Output,

        [Parameter(Mandatory=$true)]
        [string]$PatternA,

        [Parameter(Mandatory=$true)]
        [string]$PatternB,

        [Parameter(Mandatory=$true)]
        [string]$TestName
    )

    $matchA = [regex]::Match($Output, $PatternA, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    $matchB = [regex]::Match($Output, $PatternB, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

    if (-not $matchA.Success) {
        Write-Host "  FAIL: $TestName - Pattern A not found: $PatternA" -ForegroundColor Red
        return $false
    }

    if (-not $matchB.Success) {
        Write-Host "  FAIL: $TestName - Pattern B not found: $PatternB" -ForegroundColor Red
        return $false
    }

    if ($matchA.Index -lt $matchB.Index) {
        Write-Host "  PASS: $TestName" -ForegroundColor Green
        return $true
    } else {
        Write-Host "  FAIL: $TestName - Wrong order" -ForegroundColor Red
        Write-Host "    Expected '$PatternA' before '$PatternB'" -ForegroundColor Yellow
        return $false
    }
}

# Create a temporary test project directory
function New-TestProject {
    $tempDir = Join-Path $env:TEMP "vdt-test-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

    # Initialize git repo
    Push-Location $tempDir
    git init --quiet
    git config user.email "test@test.com"
    git config user.name "Test User"
    Pop-Location

    return $tempDir
}

# Clean up test project
function Remove-TestProject {
    param([string]$ProjectDir)

    if (Test-Path $ProjectDir) {
        Remove-Item -Recurse -Force $ProjectDir -ErrorAction SilentlyContinue
    }
}

# Run a test suite and track results
$script:TestResults = @{
    Passed = 0
    Failed = 0
    Tests = @()
}

function Start-TestSuite {
    param([string]$Name)

    Write-Host ""
    Write-Host "=== Test Suite: $Name ===" -ForegroundColor Cyan
    Write-Host ""

    $script:TestResults = @{
        Passed = 0
        Failed = 0
        Tests = @()
    }
}

function Complete-TestSuite {
    Write-Host ""
    Write-Host "=== Results ===" -ForegroundColor Cyan
    Write-Host "Passed: $($script:TestResults.Passed)" -ForegroundColor Green
    Write-Host "Failed: $($script:TestResults.Failed)" -ForegroundColor $(if ($script:TestResults.Failed -gt 0) { "Red" } else { "Green" })
    Write-Host ""

    return $script:TestResults.Failed -eq 0
}

function Add-TestResult {
    param(
        [string]$TestName,
        [bool]$Passed
    )

    $script:TestResults.Tests += @{
        Name = $TestName
        Passed = $Passed
    }

    if ($Passed) {
        $script:TestResults.Passed++
    } else {
        $script:TestResults.Failed++
    }
}

Export-ModuleMember -Function *
