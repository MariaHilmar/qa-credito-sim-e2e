# Demonstração visual - mock local de simulação de crédito
# Chrome visível, digitação lenta, casos do test_data.json.

$env:HEADLESS = "false"
$env:SELENIUM_SPEED = "0.4"
$env:TEST_TIMEOUT = "15"

Write-Host ""
Write-Host "=== Demo: Simulacao de Credito (mock local) ===" -ForegroundColor Cyan
Write-Host "O navegador vai abrir e percorrer os dados de data/test_data.json" -ForegroundColor Gray
Write-Host ""

& "$PSScriptRoot\run_tests.ps1" -Tags financiamento -Suite tests/financiamento/elegibilidade.robot

Write-Host ""
Write-Host "Relatorios em: results/report.html" -ForegroundColor Green
