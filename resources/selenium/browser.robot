*** Settings ***
Documentation    Configuração e ciclo de vida do navegador (local e CI remoto).
Library          SeleniumLibrary
Variables        ../../variables/common_variables.py

*** Keywords ***
Abrir Navegador
    [Documentation]    Abre o browser local (headless ou não) ou conecta ao Grid remoto no CI.
    [Arguments]    ${url}=${BASE_URL}
    ${remote_url}=    Get Variable Value    ${SELENIUM_REMOTE_URL}    ${EMPTY}
    IF    """${remote_url}""" != """${EMPTY}"""
        Open Browser    ${url}    ${BROWSER}    remote_url=${remote_url}
    ELSE IF    ${HEADLESS}
        Open Browser    ${url}    headlesschrome
    ELSE
        Open Browser    ${url}    ${BROWSER}
    END
    Set Selenium Timeout    ${TIMEOUT}s
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}s
    ${speed}=    Get Variable Value    ${SELENIUM_SPEED}    ${EMPTY}
    Run Keyword If    """${speed}""" != """${EMPTY}"""    Set Selenium Speed    ${speed}
    Maximize Browser Window

Fechar Navegador
    [Documentation]    Encerra todas as sessões do navegador.
    Run Keyword And Ignore Error    Close All Browsers

Ir Para Pagina
    [Arguments]    ${path}=
    ${url}=    Set Variable If    """${path}""" == """"""    ${BASE_URL}    ${BASE_URL}${path}
    Go To    ${url}

Capturar Screenshot Em Caso De Falha
    Run Keyword If Test Failed    Capture Page Screenshot    filename=results/selenium-screenshot-{index}.png
