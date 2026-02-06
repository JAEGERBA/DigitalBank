*** Variables ***
# =============================================================================
# Variables globales du projet (Robot Framework + SeleniumLibrary)
# Objectif : centraliser la config d'exécution + données de test stables
# =============================================================================

# --- Configuration d'exécution ------------------------------------------------
# URL de l'application (en CI, votre pipeline sert l'app sur http://localhost:8080)
# Vous pouvez aussi override via :
#   robot -v BASE_URL:http://localhost:8080 ...
${BASE_URL}                 http://localhost:8080

# Navigateur Selenium (Chrome recommandé)
${BROWSER}                  chrome

# Mode headless : utile en CI (sans interface graphique).
# Votre pipeline passe -v HEADLESS:true, donc par défaut on laisse "false" en local.
${HEADLESS}                 false

# Timeout global (pour Wait Until..., éléments, navigation)
${TIMEOUT}                  10s

# Delai court pour micro-attentes (si besoin, à utiliser avec parcimonie)
${SHORT_WAIT}               0.5s


# --- Données de test (issues de l'écran "Identifiants de test") --------------
# Compte standard (sans 2FA)
${USER_STD_EMAIL}           test@digitalbank.fr
${USER_STD_PASSWORD}        Test1234!

# Compte avec 2FA (mentionné comme compte de test 2FA)
${USER_2FA_EMAIL}           marie.martin@email.com
${USER_2FA_PASSWORD}        SecurePass456!

# Code 2FA de test (fixe dans l'application)
${USER_2FA_CODE}            123456


# --- Paramètres UI / assertions simples --------------------------------------
# Valeur "attendue" sur une page après connexion :
# (on s'appuie sur les data-testid présents dans l'app pour des checks stables)
${DASHBOARD_TAB_TESTID}     tab-dashboard
${LOGOUT_BTN_TESTID}        btn-logout


# --- Conventions de locators -------------------------------------------------
# On recommande d'utiliser principalement les data-testid :
# Exemple dans locators.resource : css=[data-testid="input-email"]
${LOCATOR_PREFIX}           css=[data-testid="
${LOCATOR_SUFFIX}           "]