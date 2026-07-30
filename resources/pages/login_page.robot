*** Settings ***
Documentation    Page Object da tela de login (the-internet.herokuapp.com).
Resource         ../selenium/browser.robot

*** Variables ***
${LOGIN_PATH}             /login
${LOGIN_INPUT_USUARIO}    id=username
${LOGIN_INPUT_SENHA}      id=password
${LOGIN_BOTAO_ENTRAR}     css=button.radius
${LOGIN_MENSAGEM_FLASH}   id=flash

*** Keywords ***
Abrir Pagina De Login
    Ir Para Pagina    ${LOGIN_PATH}
    Wait Until Page Contains Element    ${LOGIN_INPUT_USUARIO}

Preencher Credenciais
    [Arguments]    ${usuario}    ${senha}
    Input Text    ${LOGIN_INPUT_USUARIO}    ${usuario}
    Input Text    ${LOGIN_INPUT_SENHA}    ${senha}

Clicar Em Entrar
    Click Button    ${LOGIN_BOTAO_ENTRAR}

Realizar Login
    [Arguments]    ${usuario}    ${senha}
    Preencher Credenciais    ${usuario}    ${senha}
    Clicar Em Entrar

Mensagem Flash Deve Conter
    [Arguments]    ${texto_esperado}
    Wait Until Page Contains Element    ${LOGIN_MENSAGEM_FLASH}
    Element Should Contain    ${LOGIN_MENSAGEM_FLASH}    ${texto_esperado}
