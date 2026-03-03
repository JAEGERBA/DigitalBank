*** Settings ***
Documentation     Suite Factures (Billing) - tests E2E sans Selenium direct (via socle.robot).
...               Objectif : couvrir la consultation des factures en attente + paiement + historique.
...
...               Cette suite utilise :
...               - socle.robot : pour toutes les actions UI (clic, saisie, waits, assertions)
...               - factures_page.resource : locators + actions "Page Object"
...               - operations_service.resource : keywords métier orientés "paiement facture"

Resource          ../resources/web_socle/socle.robot
Resource          ../resources/services/testdata.resource
Resource          ../resources/POM/factures_page.resource
Resource          ../resources/services/operations_service.resource
Resource          ../resources/services/auth_service.resource

Suite Setup       Ouvrir L'Application
Suite Teardown    Fermer L'Application




*** Test Cases ***

La page de Factures est accessible 
    [Tags]    smoke    regression    factures
    [Documentation]    Vérifie que la page de factures est accessible depuis le menu.
    operations_service.Se rendre sur la page factures
    factures_page.La Page Factures doit être visible
    Logout

La liste des Factures en attente est visible    
    [Tags]    smoke    regression    factures
    [Documentation]    Vérifie que la liste des factures en attente est visible (anti-régression UI).
    ...                On ne fait pas d'hypothèse forte sur le nombre, juste que la zone existe.
    operations_service.Se rendre sur la page factures
    factures_page.La Page Factures doit être visible

    factures_page.La Liste des Factures en Attente doit être visible

    Logout

Ouverture modale paiement facture
    [Tags]    smoke    regression    factures
    [Documentation]    Clique sur Payer (facture 1) et vérifie que la modale de confirmation apparaît.
    operations_service.Se rendre sur la page factures
    factures_page.La Page Factures doit être visible
    factures_page.Cliquer sur Payer pour la facture    1
    factures_page.La modale de confirmation doit être visible
    Logout

Annuler paiement ferme la modale
    [Tags]    regression    factures
    [Documentation]    Ouvre la modale de paiement puis clique Annuler et vérifie que la modale disparaît.
    operations_service.Se rendre sur la page factures
    factures_page.La Page Factures doit être visible
    factures_page.Cliquer sur Payer pour la facture    1
    factures_page.La modale de confirmation doit être visible
    factures_page.Annuler le paiement
    factures_page.La modale de confirmation doit être masquée
    Logout

Confirmer paiement affiche succès et déplace la facture
    [Tags]    nightly    regression    factures
    [Documentation]    Confirme le paiement de la facture 1 et vérifie succès + facture déplacée en payée.
    operations_service.Se rendre sur la page factures
    factures_page.La Page Factures doit être visible
    factures_page.Cliquer sur Payer pour la facture    1
    factures_page.Confirmer le paiement
    factures_page.Le message de succès doit être visible
    factures_page.La facture payée doit être visible    1
    Logout