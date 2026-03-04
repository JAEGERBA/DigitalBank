*** Settings ***
# Resource    ../locators.resource
Resource    ../web_socle/socle.robot


*** Variables ***
${NAV_ACCOUNTS}            xpath=//a[contains(.,'Comptes')] | //button[contains(.,'Comptes')] | //a[contains(.,'Accounts')] | //button[contains(.,'Accounts')]
${ACCOUNTS_TITLE}          xpath=//h2[contains(.,"Bonjour")]
${ACCOUNT_CURRENT}         xpath=//*[contains(.,'Compte Courant')]
${ACCOUNT_SAVINGS}         xpath=//*[contains(.,'Livret A')]
${LOC_IBAN_CURRENT}        xpath=(//div[@class="balance-card-number"])[1]
${LOC_IBAN_SAVINGS}        xpath=(//div[@class="balance-card-number"])[2]

${BALANCE_ANY}             xpath=//*[contains(.,'€') and (contains(@class,'balance'))]
${TRANSACTIONS_SECTION}    xpath=//*[contains(.,'Transaction')]
${TRANSACTIONS_LIST}       xpath=//div[@data-testid="transaction-list"]

${IBAN_CURRENT}            FR76 0000 1111 2222 3333 4444 555
${IBAN_LIVRETA}            FR76 0000 1111 2222 3333 4444 666

*** Keywords ***
Ouvrir L'Onglet Comptes
    [Documentation]    Ouvre l'onglet Sécurité

    socle.Attendre Que L'Element Soit Visible    ${NAV_ACCOUNTS}     ${TIMEOUT}
    socle.Cliquer Sur L'Element    ${NAV_ACCOUNTS}
    

L'Onglet Comptes Est Ouvert
    [Documentation]    L'onglet accounts est bien ouvert

    socle.Attendre Que L'Element Soit Visible    ${ACCOUNTS_TITLE}     ${TIMEOUT}

Le Compte Courant Est Présent
    [Documentation]    Le compte courant est visible

    socle.Attendre Que L'Element Soit Visible    ${ACCOUNT_CURRENT}    ${TIMEOUT}
    ${IBAN}=    socle.Obtenir Le Texte    ${LOC_IBAN_CURRENT}
    Should Be Equal As Strings    ${IBAN}    ${IBAN_CURRENT}
    
Le Compte Epargne Est Présent
    [Documentation]    Le compte épargne est visible    

    socle.Attendre Que L'Element Soit Visible   ${ACCOUNT_SAVINGS}    ${TIMEOUT}
    ${IBAN}=    socle.Obtenir Le Texte    ${LOC_IBAN_SAVINGS}
    Should Be Equal As Strings    ${IBAN}    ${IBAN_LIVRETA}

Obtenir Les Soldes
    [Documentation]    Obtenir Les Soldes et s'assurer qu'ils sont bien présents

    socle.Attendre Que L'Element Soit Visible    ${BALANCE_ANY}    ${TIMEOUT}
    ${balance}=    socle.Obtenir Le Texte    ${BALANCE_ANY}
    Should Not Be Empty    ${balance}
    Should Contain    ${balance}    €

Obtenir Les Données Des Transactions
    [Documentation]    Obtenir Les données des transactions sur l'onglet accounts

    socle.Attendre Que L'Element Soit Visible    ${TRANSACTIONS_SECTION}    ${TIMEOUT}
    socle.Attendre Que L'Element Soit Visible    ${TRANSACTIONS_LIST}    ${TIMEOUT}