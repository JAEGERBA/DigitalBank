*** Settings ***
# Resource   ../locators.resource
Resource    ../web_socle/socle.robot


*** Variables ***
${2FA_ERROR}               css=[data-testid="2fa-error"]
${2FA_CODE_0}              css=[data-testid="2fa-code-0"]
${2FA_CODE_1}              css=[data-testid="2fa-code-1"]
${2FA_CODE_2}              css=[data-testid="2fa-code-2"]
${2FA_CODE_3}              css=[data-testid="2fa-code-3"]
${2FA_CODE_4}              css=[data-testid="2fa-code-4"]
${2FA_CODE_5}              css=[data-testid="2fa-code-5"]
${2FA_VERIFY}              css=[data-testid="btn-verify-2fa"]


*** Keywords ***
La Page "2FA" Est Visible
    [Documentation]   Vérifie que l'écran 2FA est affiché (6 inputs + bouton Vérifier)
    
    socle.L'Element Doit Etre Visible    ${2FA_CODE_0}
    socle.L'Element Doit Etre Visible    ${2FA_VERIFY}

Saisir Le Code 2FA
    [Arguments]    ${code}
    [Documentation]    Renseigne les 6 chiffres du code 2FA puis clique sur Vérifier

    ${c0}=    string.Get Substring    ${code}    0    1
    ${c1}=    string.Get Substring    ${code}    1    2
    ${c2}=    string.Get Substring    ${code}    2    3
    ${c3}=    string.Get Substring    ${code}    3    4
    ${c4}=    string.Get Substring    ${code}    4    5
    ${c5}=    string.Get Substring    ${code}    5    6

    socle.Saisir Le Texte    ${2FA_CODE_0}    ${c0}
    socle.Saisir Le Texte    ${2FA_CODE_1}    ${c1}
    socle.Saisir Le Texte    ${2FA_CODE_2}    ${c2}
    socle.Saisir Le Texte    ${2FA_CODE_3}    ${c3}
    socle.Saisir Le Texte    ${2FA_CODE_4}    ${c4}
    socle.Saisir Le Texte    ${2FA_CODE_5}    ${c5}

    socle.Cliquer Sur Le Bouton    ${2FA_VERIFY}