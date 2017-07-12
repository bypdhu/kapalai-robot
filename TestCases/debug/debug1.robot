*** Settings ***
Suite Setup       GeneralSuiteSetup
Resource          ../../UserKeywords/highkeywords.robot

*** Test Cases ***
put test 1
    ${filekey}    set variable    1.jpg
    ${filepath}    set variable    ${Resources_Path }/debug/original/2.jpg
    ${host}    get host from url    ${yaml['public']['baseUrl']}
    put test    ${yaml['public']['baseUrl']}/${filekey}    dataFile=${filepath}    expectStatusCode=200    expectHeaders=Server:${host},Connection,Date,ETag,Content-Length

get test 1
    get test    http://test1.essintra.ejudata.com:8080/1.jpg    saveAs=${Resources_Path }/debug/11/2.jpg    expectStatusCode=200    expectHeaders=Server:test1.essintra.ejudata.com,Connection,Date,ETag,Content-Length    expectFilePath=${Resources_Path}/debug/original/2.jpg

head test 1

put test 2
    ${yy}    set variable    ${yaml['priw']}
    ${key}    set variable    ${yy['key']}
    ${pass}    set variable    ${yy['pass']}
    ${method}    set variable    PUT
    ${filekey}    set variable    2323333.jpg
    ${filepath}    set variable    ${Resources_Path }/debug/original/2.jpg
    ${host}    get host from url    ${yy['baseUrl']}
    ${bucket}    get bucket name from url    ${yy['baseUrl']}
    ${date}    get date
    ${md5}    get file md5    ${filepath}
    ${type}    set variable    image/jpeg
    Comment    ${signature}    get signature    AccessKeySecret=5f472a64599957f38f8bba09dc4baa24    Method=PUT    Date=${date}    CanonicalizedResource=/test2/2.jpg
    ...    Content-MD5=${md5}
    ${authorization}    get authorization    AccessKeyId=${key}    AccessKeySecret=${pass}    Method=${method}    Date=${date}    BucketName=${bucket}
    ...    Content-MD5=${md5}    Content-Type=${type}    FileKey=${filekey}
    put test    ${yy['baseUrl']}/${filekey}    dataFile=${filepath}    expectStatusCode=200    expectHeaders=Server:${host},Connection,Date,ETag,Content-Length    headers={'Date':'${date}','Content-MD5':'${md5}','Authorization':'${authorization}','Content-Type':'${type}'}

put test 3
    ${date}    get date
    ${md5}    get file md5    ${Resources_Path }/debug/original/2.jpg
    ${type}    set variable    image/jpeg
    ${authorization}    get authorization    AccessKeyId=3e4b174eae84587b301bdfe31ae7557b    AccessKeySecret=91f6987f96d6d0b05fce2060d2b6ee6b    Method=PUT    Date=${date}    BucketName=test3
    ...    Content-MD5=${md5}    Content-Type=${type}    FileKey=2.jpg
    put test    http://test3.essintra.ejudata.com:8080/2.jpg    dataFile=${Resources_Path }/debug/original/2.jpg    expectStatusCode=200    expectHeaders=Server:test3.essintra.ejudata.com,Connection,Date,ETag,Content-Length    headers={'Date':'${date}','Content-MD5':'${md5}','Authorization':'${authorization}','Content-Type':'${type}'}

yml test 1
    log    ${yaml}
    log    3
    log    ${yaml['privateWritePrivateRead']}
    log    ${yaml['privateWritePrivateRead']['authorizationCode']['baseUrl']}
