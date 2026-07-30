# Serve o mock HTML em http://127.0.0.1:8765 (útil para CI e Grid remoto)
# Uso: .\scripts\serve_mock.ps1
# URL: http://127.0.0.1:8765/mock/simulacao_credito.html

param(
    [int]$Port = 8765
)

$root = Split-Path -Parent $PSScriptRoot
$dataDir = Join-Path $root "data"

Write-Host "Mock QA em http://127.0.0.1:$Port/mock/simulacao_credito.html" -ForegroundColor Cyan
Write-Host "Defina: `$env:SIMULACAO_CREDITO_URL = 'http://127.0.0.1:$Port/mock/simulacao_credito.html'" -ForegroundColor Gray
Write-Host "Ctrl+C para encerrar." -ForegroundColor Gray
Write-Host ""

Set-Location $dataDir
python -m http.server $Port --bind 127.0.0.1
