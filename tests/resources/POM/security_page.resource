*** Settings ***
Resource   ../web_socle/socle.robot
Resource   ../POM/main_page.resource 


*** Variables ***
${BTN_CHANGE_PASSWORD}       css=[data-testid="btn-change-password"]
${PASSWORD_MODIFIED}         //div[contains(.,"Mot de passe modifié avec succès !")]
${CANCEL_PASSWORD_BUTTON}    css=[data-testid="btn-cancel-password"]
${MODAL_CHANGE_PASSWORD}     css=[data-testid="modal-change-password"]
${PWD_ERROR}                 css=[data-testid="password-error"]
${INPUT_CURRENT_PWD}         css=[data-testid="input-current-password"]
${INPUT_NEW_PWD}             css=[data-testid="input-new-password"]
${INPUT_CONFIRM_PWD}         css=[data-testid="input-confirm-password"]
${BTN_SAVE_PASSWORD}         css=[data-testid="btn-save-password"]


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

Le Mot De Passe Est Modifié
    [Documentation]    Le mot de passe est correctement modifié

    socle.L'Element Doit Etre Visible    ${PASSWORD_MODIFIED}
    
Annuler Le Mot De Passe
    [Documentation]    Annuler le mot de Passe

    socle.Cliquer Sur Le Bouton    ${CANCEL_PASSWORD_BUTTON}

Le Message D'Erreur Est Présent
    [Documentation]    Le message d'erreur du mot de passe est présent

    socle.Attendre Que L'Element Soit Visible    ${PWD_ERROR}   ${TIMEOUT}