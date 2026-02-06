*** Variables ***
# =============================================================================
# Locators DigitalBank (Robot Framework + SeleniumLibrary)
# Convention: on privilégie data-testid pour éviter les tests fragiles.
# Format: css=[data-testid="..."]
# =============================================================================

# -----------------------------------------------------------------------------
# Login page
# -----------------------------------------------------------------------------
${LOGIN_EMAIL}                 css=[data-testid="input-email"]
${LOGIN_PASSWORD}              css=[data-testid="input-password"]
${LOGIN_SUBMIT}                css=[data-testid="btn-login"]
${LOGIN_ERROR}                 css=[data-testid="login-error"]
${FORGOT_PASSWORD_LINK}        css=[data-testid="link-forgot-password"]

# -----------------------------------------------------------------------------
# 2FA page
# -----------------------------------------------------------------------------
${TWOFA_CODE_0}                css=[data-testid="2fa-code-0"]
${TWOFA_CODE_1}                css=[data-testid="2fa-code-1"]
${TWOFA_CODE_2}                css=[data-testid="2fa-code-2"]
${TWOFA_CODE_3}                css=[data-testid="2fa-code-3"]
${TWOFA_CODE_4}                css=[data-testid="2fa-code-4"]
${TWOFA_CODE_5}                css=[data-testid="2fa-code-5"]
${TWOFA_VERIFY_BUTTON}         css=[data-testid="btn-verify-2fa"]
${TWOFA_ERROR}                 css=[data-testid="2fa-error"]

# -----------------------------------------------------------------------------
# Main navigation / Tabs
# -----------------------------------------------------------------------------
${TAB_DASHBOARD}               css=[data-testid="tab-dashboard"]
${TAB_ACCOUNTS}                css=[data-testid="tab-accounts"]
${TAB_TRANSACTIONS}            css=[data-testid="tab-transactions"]
${TAB_BILLS}                   css=[data-testid="tab-bills"]
${TAB_BENEFICIARIES}           css=[data-testid="tab-beneficiaries"]
${TAB_SETTINGS}                css=[data-testid="tab-settings"]
${TAB_SECURITY}                css=[data-testid="tab-security"]

# -----------------------------------------------------------------------------
# Session
# -----------------------------------------------------------------------------
${LOGOUT_BUTTON}               css=[data-testid="btn-logout"]

# -----------------------------------------------------------------------------
# Security / Change password (Settings/Security)
# -----------------------------------------------------------------------------
${CHANGE_PASSWORD_BUTTON}      css=[data-testid="btn-change-password"]
${CHANGE_PWD_MODAL}            css=[data-testid="modal-change-password"]

${CURRENT_PASSWORD_INPUT}      css=[data-testid="input-current-password"]
${NEW_PASSWORD_INPUT}          css=[data-testid="input-new-password"]
${CONFIRM_PASSWORD_INPUT}      css=[data-testid="input-confirm-password"]

${SAVE_PASSWORD_BUTTON}        css=[data-testid="btn-save-password"]
${CANCEL_PASSWORD_BUTTON}      css=[data-testid="btn-cancel-password"]

${PASSWORD_ERROR}              css=[data-testid="password-error"]

# -----------------------------------------------------------------------------
# (Optionnel) Messages / zones génériques
# -----------------------------------------------------------------------------
${GLOBAL_ALERT}                css=[role="alert"]