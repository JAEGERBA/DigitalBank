*** Settings ***
Documentation    Fonctionnalité testée : Authentification et connexion

Resource         ../resources/services/auth_service.resource

Test Setup       Ouvrir L'Application
Test Teardown    Fermer L'Application


*** Test Cases ***
La Page De Login Est Accessible
    [Documentation]    Vérifie que l'application est accessible et que la page Login s'affiche
    [Tags]    smoke    auth
    
    auth_service.Se Rendre Sur La Page De Login

Login Et Logout Standard
    [Documentation]     login standard -> app visible -> logout
    [Tags]    nightly    smoke    auth
    
    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    auth_service.Login Avec Identifiants      ${email}    ${password}
    main_page.La Page "Commune" Est Visible
    auth_service.Logout

Login Et Logout 2FA
    [Documentation]    Connexion avec 2FA -> dashboard visible -> déconnexion -> retour login
    [Tags]    nightly    smoke    auth

    ${email}    ${password}   ${code}=    auth_service.Obtenir Les Identifiants 2FA
    auth_service.Login Avec Identifiants    ${email}    ${password}
    auth_service.Se connecter 2FA   ${code} 
    auth_service.Logout

Login Invalid Avec Affichage De L'Erreur
    [Documentation]     Vérifie qu’un mot de passe invalide déclenche un message d’erreur
    [Tags]    nightly        auth
    
    ${wrong_pswd}    ${w2FA_code}    ${strong_pswd}    ${weak_pswd}=    
    ...    auth_service.Obtenir Les Données Test
    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    auth_service.Login Avec Identifiants    ${email}    ${wrong_pswd}
    auth_service.Le Message D'Erreur S'Affiche    ${LOGIN_ERROR}

Mauvais Code Pour 2FA Affiche Une Erreur
    [Documentation]     Vérifie qu’un mauvais code 2FA affiche un message d’erreur
    [Tags]    nightly    smoke    auth
    
    ${email}    ${password}   ${code}=    auth_service.Obtenir Les Identifiants 2FA
    auth_service.Login Avec Identifiants    ${email}    ${password}
    ${wrong_pswd}    ${w2FA_code}    ${strong_pswd}    ${weak_pswd}=    
    ...    auth_service.Obtenir Les Données Test
    auth_service.Se connecter 2FA    ${w2FA_code}
    auth_service.Le Message D'Erreur S'Affiche    ${2FA_ERROR}

Changer De Mot De Passe - Mot De Passe Trop Faible
    [Documentation]     Vérifie la validation du formulaire de changement de mot de passe (sans modifier le mot de passe)
    [Tags]    nightly   smoke    MDP    auth
    
    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    ${wrong_pswd}    ${w2FA_code}    ${strong_pswd}    ${weak_pswd}=    
    ...    auth_service.Obtenir Les Données Test
    auth_service.Login Avec Identifiants      ${email}    ${password}
    auth_service.Ouvrir La Modale de Changement De Mot De Passe
    auth_service.Saisir Un Mot De Passe Faible    ${password}    ${weak_pswd}
    auth_service.Logout

Changer De Mot De Passe Et Recharger
    [Documentation]    Scénario non-régression clé : changer le mot de passe, se déconnecter, se reconnecter,
    ...                puis remettre le mot de passe initial pour rendre le test rejouable.
    [Tags]    regression    MDP    auth    E2E    nightly

    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    ${wrong_pswd}    ${w2FA_code}    ${strong_pswd}    ${weak_pswd}=    
    ...    auth_service.Obtenir Les Données Test
    auth_service.Login Avec Identifiants      ${email}    ${password}
    auth_service.Ouvrir La Modale de Changement De Mot De Passe
    auth_service.Changer De Mot De Passe    ${password}    ${strong_pswd}
    auth_service.Logout
    auth_service.Login Avec Identifiants    ${email}    ${strong_pswd}
    auth_service.Ouvrir La Modale de Changement De Mot De Passe
    auth_service.Changer De Mot De Passe    ${strong_pswd}    ${password}
    auth_service.Logout
    auth_service.Login Avec Identifiants    ${email}    ${password}
    main_page.La Page "Commune" Est Visible
    auth_service.Logout