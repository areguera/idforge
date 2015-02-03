#!/bin/bash
######################################################################
#
#   Test qatest basic behaviour
#
######################################################################

#=====================================================================
# Enter integrity checks target command:
#=====================================================================
QATEST_FLAG_COMMAND="${QATEST_UNIT_DIR}/create.sh"

#=====================================================================
# Enter integrity checks target arguments:
#=====================================================================
LANG=es_ES.UTF-8; command_line "${QATEST_UNIT_DIR}/Final/lang-1.txt"
LANG=en_US.UTF-8; command_line "${QATEST_UNIT_DIR}/Final/lang-2.txt"
