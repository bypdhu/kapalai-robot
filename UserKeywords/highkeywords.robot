*** Settings ***
Resource          midkeywords.robot

*** Keywords ***
test
    [Documentation]    = WifiBeaconInterval =
    ...    ---
    ...    *WifiBeaconInterval* _${interval}_ _*${Act}*_
    ...    ---
    ...    == 功能 ==
    ...    | \ \ \ \ 设置802.11 信标帧间隔时间（ _Beacon Interval_ ）。
    ...
    ...
    ...    ---
    ...    == 范围 ==
    ...    | \ \ \ \ DUT具备对此设置的功能。
    ...
    ...
    ...    ---
    ...    == 参数 ==
    ...    | \ \ \ \ _${interval}_ --- _必填_ 表示信标帧间隔微秒数。 _*默认值： 100*_ ， 允许的取值范围是 _*20-1000*_ 。
    ...
    ...    | \ \ \ \ _*${Act}*_ --- _可选_ 默认为： _*set*_ 。该参数是一个控制关键字行为的开关。可选项有：
    ...    - _set_ ---> 表示希望通过此关键字对WiFi的Beacon Interval 进行设置 默认为此选项；
    ...    - _get_ ---> 表示希望通过此关键字获取当前DUT的WiF的Beacon Interval。
    ...
    ...    === 返回值 ===
    ...    | \ \ \ \ ${status} --- 表示操作结果。
    ...    - 当 _*${Act}*_ 为 _set_ 时，此参数返回 _ok_ 或者 _fail_ 分别表示设置成功或者失败 ；
    ...    - 当 _*${Act}*_ 为 _get_ 时，此参数返回当前WiFi的Beacon Interval 。
    ...    ---
    ...    == 说明 ==
    set suite variable    ${abc}    acbcc

InitSuiteSetUp
    Comment    # set screenshot dir
    Comment    set screenshot directory    ${CaptureImages_Path}
    Comment    # input user name and password
    Comment    ${loglevel}    set log level    NONE
    Comment    ${name}    run keyword if    '${User_Name}' == ''    get value from user    Input user name
    Comment    ${pass}    run keyword if    '${User_Pass}' == ''    get value from user    Input user password    hidden=true
    Comment    ${name}    set variable if    '${name}' == 'None'    ${User_Name}    ${name}
    Comment    ${pass}    set variable if    '${pass}' == 'None'    ${User_Pass}    ${pass}
    Comment    set global variable    ${User_Name}    ${name}
    Comment    set global variable    ${User_Pass}    ${pass}
    Comment    set log level    ${loglevel}
    # set suite metadata
    InitSuiteMetadata
    ## load yaml variables
    LoadYamlVariables

InitSuiteMetadata
    # set suite metadata
    set suite metadata    测试版本    ${ESS_Version}

LoadYamlVariables
    ## load yaml variables
    ${e0}    get variable value    ${yaml_env}    ${EMPTY}
    ${e}    set variable if    "${e0}" != ""    _${e0}    ${EMPTY}
    ${yaml}    get_variables_from_yaml    ${Variabls_Path}${/}constants${e}.yml
    set global variable    ${yaml}    ${yaml}

GeneralSuiteSetup
    ${random}    get random string    6
    set suite variable    ${random}    ${random}@$ &

HttpRequest
    [Arguments]    ${url}    ${method}    ${fileKey}=    ${saveAs}=    ${dataFile}=    ${json}=
    ...    ${expectStatusCode}=    ${expectHeaders}=    ${contentType}=    ${accessKey}=    ${accessSecret}=
    ${host}    get host from url    ${url}
    ${bucket}    get bucket name from url    ${url}
    ${expecth}    set variable if    '${expectHeaders}'=='default'    Server:${host},Connection,Date,ETag,Content-Length    ${expectHeaders}
    ${date}    get date
    ${md5}    run keyword if    '${dataFile}' != ''    get file md5    ${dataFile}
    ${authorization}    run keyword if    '${accessKey}' != ''    get authorization    AccessKeyId=${accessKey}    AccessKeySecret=${accessSecret}    Method=${method}
    ...    Date=${date}    BucketName=${bucket}    Content-MD5=${md5}    Content-Type=${contentType}    FileKey=${fileKey}
    ${headers}    set variable if    '${authorization}' != 'None'    {'Date':'${date}','Content-MD5':'${md5}','Authorization':'${authorization}','Content-Type':'${contentType}'}    ${EMPTY}
    ${response1}    run keyword if    '${method}' == 'PUT' or '${method}' == 'put'    put test    ${url}/${fileKey}    dataFile=${dataFile}    expectStatusCode=${expectStatusCode}
    ...    expectHeaders=${expecth}    headers=${headers}
    ${response2}    run keyword if    '${method}' == 'GET' or '${method}' == 'get'    get test    ${url}/${fileKey}    expectStatusCode=${expectStatusCode}    expectHeaders=${expecth}
    ...    headers=${headers}    saveAs=${saveAs}
    ${response3}    run keyword if    '${method}' == 'DELETE' or '${method}' == 'delete'    delete test    ${url}/${fileKey}    expectStatusCode=${expectStatusCode}    expectHeaders=${expecth}
    ...    headers=${headers}
    ${response4}    run keyword if    '${method}' == 'HEAD' or '${method}' == 'head'    head test    ${url}/${fileKey}    expectStatusCode=${expectStatusCode}    expectHeaders=${expecth}
    ...    headers=${headers}
    ${response5}    run keyword if    '${method}' == 'POST' or '${method}' == 'post'    post test    ${url}    dataFile=${dataFile}    expectStatusCode=${expectStatusCode}
    ...    expectHeaders=${expecth}    headers=${headers}    json=${json}    contentType=${contentType}
    ${response}    set variable if    ${response1} != None    ${response1}    ${response2} != None    ${response2}    ${response3} != None
    ...    ${response3}    ${response4} !=None    ${response4}    ${response5} != None    ${response5}
    [Return]    ${response}
