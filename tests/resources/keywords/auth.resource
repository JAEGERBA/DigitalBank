*** Settings ***
Library    SeleniumLibrary
Library    String
Resource   ../variables.resource
Resource   ../locators.resource


*** Variables ***
# =============================================================================
# Locators (basés sur data-testid dans index.html)
# Tu peux les déplacer dans locators.resource plus tard si tu veux.
# =============================================================================

# Login
${LOGIN_EMAIL}             css=[data-testid="input-email"]
${LOGIN_PASSWORD}          css=[data-testid="input-password"]
${LOGIN_SUBMIT}            css=[data-testid="btn-login"]
${LOGIN_ERROR}             css=[data-testid="login-error"]
${FORGOT_PWD_LINK}         css=[data-testid="link-forgot-password"]

# 2FA
${2FA_ERROR}               css=[data-testid="2fa-error"]
${2FA_CODE_0}              css=[data-testid="2fa-code-0"]
${2FA_CODE_1}              css=[data-testid="2fa-code-1"]
${2FA_CODE_2}              css=[data-testid="2fa-code-2"]
${2FA_CODE_3}              css=[data-testid="2fa-code-3"]
${2FA_CODE_4}              css=[data-testid="2fa-code-4"]
${2FA_CODE_5}              css=[data-testid="2fa-code-5"]
${2FA_VERIFY}              css=[data-testid="btn-verify-2fa"]

# Main app / navigation
${TAB_DASHBOARD}           css=[data-testid="tab-dashboard"]
${TAB_SECURITY}            css=[data-testid="tab-security"]
${BTN_LOGOUT}              css=[data-testid="btn-logout"]

# Change password (onglet Sécurité)
${BTN_CHANGE_PASSWORD}     css=[data-testid="btn-change-password"]
${MODAL_CHANGE_PASSWORD}   css=[data-testid="modal-change-password"]
${PWD_ERROR}               css=[data-testid="password-error"]
${INPUT_CURRENT_PWD}       css=[data-testid="input-current-password"]
${INPUT_NEW_PWD}           css=[data-testid="input-new-password"]
${INPUT_CONFIRM_PWD}       css=[data-testid="input-confirm-password"]
${BTN_SAVE_PASSWORD}       css=[data-testid="btn-save-password"]
${BTN_CANCEL_PASSWORD}     css=[data-testid="btn-cancel-password"]


*** Keywords ***
# =============================================================================
# Browser / Session
# =============================================================================

Open App
    [Documentation]    Ouvre Chrome (headless si demandé), configure la session et va sur ${BASE_URL}.
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    # Headless en CI (HEADLESS=true passé par GitHub Actions)
    Run Keyword If    '${HEADLESS}'=='true'    Call Method    ${options}    add_argument    --headless\=new    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --window-size=1920,1080

    Create Webdriver    Chrome    options=${options}
    Set Selenium Timeout    ${TIMEOUT}
    Go To    ${BASE_URL}
    Wait Until Login Page Is Visible

Close App
    [Documentation]    Ferme proprement le navigateur.
    Close All Browsers


# =============================================================================
# Assertions d'état (pages)
# =============================================================================

Wait Until Login Page Is Visible
    [Documentation]    Vérifie que l'écran de login est affiché (champ email + bouton).
    Wait Until Element Is Visible    ${LOGIN_EMAIL}    ${TIMEOUT}
    Wait Until Element Is Visible    ${LOGIN_SUBMIT}   ${TIMEOUT}

Wait Until Main App Is Visible
    [Documentation]    Vérifie que l'utilisateur est connecté (onglets + bouton déconnexion).
    Wait Until Element Is Visible    ${TAB_DASHBOARD}  ${TIMEOUT}
    Wait Until Element Is Visible    ${BTN_LOGOUT}     ${TIMEOUT}

Wait Until 2FA Page Is Visible
    [Documentation]    Vérifie que l'écran 2FA est affiché (6 inputs + bouton Vérifier).
    Wait Until Element Is Visible    ${2FA_CODE_0}     ${TIMEOUT}
    Wait Until Element Is Visible    ${2FA_VERIFY}     ${TIMEOUT}


