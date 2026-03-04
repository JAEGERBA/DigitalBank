*** Settings ***
Documentation     Fonctionnalité testée : consultation des comptes
Resource          ../resources/services/auth_service.resource
Resource          ../resources/services/accounts_service.resource
Resource          ../resources/services/navigation_service.resource

Test Setup       Ouvrir L'Application
Test Teardown    Fermer L'Application


*** Test Cases ***
La Page Accounts Est Accessible
    [Documentation]    Vérifie que la page Comptes/Accounts est accessible depuis l'application (accès menu + titre page)
    [Tags]    regression    accounts

    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    auth_service.Login Avec Identifiants      ${email}    ${password}
    main_page.La Page "Commune" Est Visible
    accounts_service.Se Rendre Sur La Page Des Comptes
    auth_service.Logout

Les Comptes Attendues Sont Présents
    [Documentation]    Vérifie la présence des comptes attendus (Compte Courant + Livret A, ou équivalents EN)
    [Tags]    regression    accounts

    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    auth_service.Login Avec Identifiants      ${email}    ${password}
    accounts_service.Se Rendre Sur La Page Des Comptes
    accounts_service.Les Comptes Sont Présents
    auth_service.Logout

Consultation Des Soldes - Les Soldes Sont Présents
    [Documentation]    Vérifie qu'au moins un solde est affiché sur la page Comptes (format € attendu)
    [Tags]    regression    accounts

    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    auth_service.Login Avec Identifiants      ${email}    ${password}
    accounts_service.Se Rendre Sur La Page Des Comptes
    accounts_service.Consulter Les Soldes
    auth_service.Logout

Consultation Des Transactions - Les Transactions Sont Présentes
    [Documentation]    Vérifie que la section Transactions est visible (anti-régression UI)
    [Tags]    regression    accounts

    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    auth_service.Login Avec Identifiants      ${email}    ${password}
    accounts_service.Se Rendre Sur La Page Des Comptes
    accounts_service.Consulter Les Transactions
    auth_service.Logout

Rafraîchir La Page Conserve Les Données
    [Documentation]    Recharge la page Comptes et vérifie que la page reste exploitable après refresh
    [Tags]    regression    accounts

    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    auth_service.Login Avec Identifiants      ${email}    ${password}
    accounts_service.Se Rendre Sur La Page Des Comptes
    accounts_service.Les Comptes Sont Présents
    accounts_service.Consulter Les Soldes
    accounts_service.Consulter Les Transactions
    navigation_service.Recharger La Page
    auth_service.Login Avec Identifiants      ${email}    ${password}
    accounts_service.Les Comptes Sont Présents
    accounts_service.Consulter Les Soldes
    accounts_service.Consulter Les Transactions
    auth_service.Logout
 