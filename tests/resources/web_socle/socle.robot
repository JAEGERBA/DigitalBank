*** Settings ***

Library    SeleniumLibrary
Library    String

*** Variables ***
${BASE_URL}                 http://localhost:8080
${BROWSER}                  chrome
${HEADLESS}                 false
${TIMEOUT}                  10s


*** Keywords ***

L'Element Doit Etre Visible
    [Arguments]    ${locator}

    SeleniumLibrary.Element Should Be Visible    ${locator}    ${TIMEOUT}


Attendre Que L'Element Soit Visible
    [Arguments]    ${locator}    ${timeout}

    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${timeout}

Saisir Le Texte
    [Arguments]    ${locator}    ${text}

    SeleniumLibrary.Clear Element Text    ${locator}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    SeleniumLibrary.Input Password    ${locator}    ${text}

Saisir Le Mot De Passe
    [Arguments]    ${locator}    ${pswd}

    SeleniumLibrary.Clear Element Text    ${locator}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    SeleniumLibrary.Input Password    ${locator}    ${pswd}

Cliquer Sur Le Bouton
    [Arguments]    ${locator} 

    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${TIMEOUT}  
    SeleniumLibrary.Click Button      ${locator}

Cliquer Sur L'Element
    [Arguments]    ${locator}

    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    SeleniumLibrary.Click Element    ${locator}

L'Element Ne Doit Pas Etre Visible
    [Arguments]    ${locator}

    SeleniumLibrary.Element Should Not Be Visible    ${locator}

Aller Vers L'URL
    [Arguments]    ${URL}

    SeleniumLibrary.Go To    ${URL}

Fermer Les Navigateurs
    [Documentation]    Ferme tous ls navigateurs

    SeleniumLibrary.Close All Browsers

Creer Un Webdriver
    [Documentation]

    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

    Run Keyword If    '${HEADLESS}'=='true'    Call Method    ${options}    add_argument    argument=--headless
    Call Method    ${options}    add_argument    argument=--no-sandbox
    Call Method    ${options}    add_argument    argument=--disable-dev-shm-usage
    Call Method    ${options}    add_argument    argument=--window-size=1920,1080

    SeleniumLibrary.Create Webdriver    Chrome    options=${options}
    SeleniumLibrary.Set Selenium Timeout    ${TIMEOUT}