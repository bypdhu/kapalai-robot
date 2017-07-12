cd TestCases

:: import variable file dynamically using "--variablefile"
:: pybot -t put* -d ../Results --variablefile ../Variables/spec.py ./

:: variable: yaml_env can load different yaml file. when yaml_env:test, load file "constants_test.yml"
:: run tests with tag "put*" using "-t"
:: set suite metadata version using "-v" and set "ESS_Version:2.0.0"
:: pybot -t put* -d ../Results --variablefile ../Variables/spec.py -v yaml_env:test ./

:: run robot test, set output path to ""../Results" using "-d" and exclude tests with tag "debug" using "-e"
pybot -d ../Results -e debug ./