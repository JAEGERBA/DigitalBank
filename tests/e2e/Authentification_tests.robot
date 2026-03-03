*** Settings ***
Documentation    Fonctionnalité testée : Authentification et connexion

Resource         ../resources/services/auth_service.resource

Suite Setup       Ouvrir L'Application
Suite Teardown    Fermer L'Application

Test Setup    Se Rendre Sur La Page De Login


*** Variables ***
${TEMP_PASSWORD}     TempPass789!
${WRONG_PASSWORD}    WrongPass123!
${WRONG_2FA_CODE}    000000
${WEAK_PASSWORD}     1234

*** Test Cases ***

La Page De Login Est Accessible
    [Documentation]    Vérifie que l'application est accessible et que la page Login s'affiche
    [Tags]    smoke
    
    auth_service.Se Rendre Sur La Page De Login

Login Et Logout Standard
    [Documentation]     login standard -> app visible -> logout
    [Tags]    nightly    smoke
    
    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    auth_service.Login Avec Identifiants      ${email}    ${password}
    main_page.La Page "Commune" Est Visible
    auth_service.Logout

Login Et Logout 2FA
    [Documentation]    Connexion avec 2FA -> dashboard visible -> déconnexion -> retour login
    [Tags]    nightly    smoke

    auth_service.Login Avec Identifiants    ${USER_2FA_EMAIL}    ${USER_2FA_PASSWORD}
    auth_service.Se connecter 2FA
    auth_service.Logout

Login Invalid Avec Affichage De L'Erreur
    [Documentation]     Vérifie qu’un mot de passe invalide déclenche un message d’erreur
    [Tags]    nightly    
    
    auth_service.Login Avec Identifiants    ${USER_STD_EMAIL}    ${WRONG_PASSWORD}
    auth_service.Le Message D'Erreur S'Affiche    ${LOGIN_ERROR}

Mauvais Code Pour 2FA Affiche Une Erreur
    [Documentation]     Vérifie qu’un mauvais code 2FA affiche un message d’erreur
    [Tags]    nightly    smoke
    
    auth_service.Login Avec Identifiants    ${USER_2FA_EMAIL}    ${USER_2FA_PASSWORD}
    2FA_page.La Page "2FA" Est Visible
    2FA_page.Saisir Le Code 2FA    ${WRONG_2FA_CODE}
    auth_service.Le Message D'Erreur S'Affiche    ${2FA_ERROR}

Changer De Mot De Passe - Mot De Passe Trop Faible
    [Documentation]     Vérifie la validation du formulaire de changement de mot de passe (sans modifier le mot de passe)
    [Tags]    nightly   smoke    MDP
    
    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    auth_service.Login Avec Identifiants      ${email}    ${password}
    auth_service.Ouvrir La Modale de Changement De Mot De Passe
    auth_service.Saisir Un Mot De Passe Faible    ${WEAK_PASSWORD}
    auth_service.Logout

Changer De Mot De Passe Et Recharger
    [Documentation]    Scénario non-régression clé : changer le mot de passe, se déconnecter, se reconnecter,
    ...                puis remettre le mot de passe initial pour rendre le test rejouable.
    [Tags]    regression    MDP

    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    auth_service.Login Avec Identifiants      ${email}    ${password}
    auth_service.Ouvrir La Modale de Changement De Mot De Passe
    auth_service.Changer De Mot De Passe    ${USER_STD_PASSWORD}    ${TEMP_PASSWORD}
    auth_service.Logout
    auth_service.Login Avec Identifiants    ${USER_STD_EMAIL}    ${TEMP_PASSWORD}
    auth_service.Ouvrir La Modale de Changement De Mot De Passe
    auth_service.Changer De Mot De Passe    ${TEMP_PASSWORD}    ${USER_STD_PASSWORD}
    auth_service.Logout
    auth_service.Login Avec Identifiants    ${USER_STD_EMAIL}    ${USER_STD_PASSWORD}
    main_page.La Page "Commune" Est Visible
    auth_service.Logout