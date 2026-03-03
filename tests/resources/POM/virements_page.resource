*** Settings ***
Resource    ../locators.resource
Resource    ../web_socle/socle.robot


*** Variables ***

${NAV_VIREMENTS}            xpath=//button[@data-testid="tab-transfer"]
${VIREMENTS_TITLE}          xpath=//h2[contains(.,'Effectuer un virement')]

${SOURCE_SELECT}            xpath=//select[@data-testid="select-from-account"]
${DEST_SELECT}              xpath=//select[@data-testid="select-to-account"]
${AMOUNT_INPUT}             xpath=//input[@data-testid="input-amount"]
${SUBMIT_BUTTON}            xpath=//button[contains(.,'Effectuer le virement')]

${SUCCESS_MESSAGE}          xpath=//*[contains(@class,'success') or contains(.,'Virement effectué')]
${ERROR_MESSAGE}            xpath=//*[contains(.,"4 950,00")]



*** Keywords ***

Ouvrir L'Onglet Virements
    [Documentation]    Ouvre l'onglet Virements depuis le menu principal

    socle.Attendre Que L'Element Soit Visible    ${NAV_VIREMENTS}    ${TIMEOUT}
    socle.Scroller En Haut De La Page
    socle.Cliquer Sur L'Element    ${NAV_VIREMENTS}

Obtenir La Présence De La Page Virements
    [Documentation]    Vérifie que le titre de la page virements est visible

    socle.Attendre Que L'Element Soit Visible    ${VIREMENTS_TITLE}    ${TIMEOUT}

Selectionner Compte Source Dans La Liste
    [Documentation]    Séléectionne le compte source dans la liste des comptes
    [Arguments]    ${compte}

    socle.Attendre Que L'Element Soit Visible    ${SOURCE_SELECT}    ${TIMEOUT}
    socle.Selectionner Depuis Liste Par Label    ${SOURCE_SELECT}    ${compte}

Selectionner Compte Destinataire Dans La Liste
    [Documentation]    Sélectionne le compte de destination dans la liste des 
    ...    comptes
    [Arguments]    ${compte}

    socle.Attendre Que L'Element Soit Visible    ${DEST_SELECT}    ${TIMEOUT}
    socle.Selectionner Depuis Liste Par Label    ${DEST_SELECT}    ${compte}

Saisir Montant Dans Le Champ
    [Documentation]    Saisie du montant dans le champ prévu
    [Arguments]    ${montant}

    socle.Attendre Que L'Element Soit Visible    ${AMOUNT_INPUT}    ${TIMEOUT}
    socle.Saisir Le Texte    ${AMOUNT_INPUT}    ${montant}

Valider Le Virement
    [Documentation]    Cliquer sur Valider le payement

    socle.Attendre Que L'Element Soit Visible    ${SUBMIT_BUTTON}    ${TIMEOUT}
    socle.Cliquer Sur L'Element    ${SUBMIT_BUTTON}

Obtenir La Présence Du Message De Confirmation
    [Documentation]    Obtenir la présence du message de confirmation

    socle.Attendre Que L'Element Soit Visible    ${SUCCESS_MESSAGE}    ${TIMEOUT}


Le Virement N'Est Pas Effectué
    [Documentation]    Obtenir la présence du message d'erreur du virement

    socle.Attendre Que L'Element Soit Visible    ${ERROR_MESSAGE}    ${TIMEOUT}