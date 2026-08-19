# Serve o sistema (app/) em http://127.0.0.1:8765
# Uso: .\scripts\serve_app.ps1
# URL: http://127.0.0.1:8765/simulacao_credito.html

param(
    [int]$Port = 8765
)

$root = Split-Path -Parent $PSScriptRoot
$appDir = Join-Path $root "app"

Write-Host "Sistema em http://127.0.0.1:$Port/simulacao_credito.html" -ForegroundColor Cyan
Write-Host "Defina: `$env:SIMULACAO_CREDITO_URL = 'http://127.0.0.1:$Port/simulacao_credito.html'" -ForegroundColor Gray
Write-Host "Ctrl+C para encerrar." -ForegroundColor Gray
Write-Host ""

Set-Location $appDir
python -m http.server $Port --bind 127.0.0.1
