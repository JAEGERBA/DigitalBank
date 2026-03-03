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
    virements_service.Se Rendre Sur La Page Des Virements
    virements_service.La Page Virements Est Visible
    auth_service.Logout

Effectuer Un Virement Interne Valide
    [Documentation]    Vérifie qu’un virement interne entre Compte Courant et Livret A fonctionne
    [Tags]    regression    smoke    virements

    ${email}    ${password}=    auth_service.Obtenir Les Identifiants Standards
    auth_service.Login Avec Identifiants      ${email}    ${password}
    virements_service.Se Rendre Sur La Page Des Virements
    virements_service.Selectionner Compte Source    4
    virements_service.Selectionner Compte Destination    5
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
    virements_service.Selectionner Compte Source    4
    virements_service.Selectionner Compte Destination    5
    virements_service.Saisir Montant    0
    virements_service.Valider Le Virement
    virements_service.Le Message D'Erreur Est Visible
    auth_service.Logout