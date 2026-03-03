*** Settings ***
Resource   ../locators.resource
Resource    ../web_socle/socle.robot


*** Variables **
*** Variables ***
${factures_bouton_locator}                 //button[contains(normalize-space(.), 'Factures')]
${liste_factures_en_attente_locator}       //*[@data-testid='pending-bills']
${factures_page_locator}                   //h2[contains(.,'Factures à payer')]
${modale_confirmation_locator}             //*[@data-testid='modal-confirm-payment']
${bouton_annuler_paiement_locator}         //*[@data-testid='btn-cancel-payment']
${bouton_confirmer_paiement_locator}       //*[@data-testid='btn-confirm-payment']
${message_succes_paiement_locator}         //*[@data-testid='bill-success']
${liste_factures_payees_locator}           //*[@data-testid='paid-bills']
${bouton_fermer_modale_locator}           //*[@data-testid='btn-cancel-payment']

*** Keywords ***

Cliquer sur la page Factures dans le menu
    [Documentation]    Cliquer sur le menu "Factures" pour accéder à la page des factures
    Cliquer Sur L'Element    ${factures_bouton_locator}

La Page Factures doit être visible
    [Documentation]    Vérifie que la page de factures est affichée 
    L'Element Doit Etre Visible    ${factures_page_locator}

La liste des factures en attente doit être visible
    [Documentation]    Vérifie que la liste des factures en attente est visible
    L'Element Doit Etre Visible    ${liste_factures_en_attente_locator}

*** Keywords ***

Cliquer sur Payer pour la facture
    [Documentation]    Clique sur le bouton "Payer" pour une facture donnée (ex: 1,2,3...).
    [Arguments]    ${bill_id}
    ${btn_pay}=    Set Variable    //*[@data-testid='btn-pay-bill-${bill_id}']
    L'Element Doit Etre Visible    ${btn_pay}
    Cliquer Sur L'Element          ${btn_pay}

La modale de confirmation doit être visible
    [Documentation]    Vérifie que la modale de confirmation de paiement est affichée.
    L'Element Doit Etre Visible    ${modale_confirmation_locator}

Annuler le paiement
    [Documentation]    Clique sur "Annuler" dans la modale de paiement.
    L'Element Doit Etre Visible    ${bouton_annuler_paiement_locator}
    Cliquer Sur L'Element          ${bouton_annuler_paiement_locator}

Confirmer le paiement
    [Documentation]    Clique sur "Confirmer" dans la modale de paiement.
    L'Element Doit Etre Visible    ${bouton_confirmer_paiement_locator}
    Cliquer Sur L'Element          ${bouton_confirmer_paiement_locator}

La modale de confirmation doit être masquée
    [Documentation]    Vérifie que la modale n'est plus visible (après annulation par ex.).
    # Selon ton socle, adapte le keyword. Si tu as "L'Element Ne Doit Pas Etre Visible", utilise-le.
    L'Element Ne Doit Pas Etre Visible     ${modale_confirmation_locator}

Le message de succès doit être visible
    [Documentation]    Vérifie l'affichage du message de succès après paiement.
    L'Element Doit Etre Visible    ${message_succes_paiement_locator}

La facture payée doit être visible
    [Arguments]    ${bill_id}
    ${paid_bill}=    Set Variable    //*[@data-testid='bill-paid-${bill_id}']

    Attendre Que L'Element Soit Visible    ${liste_factures_payees_locator}    ${TIMEOUT}
    Attendre Que L'Element Soit Visible    ${paid_bill}    ${TIMEOUT}

    L'Element Doit Etre Visible    ${liste_factures_payees_locator}
    L'Element Doit Etre Visible    ${paid_bill}

fermer la modale de paiement
    [Documentation]    Ferme la modale de paiement (en cas de besoin, ex: après succès)

    L'Element Doit Etre Visible    ${bouton_fermer_modale_locator}
    Cliquer Sur L'Element          ${bouton_fermer_modale_locator}

