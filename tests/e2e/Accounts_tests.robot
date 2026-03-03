*** Settings ***
Documentation     Fonctionnalité testée : consultation des comptes
Resource          ../resources/services/auth_service.resource
Resource          ../resources/services/testdata.resource

Suite Setup       Ouvrir L'Application
Suite Teardown    Fermer L'Application


*** Variables ***
# Mot de passe temporaire utilisé pendant le test de changement de mot de passe
# (doit respecter la règle : min 8, maj, min, chiffre, caractère spécial)


# --- Locators simples (à ajuster si vos libellés diffèrent) ---
${NAV_ACCOUNTS}            xpath=//a[contains(.,'Comptes')] | //button[contains(.,'Comptes')] | //a[contains(.,'Accounts')] | //button[contains(.,'Accounts')]
${ACCOUNTS_TITLE}          xpath=//*[self::h1 or self::h2][contains(.,'Comptes') or contains(.,'Accounts')]

# Comptes attendus (fallback FR/EN)
${ACCOUNT_CURRENT}         xpath=//*[contains(.,'Compte Courant') or contains(.,'Current Account') or contains(.,'Checking')]
${ACCOUNT_SAVINGS}         xpath=//*[contains(.,'Livret A') or contains(.,'Savings')]

# Soldes / transactions (fallbacks)
${BALANCE_ANY}             xpath=//*[contains(.,'€') and (contains(@class,'balance') or contains(@id,'balance') or contains(@data-testid,'balance') or contains(@class,'amount') or contains(@id,'amount'))]
${TRANSACTIONS_SECTION}    xpath=//*[contains(.,'Transaction') or contains(.,'Transactions')]


*** Test Cases ***

Accounts page is reachable
    [Documentation]    Vérifie que la page Comptes/Accounts est accessible depuis l'application (accès menu + titre page)
    [Tags]    regression

    Login En Tant Qu'Utilisateur Standard
    Wait Until Main App Is Visible
    Wait Until Element Is Visible    ${NAV_ACCOUNTS}    ${TIMEOUT}
    Click Element    ${NAV_ACCOUNTS}
    Wait Until Element Is Visible    ${ACCOUNTS_TITLE}    ${TIMEOUT}
    Logout

Expected accounts are visible
    [Documentation]    Vérifie la présence des comptes attendus (Compte Courant + Livret A, ou équivalents EN)
    [Tags]    regression

    Login En Tant Qu'Utilisateur Standard
    Wait Until Main App Is Visible
    Click Element    ${NAV_ACCOUNTS}
    Wait Until Element Is Visible    ${ACCOUNTS_TITLE}    ${TIMEOUT}
    Wait Until Element Is Visible    ${ACCOUNT_CURRENT}    ${TIMEOUT}
    Wait Until Element Is Visible    ${ACCOUNT_SAVINGS}    ${TIMEOUT}
    Logout

Account consultation shows balances
    [Documentation]    Vérifie qu'au moins un solde est affiché sur la page Comptes (format € attendu)
    [Tags]    regression

    Login En Tant Qu'Utilisateur Standard
    Wait Until Main App Is Visible
    Click Element    ${NAV_ACCOUNTS}
    Wait Until Element Is Visible    ${ACCOUNTS_TITLE}    ${TIMEOUT}
    Wait Until Element Is Visible    ${BALANCE_ANY}    ${TIMEOUT}
    ${balance}=    Get Text    ${BALANCE_ANY}
    Should Not Be Empty    ${balance}
    Should Contain    ${balance}    €
    Logout

Account consultation shows transactions section
    [Documentation]    Vérifie que la section Transactions est visible (anti-régression UI)
    [Tags]    regression

    Login En Tant Qu'Utilisateur Standard
    Wait Until Main App Is Visible
    Click Element    ${NAV_ACCOUNTS}
    Wait Until Element Is Visible    ${ACCOUNTS_TITLE}    ${TIMEOUT}
    Wait Until Element Is Visible    ${TRANSACTIONS_SECTION}    ${TIMEOUT}
    Logout

Refresh on accounts page keeps UI usable
    [Documentation]    Recharge la page Comptes et vérifie que la page reste exploitable après refresh
    [Tags]    regression

    Login En Tant Qu'Utilisateur Standard
    Wait Until Main App Is Visible
    Click Element    ${NAV_ACCOUNTS}
    Wait Until Element Is Visible    ${ACCOUNTS_TITLE}    ${TIMEOUT}
    Reload Page
    Wait Until Element Is Visible    ${ACCOUNTS_TITLE}    ${TIMEOUT}
    Logout
 