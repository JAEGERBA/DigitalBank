*** Settings ***
Library    SeleniumLibrary
Library    String

Resource       ../variables.resource
Resource       ../POM/factures_page.resource


*** Keywords ***

Se rendre sur la page factures
    [Documentation]    Aller sur la page des factures - service

    factures_page.Cliquer sur la page Factures dans le menu

Ouvrir la modale de paiement pour une facture
    [Documentation]    Ouvre la modale de confirmation en cliquant sur Payer pour l'id donné.
    [Arguments]    ${bill_id}

    Se rendre sur la page factures
    factures_page.La Page Factures doit être visible
    factures_page.Cliquer sur Payer pour la facture    ${bill_id}
    factures_page.La modale de confirmation doit être visible

Annuler le paiement d'une facture
    [Documentation]    Ouvre la modale de paiement puis annule et vérifie fermeture.
    [Arguments]    ${bill_id}

    Ouvrir la modale de paiement pour une facture    ${bill_id}
    factures_page.Annuler le paiement
    factures_page.La modale de confirmation doit être masquée

Confirmer le paiement d'une facture
    [Documentation]    Ouvre la modale de paiement puis confirme et vérifie le succès + facture dans payées.
    [Arguments]    ${bill_id}

    Ouvrir la modale de paiement pour une facture    ${bill_id}
    factures_page.Confirmer le paiement
    factures_page.Le message de succès doit être visible
    factures_page.La facture payée doit être visible    ${bill_id}