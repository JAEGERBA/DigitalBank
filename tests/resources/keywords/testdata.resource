*** Settings ***
Library    Collections
Resource    testdata.py

*** Keywords ***
Load Test Data
    ${data}=    Load Test Data From Yaml    data/test_users.yaml
    Set Suite Variable    ${TESTDATA}    ${data}

Get Standard Credentials
    ${users}=      Get From Dictionary    ${TESTDATA}    users
    ${standard}=   Get From Dictionary    ${users}       standard
    ${email}=      Get From Dictionary    ${standard}    email
    ${password}=   Get From Dictionary    ${standard}    password
    RETURN         ${email}    ${password}