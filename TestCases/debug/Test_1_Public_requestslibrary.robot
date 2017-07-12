*** Settings ***
Suite Setup       GeneralSuiteSetup
Resource          ../../UserKeywords/highkeywords.robot
Library           ../../UserLibraries/MyLibrary.py

*** Test Cases ***
get test1
    Comment    create session    chiangmai    http://test1.essintra.ejudata.com:8080
    Comment    ${resp}    get request    chiangmai    1.jpg
    Comment    log    ${resp.headers}
    Comment    Comment    log    ${resp.content}
    Comment    write to file    1.jpg    ${resp.content}

get test2
    ${date}    get date
    ${content}    get binary file    1.jpg
    ${md5}    get md5    ${content}
    ${md5}    get file md5    1.jpg
    ${signature}    get signature    AccessKeySecret=123    Method=PUT    Date=${date}    CanonicalizedResource=/test1/1.jpg    Content-MD5=${md5}
    ${authorization}    get authorization    AccessKeyId=123id    AccessKeySecret=123    Method=PUT    Date=${date}    CanonicalizedResource=/test1/1.jpg
    ...    Content-MD5=${md5}

put test1
    Comment    ${content}    get binary file    1.jpg
    Comment    create session    chiangmai1    http://test1.essintra.ejudata.com:8080
    Comment    ${resp}    put request    chiangmai1    1231313.jpg    data=${content}
    Comment    log    ${resp.headers}
    Comment    log    ${resp.content}
    Comment    write to file    1.jpg    ${resp.content}

test33
    log    ${abc}
