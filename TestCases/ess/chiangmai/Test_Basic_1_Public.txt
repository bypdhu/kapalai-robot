*** Settings ***
Suite Setup       GeneralSuiteSetup
Resource          ../../../UserKeywords/highkeywords.robot

*** Test Cases ***
test_1_put
    ${yy}    set variable    ${yaml['public']}
    ${filedir}    set variable    ${Resources_Path }/original
    @{filelist}    List Files In Directory    ${filedir}
    #################    PUT
    : FOR    ${f}    IN    @{filelist}
    \    ${response}    http request    ${yy['baseUrl']}    PUT    fileKey=${random}${f}    dataFile=${filedir}/${f}
    \    ...    expectStatusCode=200    expectHeaders=default    contentType=image/jpeg

test_2_get
    ${yy}    set variable    ${yaml['public']}
    ${filedir}    set variable    ${Resources_Path }/original
    @{filelist}    List Files In Directory    ${filedir}
    #################
    : FOR    ${f}    IN    @{filelist}
    \    ${response}    http request    ${yy['baseUrl']}    GET    fileKey=${random}${f}    expectStatusCode=200
    \    ...    expectHeaders=default    saveAs=${Resources_Path }/tmp/original/${f}

test_3_head
    ${yy}    set variable    ${yaml['public']}
    ${filedir}    set variable    ${Resources_Path }/original
    @{filelist}    List Files In Directory    ${filedir}
    #################
    : FOR    ${f}    IN    @{filelist}
    \    ${response}    http request    ${yy['baseUrl']}    HEAD    fileKey=${random}${f}    expectStatusCode=200
    \    ...    expectHeaders=default

test_4_delete
    ${yy}    set variable    ${yaml['public']}
    ${filedir}    set variable    ${Resources_Path }/original
    @{filelist}    List Files In Directory    ${filedir}
    #################
    : FOR    ${f}    IN    @{filelist}
    \    ${response}    http request    ${yy['baseUrl']}    DELETE    fileKey=${random}${f}    expectStatusCode=200
    \    ...    expectHeaders=Server,Connection,Date,Content-Length

test_5_post_delete
    ${yy}    set variable    ${yaml['public']}
    ${filedir}    set variable    ${Resources_Path }/original
    @{filelist}    List Files In Directory    ${filedir}
    @{postlist}    create list
    #################
    : FOR    ${f}    IN    @{filelist}
    \    ${response}    http request    ${yy['baseUrl']}    POST    dataFile=${filedir}/${f}    expectStatusCode=200
    \    ...    expectHeaders=Server,Connection,Date,Content-Length
    \    log dictionary    ${response}
    \    ${filekey}    set variable    ${response['text']['key']}
    \    append to list    ${postlist}    ${filekey}
    : FOR    ${pf}    IN    @{postlist}
    \    ###### GET
    \    ${response}    http request    ${yy['baseUrl']}    GET    fileKey=${pf}    expectStatusCode=200
    \    ...    expectHeaders=default    saveAs=${Resources_Path }/tmp/original/${f}
    \    ###### DELETE
    \    ${response}    http request    ${yy['baseUrl']}    DELETE    fileKey=${pf}    expectStatusCode=200
    \    ...    expectHeaders=Server,Connection,Date,Content-Length