# =============================================================================
# Authentification
# =============================================================================

Login With Credentials
    [Arguments]    ${email}    ${password}
    [Documentation]    Saisit les identifiants et soumet le formulaire de login.
    Wait Until Login Page Is Visible
    Clear Element Text    ${LOGIN_EMAIL}
    Input Text            ${LOGIN_EMAIL}       ${email}
    Clear Element Text    ${LOGIN_PASSWORD}
    Input Password        ${LOGIN_PASSWORD}    ${password}
    Click Button          ${LOGIN_SUBMIT}

Login As Standard User
    [Documentation]    Login avec le compte standard (sans 2FA).
    Login With Credentials    ${USER_STD_EMAIL}    ${USER_STD_PASSWORD}
    Wait Until Main App Is Visible

Login As 2FA User
    [Documentation]    Login avec le compte 2FA : login -> page 2FA -> saisie code -> app.
    Login With Credentials    ${USER_2FA_EMAIL}    ${USER_2FA_PASSWORD}
    Wait Until 2FA Page Is Visible
    Submit 2FA Code          ${USER_2FA_CODE}
    Wait Until Main App Is Visible

Submit 2FA Code
    [Arguments]    ${code}
    [Documentation]    Renseigne les 6 chiffres du code 2FA puis clique sur Vérifier.
    # On split le code en chiffres pour remplir chaque champ
    ${c0}=    Get Substring    ${code}    0    1
    ${c1}=    Get Substring    ${code}    1    2
    ${c2}=    Get Substring    ${code}    2    3
    ${c3}=    Get Substring    ${code}    3    4
    ${c4}=    Get Substring    ${code}    4    5
    ${c5}=    Get Substring    ${code}    5    6

    Input Text    ${2FA_CODE_0}    ${c0}
    Input Text    ${2FA_CODE_1}    ${c1}
    Input Text    ${2FA_CODE_2}    ${c2}
    Input Text    ${2FA_CODE_3}    ${c3}
    Input Text    ${2FA_CODE_4}    ${c4}
    Input Text    ${2FA_CODE_5}    ${c5}

    Click Button  ${2FA_VERIFY}

Logout
    [Documentation]    Déconnexion et retour à la page login.
    Wait Until Element Is Visible    ${BTN_LOGOUT}    ${TIMEOUT}
    Click Button                      ${BTN_LOGOUT}
    Wait Until Login Page Is Visible


# =============================================================================
# Sécurité / Changement de mot de passe (régression clé)
# =============================================================================

Open Security Tab
    [Documentation]    Ouvre l'onglet Sécurité.
    Wait Until Main App Is Visible
    Click Element    ${TAB_SECURITY}
    Wait Until Element Is Visible    ${BTN_CHANGE_PASSWORD}    ${TIMEOUT}

Open Change Password Modal
    [Documentation]    Ouvre la modal "Modifier le mot de passe".
    Open Security Tab
    Click Button    ${BTN_CHANGE_PASSWORD}
    # La modal est présente mais peut être "hidden" : on attend un élément interne (champ current pwd)
    Wait Until Element Is Visible    ${INPUT_CURRENT_PWD}    ${TIMEOUT}

Change Password
    [Arguments]    ${current_password}    ${new_password}
    [Documentation]    Change le mot de passe via la modal Sécurité.
    Open Change Password Modal
    Input Password    ${INPUT_CURRENT_PWD}    ${current_password}
    Input Password    ${INPUT_NEW_PWD}        ${new_password}
    Input Password    ${INPUT_CONFIRM_PWD}    ${new_password}
    Click Button      ${BTN_SAVE_PASSWORD}
    # Après sauvegarde, on attend que la modal se ferme (champ current pwd disparaît)
    Wait Until Element Is Not Visible    ${INPUT_CURRENT_PWD}    ${TIMEOUT}