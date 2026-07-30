*** Settings ***
Documentation
...    Suíte BDD de elegibilidade para Simulação de Crédito.
...    Itera sobre a massa de dados em data/test_data.json usando loop FOR.
Resource         ../../resources/pages/financiamento_page.robot
Variables        ../../data/test_data.json
Variables        ../../variables/common_variables.py
Suite Setup      Abrir Navegador    about:blank
Suite Teardown   Fechar Navegador
Test Teardown    Capturar Screenshot Em Caso De Falha

*** Test Cases ***
Caso de Teste 01: Validar Elegibilidade Da Simulacao De Credito
    [Documentation]    Executa todos os cenários de simulacao_credito definidos no JSON.
    [Tags]    web    financiamento    simulacao_credito    REQ-FIN-001
    FOR    ${caso}    IN    @{simulacao_credito}
        Set Test Documentation    ${caso}[id]: ${caso}[descricao] (${caso}[requisito])
        Log    Executando ${caso}[id] | CPF=${caso}[cpf] | Renda=${caso}[renda] | Esperado=${caso}[resultado_esperado]    console=True
        Dado Que Estou Na Pagina De Simulacao De Credito
        Quando Preencho CPF E Renda Para Simulacao    ${caso}[cpf]    ${caso}[renda]
        E Solicito A Simulacao De Credito
        Entao O Resultado Da Simulacao Deve Ser    ${caso}[resultado_esperado]
    END
