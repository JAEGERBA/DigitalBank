*** Settings ***
Documentation     Fonctionnalité testée : Virements internes
Resource          ../resources/services/auth_service.resource
Resource          ../resources/services/virements_service.resource

Suite Setup       Ouvrir L'Application
Suite Teardown    Fermer L'Application


*** Test Cases ***
La Page Virements Est Accessible
    [Documentation]    Vérifie que la page Virements est accessible depuis le menu principal
    [Tags]    smoke    virements

    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    auth_service.Login Avec Identifiants      ${email}    ${password}
    main_page.La Page "Commune" Est Visible
    virements_service.Se Rendre Sur La Page Des Virements
    virements_service.La Page Virements Est Visible
    auth_service.Logout

Effectuer Un Virement Interne Valide
    [Documentation]    Vérifie qu’un virement interne entre Compte Courant et Livret A fonctionne
    [Tags]    regression    virements

    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    auth_service.Login Avec Identifiants      ${email}    ${password}
    virements_service.Se Rendre Sur La Page Des Virements
    virements_service.Selectionner Compte Source    Compte Courant - 5 000,00 €
    virements_service.Selectionner Compte Destination    Livret A - 15 000,00 €
    virements_service.Saisir Montant    50
    virements_service.Valider Le Virement
    virements_service.Le Message De Confirmation Est Visible
    auth_service.Logout

Virement Refuse Si Montant Invalide
    [Documentation]    Vérifie qu’un montant nul déclenche une erreur
    [Tags]    regression    virements

    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    auth_service.Login Avec Identifiants      ${email}    ${password}
    virements_service.Se Rendre Sur La Page Des Virements
    virements_service.Selectionner Compte Source    Compte Courant - 4 950,00 €
    virements_service.Selectionner Compte Destination    Livret A - 15 050,00 €
    virements_service.Saisir Montant    0
    virements_service.Valider Le Virement
    virements_service.Le Message D'Erreur Est Visible
    auth_service.Logout