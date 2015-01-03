#!/bin/bash
######################################################################
#
#   Test qatest basic behaviour
#
######################################################################

[[ $# -eq 0 ]] && set -- ${QATEST_UNIT_DIR}/create.sh

testCommand "mkdir -p ${QATEST_UNIT_DIR_FINAL}"

LANG=es_ES.UTF-8
testCommand "${@} ${QATEST_UNIT_DIR_FINAL}/lang-1.txt"

LANG=en_US.UTF-8
testCommand "${@} ${QATEST_UNIT_DIR_FINAL}/lang-2.txt"
