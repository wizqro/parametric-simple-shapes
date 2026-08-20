param(
    [string]$ModelName = "parametric_heart",
    [string]$OpenScadExe = "openscad",
    [string]$ProjectRoot = $PSScriptRoot,
    [string]$ScadPath = "",
    [string]$JsonPath = "",
    [string]$OutputDir = ""
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-AbsolutePath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$BasePath,
        [Parameter(Mandatory = $true)]
        [string]$InputPath
    )

    if ([System.IO.Path]::IsPathRooted($InputPath)) {
        return [System.IO.Path]::GetFullPath($InputPath)
    }

    return [System.IO.Path]::GetFullPath((Join-Path $BasePath $InputPath))
}

if ($ModelName -notmatch '^[A-Za-z0-9_-]+$') {
    throw "ModelName may contain only letters, numbers, underscores, and hyphens: $ModelName"
}

$resolvedProjectRoot = Resolve-AbsolutePath -BasePath (Get-Location).Path -InputPath $ProjectRoot

if ([string]::IsNullOrWhiteSpace($ScadPath)) {
    $ScadPath = Join-Path "scad" ($ModelName + ".scad")
}

if ([string]::IsNullOrWhiteSpace($JsonPath)) {
    $JsonPath = Join-Path "presets" ($ModelName + ".json")
}

if ([string]::IsNullOrWhiteSpace($OutputDir)) {
    $OutputDir = Join-Path "output\stl" $ModelName
}

$resolvedJsonPath = Resolve-AbsolutePath -BasePath $resolvedProjectRoot -InputPath $JsonPath
$resolvedScadPath = Resolve-AbsolutePath -BasePath $resolvedProjectRoot -InputPath $ScadPath
$resolvedOutputDir = Resolve-AbsolutePath -BasePath $resolvedProjectRoot -InputPath $OutputDir

if (-not (Test-Path -LiteralPath $resolvedJsonPath)) {
    throw "JSON file not found: $resolvedJsonPath"
}

if (-not (Test-Path -LiteralPath $resolvedScadPath)) {
    throw "SCAD file not found: $resolvedScadPath"
}

if (-not (Test-Path -LiteralPath $resolvedOutputDir)) {
    New-Item -ItemType Directory -Path $resolvedOutputDir | Out-Null
}

function ConvertTo-OpenScadLiteral {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Value
    )

    if ($Value -match '^(?i:true|false)$') {
        return $Value.ToLowerInvariant()
    }

    if ($Value -match '^-?(?:\d+\.?\d*|\.\d+)(?:[eE][+\-]?\d+)?$') {
        return $Value
    }

    $escaped = $Value.Replace('\\', '\\\\').Replace('"', '\\"')
    return '\"' + $escaped + '\"'
}

$jsonRaw = Get-Content -LiteralPath $resolvedJsonPath -Raw
$config = $jsonRaw | ConvertFrom-Json

if (-not $config.parameterSets) {
    throw "No parameterSets found in: $resolvedJsonPath"
}

$presets = @($config.parameterSets.PSObject.Properties)
if ($presets.Count -eq 0) {
    throw "parameterSets is empty in: $resolvedJsonPath"
}

$success = 0
$failed = 0
$total = $presets.Count

Write-Host "OpenSCAD preset batch export started"
Write-Host "Model  : $ModelName"
Write-Host "Presets: $total"
Write-Host "SCAD   : $resolvedScadPath"
Write-Host "JSON   : $resolvedJsonPath"
Write-Host "Output : $resolvedOutputDir"
Write-Host ""

foreach ($presetProp in $presets) {
    $presetName = $presetProp.Name
    $preset = $presetProp.Value

    $safeName = ($presetName -replace '[<>:"/\\|?*]', '_')
    $outputPath = Join-Path $resolvedOutputDir ($safeName + ".stl")

    $args = @("-o", $outputPath)

    foreach ($paramProp in $preset.PSObject.Properties) {
        $key = $paramProp.Name
        $rawValue = [string]$paramProp.Value
        $literal = ConvertTo-OpenScadLiteral -Value $rawValue
        $args += @("-D", "$key=$literal")
    }

    $args += $resolvedScadPath

    Write-Host ("[{0}/{1}] Rendering: {2}" -f ($success + $failed + 1), $total, $presetName)

    try {
        & $OpenScadExe @args
        if ($LASTEXITCODE -ne 0) {
            throw "OpenSCAD exited with code $LASTEXITCODE"
        }

        $success++
        Write-Host ("  OK  -> {0}" -f $outputPath)
    }
    catch {
        $failed++
        Write-Warning ("  NG  -> {0}" -f $presetName)
        Write-Warning ("        {0}" -f $_.Exception.Message)
    }
}

Write-Host ""
Write-Host "Completed"
Write-Host ("Success: {0}" -f $success)
Write-Host ("Failed : {0}" -f $failed)

if ($failed -gt 0) {
    exit 1
}
