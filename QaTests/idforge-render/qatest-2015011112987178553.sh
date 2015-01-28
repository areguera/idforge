#!/bin/bash
######################################################################
#
#   This test verifies the existence of common options definitions
#   inside the idforge render command-line.
#
######################################################################

#=====================================================================
# Enter integrity checks target command:
#=====================================================================
QATEST_FLAG_COMMAND="./idforge.sh"

#=====================================================================
# Enter integrity checks target arguments:
#=====================================================================
test_setCommand "render"
test_setCommand "render --version"
test_setCommand "render --description"
test_setCommand "render --help"
