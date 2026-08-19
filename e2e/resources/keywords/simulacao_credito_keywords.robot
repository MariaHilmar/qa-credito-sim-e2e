*** Settings ***
Documentation    Keywords BDD (Dado / Quando / Então) da simulação de crédito.
Resource         ../pages/financiamento_page.robot

*** Keywords ***
Dado Que Estou Na Pagina De Simulacao De Credito
    Abrir Pagina De Simulacao De Credito

Quando Preencho CPF E Renda Para Simulacao
    [Arguments]    ${cpf}    ${renda}
    Preencher CPF    ${cpf}
    Preencher Renda Mensal    ${renda}

E Solicito A Simulacao De Credito
    Clicar Em Simular Credito

Entao O Resultado Da Simulacao Deve Ser
    [Arguments]    ${resultado_esperado}
    Validar Resultado Da Simulacao    ${resultado_esperado}
