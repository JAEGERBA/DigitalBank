*** Settings ***
Library    Collections
Library    testdata.py


*** Variables ***
${TESTDATA}


*** Keywords ***
Load Test Data
    ${data}=    testdata.Load Test Data From Yaml    data/test_users.yaml
    Set Suite Variable    ${TESTDATA}    ${data}

Get Standard Credentials
    ${users}=      Get From Dictionary    ${TESTDATA}    users
    ${standard}=   Get From Dictionary    ${users}       standard
    ${email}=      Get From Dictionary    ${standard}    email
    ${password}=   Get From Dictionary    ${standard}    password
    RETURN         ${email}    ${password}

Get 2FA Credentials
    ${users}=      Get From Dictionary    ${TESTDATA}    users
    ${2FA}=        Get From Dictionary    ${users}       twofa
    ${email}=      Get From Dictionary    ${2FA}    email
    ${password}=   Get From Dictionary    ${2FA}    password
    ${2FA_code}=   Get From Dictionary    ${2FA}    two_fa_code
    RETURN         ${email}    ${password}    ${2FA_code}

Get Test Data
    ${test_data}=      Get From Dictionary    ${TESTDATA}    test_data
    ${wrong}=   Get From Dictionary    ${test_data}       wrong_password
    ${2FA}=   Get From Dictionary    ${test_data}       wrong_two_fa_code
    ${strong}=   Get From Dictionary    ${test_data}       strong_password
    ${weak}=    Get From Dictionary    ${test_data}    weak_password


    RETURN         ${wrong}    ${2FA}    ${strong}    ${weak}