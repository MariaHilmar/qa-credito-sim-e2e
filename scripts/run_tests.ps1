# Executa a suíte E2E (Robot) contra o sistema em app/
param(
    [string[]]$Tags,
    [string]$Suite = "e2e/tests/"
)

$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

$envFile = Join-Path $root ".env.local"
if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match '^\s*([^#=]+?)=(.*)$') {
            Set-Item -Path "env:$($matches[1].Trim())" -Value $matches[2].Trim()
        }
    }
}

New-Item -ItemType Directory -Force -Path (Join-Path $root "results") | Out-Null

$robotArgs = @(
    "--pythonpath", "e2e/variables",
    "--outputdir", "results",
    "--xunit", "junit.xml"
)

if ($Tags) {
    $robotArgs += "--include"
    $robotArgs += ($Tags -join "OR")
}

$robotArgs += $Suite

& "$root\.venv\Scripts\robot.exe" @robotArgs
