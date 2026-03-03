*** Settings ***
Resource   ../locators.resource
Resource   ../web_socle/socle.robot
Resource   ../POM/main_page.resource 


*** Variables ***
${BTN_CHANGE_PASSWORD}     css=[data-testid="btn-change-password"]
${MODAL_CHANGE_PASSWORD}   css=[data-testid="modal-change-password"]
${PWD_ERROR}               css=[data-testid="password-error"]
${INPUT_CURRENT_PWD}       css=[data-testid="input-current-password"]
${INPUT_NEW_PWD}           css=[data-testid="input-new-password"]
${INPUT_CONFIRM_PWD}       css=[data-testid="input-confirm-password"]
${BTN_SAVE_PASSWORD}       css=[data-testid="btn-save-password"]


*** Keywords ***
Ouvrir L'Onglet Sécurité
    [Documentation]    Ouvre l'onglet Sécurité

    socle.Cliquer Sur L'Element    ${TAB_SECURITY}
    socle.L'Element Doit Etre Visible    ${BTN_CHANGE_PASSWORD}

Saisir Mot De Passe Actuel
    [Arguments]    ${password}
    [Documentation]    Saisir le mot de passe

    socle.Saisir Le Mot De Passe    ${INPUT_CURRENT_PWD}    ${password}

Saisir Nouveau Mot De Passe
    [Arguments]    ${password}
    [Documentation]    Saisir le mot de passe

    socle.Saisir Le Mot De Passe    ${INPUT_NEW_PWD}    ${password}

Confirmer Le Mot De Passe
    [Arguments]    ${password}
    [Documentation]    Saisir le mot de passe

    socle.Saisir Le Mot De Passe    ${INPUT_CONFIRM_PWD}    ${password}
    socle.Cliquer Sur Le Bouton     ${BTN_SAVE_PASSWORD}
    socle.L'Element Doit Etre Visible    ${INPUT_CURRENT_PWD}