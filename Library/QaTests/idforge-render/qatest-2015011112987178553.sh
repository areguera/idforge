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
command_line "render"
command_line "render --version"
command_line "render --description"
command_line "render --help"
