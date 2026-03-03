*** Settings ***
Resource    ../web_socle/socle.robot

*** Variables ***
${TAB_DASHBOARD}           css=[data-testid="tab-dashboard"]
${TAB_SECURITY}            css=[data-testid="tab-security"]
${BTN_LOGOUT}              css=[data-testid="btn-logout"]


*** Keywords ***
La Page "Commune" Est Visible
    [Documentation]   La page de login doit petre visible
    
    socle.L'Element Doit Etre Visible    ${TAB_DASHBOARD}
    socle.L'Element Doit Etre Visible    ${BTN_LOGOUT}
