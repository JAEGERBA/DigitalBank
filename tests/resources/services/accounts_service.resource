*** Settings ***
Library    SeleniumLibrary
Library    String
Resource       ../variables.resource
Resource       ../POM/main_page.resource
Resource       ../POM/accounts_page.resource


*** Keywords ***

Se Rendre Sur La Page Des Comptes
    [Documentation]    Aller vers la Page de login - service

    accounts_page.Ouvrir L'Onglet Comptes
    accounts_page.L'Onglet Comptes Est Ouvert

Les Comptes Sont Présents
    [Documentation]    Les Comptes Sont Présents (courant, epargnes)

    accounts_page.Le Compte Courant Est Présent
    accounts_page.Le Compte Epargne Est Présent

Consulter Les Soldes
    [Documentation]    Pouvoir consulter les soldes des différents comptes

    accounts_page.Obtenir Les Soldes

Consulter Les Transactions
    [Documentation]    Les Données des transactions sont présentes

    accounts_page.Obtenir Les Données Des Transactions