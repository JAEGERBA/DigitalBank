*** Settings ***
Documentation     Smoke tests DigitalBank : validation rapide des parcours critiques (PR).
Resource          ../resources/keywords/auth.resource

# On ouvre/ferme le navigateur une seule fois pour aller vite et rester stable
Suite Setup       Open App
Suite Teardown    Close App

# Force le tag pour que le pipeline puisse faire: robot -i smoke ...
Force Tags        smoke


*** Test Cases ***
Login page is accessible
    [Documentation]    Vérifie que l'application est accessible et que la page Login s'affiche.
    Wait Until Login Page Is Visible

Standard login then logout
    [Documentation]    Connexion standard -> dashboard visible -> déconnexion -> retour login.
    Login As Standard User
    Logout

2FA login then logout
    [Documentation]    Connexion avec 2FA -> dashboard visible -> déconnexion -> retour login.
    Login As 2FA User
    Logout