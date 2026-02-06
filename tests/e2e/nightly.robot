*** Settings ***
Documentation     Nightly tests DigitalBank : scénarios élargis + négatifs (sans casser les données).
Resource          ../resources/keywords/auth.resource

Suite Setup       Open App
Suite Teardown    Close App
Force Tags        nightly


*** Variables ***
${WRONG_PASSWORD}        WrongPass123!
${WRONG_2FA_CODE}        000000
${WEAK_PASSWORD}         1234


*** Test Cases ***
Standard login then logout (nightly sanity)
    [Documentation]    Sanity nightly : login standard -> app visible -> logout.
    Login As Standard User
    Logout

Invalid login shows an error
    [Documentation]    Vérifie qu’un mot de passe invalide déclenche un message d’erreur.
    Wait Until Login Page Is Visible
    Login With Credentials    ${USER_STD_EMAIL}    ${WRONG_PASSWORD}
    Wait Until Element Is Visible    ${LOGIN_ERROR}    ${TIMEOUT}

2FA wrong code shows an error
    [Documentation]    Vérifie qu’un mauvais code 2FA affiche un message d’erreur.
    Wait Until Login Page Is Visible
    Login With Credentials    ${USER_2FA_EMAIL}    ${USER_2FA_PASSWORD}
    Wait Until 2FA Page Is Visible
    Submit 2FA Code          ${WRONG_2FA_CODE}
    Wait Until Element Is Visible    ${2FA_ERROR}    ${TIMEOUT}

Change password modal rejects weak password (no save)
    [Documentation]    Vérifie la validation du formulaire de changement de mot de passe (sans modifier le mot de passe).
    Login As Standard User
    Open Change Password Modal

    # On remplit avec un mot de passe volontairement trop faible / invalide
    Input Password    ${INPUT_CURRENT_PWD}    ${USER_STD_PASSWORD}
    Input Password    ${INPUT_NEW_PWD}        ${WEAK_PASSWORD}
    Input Password    ${INPUT_CONFIRM_PWD}    ${WEAK_PASSWORD}

    # On tente de sauvegarder -> on attend un message d'erreur de validation
    Click Button      ${BTN_SAVE_PASSWORD}
    Wait Until Element Is Visible    ${PWD_ERROR}    ${TIMEOUT}

    # On annule pour ne rien changer (test sans effet de bord)
    Click Button      ${BTN_CANCEL_PASSWORD}
    Logout