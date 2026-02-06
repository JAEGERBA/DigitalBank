
*** Settings ***
Documentation     Regression tests DigitalBank : non-régression sur authentification et sécurité.
Resource          ../resources/keywords/auth.resource

# On ouvre/ferme le navigateur une seule fois pour la suite (plus rapide et stable)
Suite Setup       Open App
Suite Teardown    Close App

# Tag pour exécution CI (quand vous repasserez en -i regression)
Force Tags        regression


*** Variables ***
# Mot de passe temporaire utilisé pendant le test de changement de mot de passe
# (doit respecter la règle : min 8, maj, min, chiffre, caractère spécial)
${TEMP_PASSWORD}    TempPass789!


*** Test Cases ***
Invalid login shows an error
    [Documentation]    Vérifie qu’un login invalide affiche un message d’erreur (contrôle basique de sécurité/UX).
    Wait Until Login Page Is Visible
    Login With Credentials    ${USER_STD_EMAIL}    WRONG_PASSWORD_123!
    # Le message d’erreur est attendu sur la page de login
    Wait Until Element Is Visible    ${LOGIN_ERROR}    ${TIMEOUT}

Change password then re-login (and restore)
    [Documentation]    Scénario non-régression clé : changer le mot de passe, se déconnecter, se reconnecter,
    ...                puis remettre le mot de passe initial pour rendre le test rejouable.
    #
    # 1) Connexion avec le compte standard
    Login As Standard User

    # 2) Changement de mot de passe -> TEMP
    Change Password    ${USER_STD_PASSWORD}    ${TEMP_PASSWORD}

    # 3) Déconnexion puis reconnexion avec TEMP
    Logout
    Login With Credentials    ${USER_STD_EMAIL}    ${TEMP_PASSWORD}
    Wait Until Main App Is Visible

    # 4) Remise du mot de passe initial (pour que le test passe à chaque exécution)
    Change Password    ${TEMP_PASSWORD}    ${USER_STD_PASSWORD}

    # 5) Vérification finale : logout puis login avec mot de passe original
    Logout
    Login With Credentials    ${USER_STD_EMAIL}    ${USER_STD_PASSWORD}
    Wait Until Main App Is Visible
    Logout