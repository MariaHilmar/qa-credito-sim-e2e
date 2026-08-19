*** Settings ***
Documentation
...    Suíte BDD de elegibilidade para Simulação de Crédito.
...    Um caso de teste por cenário (CT-FIN-*) com massa em e2e/data/test_data.json.
Resource         ../../resources/keywords/simulacao_credito_keywords.robot
Variables        ../../data/test_data.json
Variables        ../../variables/common_variables.py
Suite Setup      Abrir Navegador    about:blank
Suite Teardown   Fechar Navegador
Test Teardown    Capturar Screenshot Em Caso De Falha

*** Test Cases ***
CT-FIN-001 Renda Acima Do Minimo Deve Ser Elegivel
    [Documentation]    Cliente com renda acima do mínimo deve ser elegível (REQ-FIN-001).
    [Tags]    web    financiamento    simulacao_credito    REQ-FIN-001
    Executar Cenario De Simulacao    CT-FIN-001

CT-FIN-002 Renda Abaixo Do Minimo Deve Ser Negado
    [Documentation]    Cliente com renda abaixo do mínimo deve ser negado (REQ-FIN-001).
    [Tags]    web    financiamento    simulacao_credito    REQ-FIN-001
    Executar Cenario De Simulacao    CT-FIN-002

CT-FIN-003 CPF Invalido Deve Impedir Simulacao
    [Documentation]    CPF inválido deve impedir a simulação (REQ-FIN-002).
    [Tags]    web    financiamento    simulacao_credito    REQ-FIN-002
    Executar Cenario De Simulacao    CT-FIN-003

CT-FIN-004 Renda No Limite Deve Ser Elegivel
    [Documentation]    Cliente com renda exatamente no limite deve ser elegível (REQ-FIN-001).
    [Tags]    web    financiamento    simulacao_credito    REQ-FIN-001
    Executar Cenario De Simulacao    CT-FIN-004

CT-FIN-005 Renda Um Centavo Abaixo Do Limite Deve Ser Negado
    [Documentation]    Cliente com renda um centavo abaixo do limite deve ser negado (REQ-FIN-003).
    [Tags]    web    financiamento    simulacao_credito    REQ-FIN-003
    Executar Cenario De Simulacao    CT-FIN-005

CT-FIN-006 CPF Vazio Deve Pedir Preenchimento
    [Documentation]    CPF em branco deve pedir preenchimento (REQ-FIN-004).
    [Tags]    web    financiamento    simulacao_credito    REQ-FIN-004
    Executar Cenario De Simulacao    CT-FIN-006

CT-FIN-007 Renda Vazia Deve Pedir Preenchimento
    [Documentation]    Renda em branco deve pedir preenchimento (REQ-FIN-004).
    [Tags]    web    financiamento    simulacao_credito    REQ-FIN-004
    Executar Cenario De Simulacao    CT-FIN-007

CT-FIN-008 Renda No Formato Brasileiro No Limite Deve Ser Elegivel
    [Documentation]    Renda 3.000,00 (formato BR) no limite deve ser elegível (REQ-FIN-001).
    [Tags]    web    financiamento    simulacao_credito    REQ-FIN-001
    Executar Cenario De Simulacao    CT-FIN-008

*** Keywords ***
Obter Caso Por Id
    [Arguments]    ${id}
    FOR    ${caso}    IN    @{simulacao_credito}
        IF    '${caso}[id]' == '${id}'
            RETURN    ${caso}
        END
    END
    Fail    Caso de teste '${id}' nao encontrado em e2e/data/test_data.json

Executar Cenario De Simulacao
    [Arguments]    ${id}
    ${caso}=    Obter Caso Por Id    ${id}
    Log    ${caso}[id]: ${caso}[descricao] (${caso}[requisito]) | CPF=${caso}[cpf] | Renda=${caso}[renda]    console=True
    Dado Que Estou Na Pagina De Simulacao De Credito
    Quando Preencho CPF E Renda Para Simulacao    ${caso}[cpf]    ${caso}[renda]
    E Solicito A Simulacao De Credito
    Entao O Resultado Da Simulacao Deve Ser    ${caso}[resultado_esperado]
