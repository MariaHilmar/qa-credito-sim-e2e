# Executa todos os testes do projeto
param(
    [string[]]$Tags,
    [string]$Suite = "tests/"
)

$envFile = Join-Path $PSScriptRoot ".env.local"
if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match '^\s*([^#=]+?)=(.*)$') {
            Set-Item -Path "env:$($matches[1].Trim())" -Value $matches[2].Trim()
        }
    }
}

New-Item -ItemType Directory -Force -Path (Join-Path $PSScriptRoot "results") | Out-Null

$robotArgs = @(
    "--pythonpath", "libraries",
    "--pythonpath", "variables",
    "--outputdir", "results",
    "--xunit", "results/junit.xml"
)

if ($Tags) {
    $robotArgs += "--include"
    $robotArgs += ($Tags -join "OR")
}

$robotArgs += $Suite

& "$PSScriptRoot\.venv\Scripts\robot.exe" @robotArgs
