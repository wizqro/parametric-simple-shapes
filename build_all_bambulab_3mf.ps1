param(
    [string]$ModelName = "parametric_heart",
    [string]$OpenScadExe = "openscad",
    [string]$PythonExe = (Join-Path $PSScriptRoot ".venv\Scripts\python.exe"),
    [string]$ProjectRoot = $PSScriptRoot,
    [string]$ScadPath = "",
    [string]$JsonPath = "",
    [string]$OutputDir = "",
    [string]$OutPrefix = "",
    [int]$MaxPlates = 9999,
    [ValidateSet("none", "prefix")]
    [string]$GroupMode = "none"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if ($ModelName -notmatch '^[A-Za-z0-9_-]+$') {
    throw "ModelName may contain only letters, numbers, underscores, and hyphens: $ModelName"
}

$ProjectRoot = [System.IO.Path]::GetFullPath($ProjectRoot)
$artifactName = $ModelName.Replace('_', '-')

if ([string]::IsNullOrWhiteSpace($OutputDir)) {
    $OutputDir = Join-Path $ProjectRoot (Join-Path "output\stl" $ModelName)
}

if ([string]::IsNullOrWhiteSpace($OutPrefix)) {
    $model3mfDir = Join-Path $ProjectRoot (Join-Path "output\3mf" $ModelName)
    $OutPrefix = Join-Path $model3mfDir ($artifactName + "-bambu")
}

function Get-PythonCommand {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Preferred
    )

    function Test-PythonRunnable {
        param(
            [Parameter(Mandatory = $true)]
            [string]$Exe,
            [string[]]$Args = @()
        )

        try {
            & $Exe @Args "-c" "import sys"
            return ($LASTEXITCODE -eq 0)
        }
        catch {
            return $false
        }
    }

    $candidates = @()
    if ($Preferred -and $Preferred.Trim().Length -gt 0) {
        $candidates += ,@($Preferred)
    }
    $candidates += ,@(Join-Path $PSScriptRoot ".venv\Scripts\python.exe")
    $candidates += ,@("python")
    $candidates += ,@("py", "-3")

    foreach ($candidate in $candidates) {
        $exe = $candidate[0]
        $preArgs = @()
        if ($candidate.Count -gt 1) {
            $preArgs = $candidate[1..($candidate.Count - 1)]
        }

        $cmd = Get-Command $exe -ErrorAction SilentlyContinue
        if ($null -ne $cmd -and $cmd.Source -like "*\\WindowsApps\\python.exe") {
            continue
        }

        if (Test-PythonRunnable -Exe $exe -Args $preArgs) {
            return $candidate
        }
    }

    throw "No runnable Python launcher found. Install Python or pass -PythonExe with a valid executable path."
}

$renderScript = Join-Path $ProjectRoot "render_all_presets.ps1"
$buildScript = Join-Path $ProjectRoot "build_bambulab_3mf.py"

if (-not (Test-Path -LiteralPath $renderScript)) {
    throw "Missing script: $renderScript"
}

if (-not (Test-Path -LiteralPath $buildScript)) {
    throw "Missing script: $buildScript"
}

if (-not (Test-Path -LiteralPath $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

# Remove stale STLs so grouping reflects current presets only.
Get-ChildItem -LiteralPath $OutputDir -Filter "*.stl" -File -ErrorAction SilentlyContinue |
    Remove-Item -Force -ErrorAction SilentlyContinue

Write-Host "[1/2] Rendering STL files from presets..."
$renderArgs = @(
    "-ExecutionPolicy", "Bypass",
    "-File", $renderScript,
    "-ModelName", $ModelName,
    "-OpenScadExe", $OpenScadExe,
    "-ProjectRoot", $ProjectRoot,
    "-OutputDir", $OutputDir
)
if (-not [string]::IsNullOrWhiteSpace($ScadPath)) {
    $renderArgs += @("-ScadPath", $ScadPath)
}
if (-not [string]::IsNullOrWhiteSpace($JsonPath)) {
    $renderArgs += @("-JsonPath", $JsonPath)
}

& powershell @renderArgs
if ($LASTEXITCODE -ne 0) {
    throw "STL render step failed with code $LASTEXITCODE"
}

Write-Host "[2/2] Building Bambu 3MF files..."
$pythonCmd = @(Get-PythonCommand -Preferred $PythonExe)
$pythonExe = $pythonCmd[0]
$pythonArgs = @()
if ($pythonCmd.Count -gt 1) {
    $pythonArgs = $pythonCmd[1..($pythonCmd.Count - 1)]
}

& $pythonExe @pythonArgs $buildScript --model-name $ModelName --stl-dir $OutputDir --out-prefix $OutPrefix --max-plates $MaxPlates --group-mode $GroupMode
if ($LASTEXITCODE -ne 0) {
    throw "3MF build step failed with code $LASTEXITCODE"
}

Write-Host "Done"
