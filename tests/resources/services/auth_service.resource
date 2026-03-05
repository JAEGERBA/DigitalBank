*** Settings ***
Library    SeleniumLibrary
Library    String

Resource       ../variables.resource
Resource       testdata.resource
Resource       ../POM/login_page.resource
Resource       ../POM/main_page.resource
Resource       ../POM/2FA_page.resource
Resource       ../POM/security_page.resource


*** Keywords ***
# =============================================================================
# Navigateur
# =============================================================================

Ouvrir L'Application
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    
    ...    sys
    
    testdata.Load Test Data
    socle.Creer Un Webdriver
    socle.Aller Vers L'URL    ${BASE_URL}
    login_page.La Page "Login" Est Visible

Fermer L'Application
    [Documentation]    Ferme proprement le navigateur.

    socle.Fermer Les Navigateurs

# =============================================================================
# Authentification
# =============================================================================

Se Rendre Sur La Page De Login
    [Documentation]    Aller vers la Page de login - service

    login_page.Aller A La Page De Login
    Run Keyword And Ignore Error        Logout
    login_page.Aller A La Page De Login
    login_page.La Page "Login" Est Visible


Login Avec Identifiants
    [Arguments]    ${email}    ${password}
    [Documentation]    Saisit les identifiants et soumet le formulaire de login

    login_page.La Page "Login" Est Visible
    login_page.Saisir Email    ${email}
    login_page.Saisir Mot De Passe    ${password}  

Obtenir Les Identifiants Standards
    [Documentation]    Obtenir les identifiants standards 

    ${email}    ${password}=    testdata.Get Standard Credentials
    RETURN    ${email}    ${password}

Obtenir Les Identifiants 2FA
    ${email}    ${password}    ${2fa_code}=    testdata.Get 2FA Credentials
    RETURN    ${email}    ${password}    ${2fa_code}

Obtenir Les Données Test
    ${wrong_pswd}    ${w2FA_code}    ${strong_pswd}    ${weak_pswd}=    testdata.Get Test Data
    RETURN    ${wrong_pswd}    ${w2FA_code}    ${strong_pswd}    ${weak_pswd}

Logout
    [Documentation]    Déconnexion et retour à la page login

    main_page.La Page "Commune" Est Visible
    login_page.Cliquer sur "Déconnexion"
    login_page.La Page "Login" Est Visible

Se connecter 2FA
    [Documentation]    Saisie du code pour le compte avec 2FA activé
    [Arguments]    ${code}

    2FA_page.La Page "2FA" Est Visible
    2FA_page.Saisir Le Code 2FA    ${code}

Le Message D'Erreur S'Affiche
    [Documentation]    Le message d'erreur d'affiche correctement
    [Arguments]    ${erreur}

    socle.L'Element Doit Etre Visible    ${erreur}
        
# =============================================================================
# Changement de mot de passe
# =============================================================================

Ouvrir La Modale de Changement De Mot De Passe
    [Documentation]    Ouvre la modal "Modifier le mot de passe"

    main_page.La Page "Commune" Est Visible
    security_page.Ouvrir L'Onglet Sécurité
    socle.Cliquer Sur Le Bouton    ${BTN_CHANGE_PASSWORD}
    socle.L'Element Doit Etre Visible    ${INPUT_CURRENT_PWD}

Changer De Mot De Passe
    [Arguments]    ${current_password}    ${new_password}
    [Documentation]    Change le mot de passe via la modal Sécurité
    
    security_page.Saisir Mot De Passe Actuel    ${current_password}
    security_page.Saisir Nouveau Mot De Passe   ${new_password}
    security_page.Confirmer Le Mot De Passe     ${new_password}
    security_page.Le Mot De Passe Est Modifié

Saisir Un Mot De Passe Faible
    [Documentation]    Saisir un mot de passe trop faible
    [Arguments]    ${current_password}    ${weak_password}

    security_page.Saisir Mot De Passe Actuel     ${current_password}
    security_page.Saisir Nouveau Mot De Passe    ${weak_password}
    security_page.Confirmer Le Mot De Passe      ${weak_password}
    security_page.Le Message D'Erreur Est Présent
    security_page.Annuler Le Mot De Passe