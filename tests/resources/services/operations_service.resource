*** Settings ***
Library    SeleniumLibrary
Library    String
Resource       ../variables.resource
# Resource       ../locators.resource
Resource       testdata.resource
Resource       ../POM/login_page.resource
Resource       ../POM/main_page.resource
Resource       ../POM/2FA_page.resource
Resource       ../POM/security_page.resource
Resource       ../web_socle/socle.robot
Resource       ../services/auth_service.resource
Resource       ../POM/factures_page.resource


*** Keywords ***

Se rendre sur la page factures
    [Documentation]    Aller sur la page des factures - service

    ${email}    ${password}    Obtenir Les Identifiants Standards
    Se Rendre Sur La Page De Login
    Login Avec Identifiants    ${email}    ${password}
    Cliquer sur la page Factures dans le menu

*** Keywords ***

Ouvrir la modale de paiement pour une facture
    [Documentation]    Ouvre la modale de confirmation en cliquant sur Payer pour l'id donné.
    [Arguments]    ${bill_id}
    Se rendre sur la page factures
    La Page Factures doit être visible
    Cliquer sur Payer pour la facture    ${bill_id}
    La modale de confirmation doit être visible


Annuler le paiement d'une facture
    [Documentation]    Ouvre la modale de paiement puis annule et vérifie fermeture.
    [Arguments]    ${bill_id}
    Ouvrir la modale de paiement pour une facture    ${bill_id}
    Annuler le paiement
    La modale de confirmation doit être masquée


Confirmer le paiement d'une facture
    [Documentation]    Ouvre la modale de paiement puis confirme et vérifie le succès + facture dans payées.
    [Arguments]    ${bill_id}
    Ouvrir la modale de paiement pour une facture    ${bill_id}
    Confirmer le paiement
    Le message de succès doit être visible
    La facture payée doit être visible    ${bill_id}