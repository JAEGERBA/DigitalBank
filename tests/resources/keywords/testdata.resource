*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary
Library    String
Library   Collections
Resource       ../variables.resource
Resource       ../locators.resource
Resource      testdata.resource



*** Keywords ***
Load Test Data
    ${content}=    Get File    data/test_users.yaml
    ${data}=       Evaluate    __import__("yaml").safe_load("""${content}""")    yaml
    Set Suite Variable    ${TESTDATA}    ${data}

Get Standard Credentials
    ${users}=      Get From Dictionary    ${TESTDATA}    users
    ${standard}=   Get From Dictionary    ${users}       standard
    ${email}=      Get From Dictionary    ${standard}    email
    ${password}=   Get From Dictionary    ${standard}    password
    [Return]       ${email}    ${password}