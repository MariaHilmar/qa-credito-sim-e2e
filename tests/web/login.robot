*** Settings ***
Documentation    Testes web com Selenium — exemplo de login.
Resource         ../../resources/pages/login_page.robot
Variables        ../../variables/common_variables.py
Suite Setup      Abrir Navegador
Suite Teardown   Fechar Navegador
Test Teardown    Capturar Screenshot Em Caso De Falha

*** Test Cases ***
Login Com Credenciais Validas
    [Documentation]    Valida login bem-sucedido na aplicação de demonstração.
    [Tags]    web    smoke
    Abrir Pagina De Login
    Realizar Login    tomsmith    SuperSecretPassword!
    Location Should Contain    /secure
    Page Should Contain    You logged into a secure area!

Login Com Credenciais Invalidas
    [Documentation]    Valida mensagem de erro para credenciais incorretas.
    [Tags]    web
    Abrir Pagina De Login
    Realizar Login    usuario_invalido    senha_invalida
    Mensagem Flash Deve Conter    Your username is invalid!
