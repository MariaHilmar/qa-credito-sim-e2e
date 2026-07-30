*** Settings ***
Documentation    Exemplo de suíte de teste. Use como referência para novos testes.
Resource         ../../resources/common.robot
Variables        ../../variables/common_variables.py
Test Setup       Setup Teste
Test Teardown    Teardown Teste

*** Test Cases ***
Exemplo De Teste Basico
    [Documentation]    Valida que a estrutura do projeto está funcional.
    [Tags]    smoke    exemplo
    Dado Que O Ambiente Esta Configurado
    Quando Executo Uma Acao De Exemplo
    Entao O Resultado Deve Ser    sucesso

*** Keywords ***
Setup Teste
    Log    Iniciando teste: ${TEST NAME}

Teardown Teste
    Log    Finalizando teste: ${TEST NAME}
