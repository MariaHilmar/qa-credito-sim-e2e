*** Settings ***
Documentation    Page Object da tela de simulação de crédito (locators e ações).
Resource         ../selenium/browser.robot
Library          Collections
Variables        ../../variables/financiamento_variables.py

*** Variables ***
${INPUT_CPF}                  id=cpf
${INPUT_RENDA}                id=renda-mensal
${BOTAO_SIMULAR}              css=[data-testid="btn-simular"]
${RESULTADO_ELEGIBILIDADE}    css=[data-testid="resultado-simulacao"]

&{MENSAGENS_ESPERADAS}
...    aprovado=Parabéns! Você está elegível para simulação de crédito.
...    negado_renda=Renda insuficiente para o produto selecionado.
...    negado_cpf=CPF inválido ou não encontrado.
...    campo_cpf_vazio=Informe o CPF.
...    campo_renda_vazio=Informe a renda mensal.

*** Keywords ***
Abrir Pagina De Simulacao De Credito
    [Documentation]    Navega até a tela de simulação de crédito.
    Go To    ${SIMULACAO_CREDITO_URL}
    Wait Until Element Is Visible    ${INPUT_CPF}
    Wait Until Element Is Visible    ${INPUT_RENDA}
    Wait Until Element Is Visible    ${BOTAO_SIMULAR}

Preencher CPF
    [Arguments]    ${cpf}
    Wait Until Element Is Visible    ${INPUT_CPF}
    Clear Element Text    ${INPUT_CPF}
    IF    """${cpf}""" != """"""
        Input Text    ${INPUT_CPF}    ${cpf}
    END

Preencher Renda Mensal
    [Arguments]    ${renda}
    Wait Until Element Is Visible    ${INPUT_RENDA}
    Clear Element Text    ${INPUT_RENDA}
    IF    """${renda}""" != """"""
        Input Text    ${INPUT_RENDA}    ${renda}
    END

Clicar Em Simular Credito
    Wait Until Element Is Visible    ${BOTAO_SIMULAR}
    Click Element    ${BOTAO_SIMULAR}

Validar Resultado Da Simulacao
    [Arguments]    ${resultado_esperado}
    Dictionary Should Contain Key    ${MENSAGENS_ESPERADAS}    ${resultado_esperado}
    ${mensagem}=    Get From Dictionary    ${MENSAGENS_ESPERADAS}    ${resultado_esperado}
    Wait Until Element Is Visible    ${RESULTADO_ELEGIBILIDADE}
    Wait Until Page Contains Element    ${RESULTADO_ELEGIBILIDADE}
    Element Text Should Be    ${RESULTADO_ELEGIBILIDADE}    ${mensagem}

Limpar Formulario De Simulacao
    [Documentation]    Reseta o formulário entre iterações do loop de dados.
    Reload Page
    Wait Until Element Is Visible    ${INPUT_CPF}
