#!/bin/bash
######################################################################
# 
#   Test module's command-line.
#
######################################################################

COUNT=0

COMMANDS[$((COUNT++))]="${QAT_COMMAND}"
COMMANDS[$((COUNT++))]="${QAT_COMMAND} --help"
COMMANDS[$((COUNT++))]="${QAT_COMMAND} --version"
COMMANDS[$((COUNT++))]="${QAT_COMMAND} Welcome"
COMMANDS[$((COUNT++))]="${QAT_COMMAND} Welcome --lower"
COMMANDS[$((COUNT++))]="${QAT_COMMAND} Welcome --upper"
COMMANDS[$((COUNT++))]="${QAT_COMMAND} Welcome --camel"
COMMANDS[$((COUNT++))]="${QAT_COMMAND} Welcome --random"

COUNT=0

while [[ ${COUNT} -lt ${#COMMANDS[*]} ]];do

    ${COMMANDS[${COUNT}]} > /dev/null

    qat_checkExitStatus "${?}" "${COMMANDS[${COUNT}]}"

    COUNT=$((++COUNT))

done
