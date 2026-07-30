# Demonstração visual - Simulação de Crédito (mock Caixa)
# Abre o Chrome visível, digita devagar e percorre todos os cenários do JSON.

$env:HEADLESS = "false"
$env:SELENIUM_SPEED = "0.4"
$env:TEST_TIMEOUT = "15"

Write-Host ""
Write-Host "=== Demo: Simulacao de Credito (Mock Caixa) ===" -ForegroundColor Cyan
Write-Host "O navegador vai abrir e preencher os dados do test_data.json" -ForegroundColor Gray
Write-Host ""

& "$PSScriptRoot\run_tests.ps1" -Tags financiamento -Suite tests/financiamento/elegibilidade.robot

Write-Host ""
Write-Host "Relatorios em: results/report.html" -ForegroundColor Green
