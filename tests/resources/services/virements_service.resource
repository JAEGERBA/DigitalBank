*** Settings ***
Resource    ../POM/virements_page.resource


*** Keywords ***
Se Rendre Sur La Page Des Virements
    [Documentation]    Ouvre l'onglet Virements

    virements_page.Ouvrir L'Onglet Virements

La Page Virements Est Visible
    [Documentation]    Vérifie que la page virements est bien affichée

    virements_page.Obtenir La Présence De La Page Virements

Selectionner Compte Source
    [Documentation]    Sélectionner le compte source du virement
    [Arguments]    ${compte}

    virements_page.Selectionner Compte Source Dans La Liste    ${compte}

Selectionner Compte Destination
    [Documentation]    Sélectionner le compte du destinataire du virement
    [Arguments]    ${compte}

    virements_page.Selectionner Compte Destinataire Dans La Liste    ${compte}

Saisir Montant
    [Arguments]    ${montant}

    virements_page.Saisir Montant Dans Le Champ    ${montant}

Valider Le Virement
    [Documentation]    Valider Le virement

    virements_page.Valider Le Virement

Le Message De Confirmation Est Visible
    [Documentation]    Le message de succes s'affiche correctement

    virements_page.Obtenir La Présence Du Message De Confirmation

Le Message D'Erreur Est Visible
    [Documentation]    Le message d'erreur s'affiche correctement

    virements_page.Le Virement N'Est Pas Effectué
