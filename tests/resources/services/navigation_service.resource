*** Settings ***
Library    SeleniumLibrary


*** Keywords ***
Recharger La Page
    [Documentation]    Recharger La page actuelle

    SeleniumLibrary.Reload Page