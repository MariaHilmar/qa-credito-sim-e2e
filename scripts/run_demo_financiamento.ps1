# Demonstração visual: sobe o sistema (app/) via file:// e roda o E2E com Chrome visível.

$env:HEADLESS = "false"
$env:SELENIUM_SPEED = "0.4"
$env:TEST_TIMEOUT = "15"

Write-Host ""
Write-Host "=== Demo: Simulacao de Credito ===" -ForegroundColor Cyan
Write-Host "Sistema: app/simulacao_credito.html | Automacao: e2e/" -ForegroundColor Gray
Write-Host ""

& "$PSScriptRoot\run_tests.ps1" -Tags financiamento -Suite e2e/tests/financiamento/elegibilidade.robot

Write-Host ""
Write-Host "Relatorios em: results/report.html" -ForegroundColor Green
