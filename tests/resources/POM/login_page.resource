*** Settings ***
Resource    ../web_socle/socle.robot
Resource    ../POM/main_page.resource


*** Variables ***
${LOGIN_EMAIL}             css=[data-testid="input-email"]
${LOGIN_PASSWORD}          css=[data-testid="input-password"]
${LOGIN_SUBMIT}            css=[data-testid="btn-login"]
${LOGIN_ERROR}             css=[data-testid="login-error"]
${FORGOT_PWD_LINK}         css=[data-testid="link-forgot-password"]


*** Keywords ***
Aller A La Page De Login
    [Documentation]    Aller vers la page de login

    Aller Vers L'URL    ${BASE_URL}

La Page "Login" Est Visible
    [Documentation]   La page de login doit petre visible
    
    socle.L'Element Doit Etre Visible    ${LOGIN_EMAIL}

Saisir Email
    [Arguments]    ${email}
    [Documentation]    Saisir l'email

    socle.Saisir Le Texte    ${LOGIN_EMAIL}       ${email}

Saisir Mot De Passe
    [Arguments]    ${password}
    [Documentation]    Saisir le mot de passe

    socle.Saisir Le Mot De Passe    ${LOGIN_PASSWORD}    ${password}
    socle.Cliquer Sur Le Bouton    ${LOGIN_SUBMIT}

Cliquer Sur "Se Connecter"
    [Documentation]    Cliquer sur le bouton "se connecter" pour soumettre 
    ...    le formulaire

    socle.Cliquer Sur Le Bouton    ${LOGIN_SUBMIT}

Cliquer Sur "Changer de Mot De Passe"
    [Documentation]    Cliquer sur le bouton "se connecter" pour soumettre 
    ...    le formulaire

    socle.Cliquer Sur Le Bouton    ${LOGIN_SUBMIT}
    
Cliquer sur "Déconnexion"
    [Documentation]    Cliquer sur le bouton "déconnexion"

    socle.L'Element Doit Etre Visible    ${BTN_LOGOUT}
    socle.Cliquer Sur Le Bouton    ${BTN_LOGOUT}