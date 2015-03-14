#!/bin/bash
######################################################################
#
#   ./QaTests/idforge-qatest/qatest-2015010849776781980.sh
#
######################################################################

#=====================================================================
# Enter integrity checks target command:
#=====================================================================
QATEST_FLAG_COMMAND="./idforge.sh"

#=====================================================================
# Enter integrity checks target arguments:
#=====================================================================
command_line "qatest"
command_line "qatest --version"
command_line "qatest --description"
command_line "qatest --help"
