*** Settings ***
Documentation    Keywords compartilhadas entre todas as suítes de teste.
Library          Collections
Library          SeleniumLibrary
Variables        ../variables/common_variables.py

*** Keywords ***
Dado Que O Ambiente Esta Configurado
    Log    Ambiente: ${ENVIRONMENT}
    Should Not Be Empty    ${BASE_URL}

Quando Executo Uma Acao De Exemplo
    Log    Executando ação de exemplo...

Entao O Resultado Deve Ser
    [Arguments]    ${resultado_esperado}
    Should Be Equal    ${resultado_esperado}    sucesso
