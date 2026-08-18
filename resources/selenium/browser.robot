*** Settings ***
Documentation    Configuração e ciclo de vida do navegador (local e CI).
Library          SeleniumLibrary
Variables        ../../variables/common_variables.py

*** Keywords ***
Abrir Navegador
    [Documentation]    Abre o browser local (headless ou não) ou conecta ao Grid remoto.
    [Arguments]    ${url}=about:blank
    ${remote_url}=    Get Variable Value    ${SELENIUM_REMOTE_URL}    ${EMPTY}
    IF    """${remote_url}""" != """${EMPTY}"""
        Open Browser    ${url}    ${BROWSER}    remote_url=${remote_url}
    ELSE IF    ${HEADLESS}
        ${options}=    Montar Opcoes Chrome Headless
        Open Browser    ${url}    headlesschrome    options=${options}
    ELSE
        Open Browser    ${url}    ${BROWSER}
    END
    Set Selenium Timeout    ${TIMEOUT}s
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}s
    ${speed}=    Get Variable Value    ${SELENIUM_SPEED}    ${EMPTY}
    IF    """${speed}""" != """${EMPTY}"""
        Set Selenium Speed    ${speed}
    END
    Maximize Browser Window

Montar Opcoes Chrome Headless
    [Documentation]    Opções estáveis para CI (sandbox, binary Chromium opcional).
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys,selenium.webdriver
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    ${binary}=    Get Variable Value    ${CHROME_BINARY}    ${EMPTY}
    IF    """${binary}""" != """${EMPTY}"""
        Call Method    ${options}    set_binary_location    ${binary}
    END
    RETURN    ${options}

Fechar Navegador
    [Documentation]    Encerra todas as sessões do navegador.
    Run Keyword And Ignore Error    Close All Browsers

Capturar Screenshot Em Caso De Falha
    Run Keyword If Test Failed    Capture Page Screenshot    filename=results/selenium-screenshot-{index}.png
