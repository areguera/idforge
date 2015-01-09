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
test_setCommand "qatest"
test_setCommand "qatest --version"
test_setCommand "qatest --description"
test_setCommand "qatest --help"
