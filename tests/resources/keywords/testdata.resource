*** Settings ***
Library    OperatingSystem
Library    Collections

*** Keywords ***
Load Test Data
    ${content}=    Get File    data/test_users.yaml
    ${data}=       Evaluate    __import__("yaml").safe_load(content)    content=${content}
    Set Suite Variable    ${TESTDATA}    ${data}

Get Standard Credentials
    ${users}=      Get From Dictionary    ${TESTDATA}    users
    ${standard}=   Get From Dictionary    ${users}       standard
    ${email}=      Get From Dictionary    ${standard}    email
    ${password}=   Get From Dictionary    ${standard}    password
    RETURN         ${email}    ${password}