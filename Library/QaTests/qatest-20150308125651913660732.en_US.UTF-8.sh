#!/bin/bash
######################################################################
#
#   ...
#
#   ------------------------------------------------------------------
#   ...
#   ------------------------------------------------------------------
#
######################################################################

#=====================================================================
# Enter integrity checks target locale:
#=====================================================================
export LANG=en_US.UTF-8

#=====================================================================
# Enter integrity checks target models:
#=====================================================================
export IDFORGE_MODELS=$(dirname ${0})/Models/Common

#=====================================================================
# Enter integrity checks target command:
#=====================================================================
QATEST_FLAG_COMMAND="${0}"

#=====================================================================
# Enter integrity checks target arguments:
#=====================================================================
command_line "hello"
command_line "hello --description"
command_line "hello --version"
#command_line "hello --help"
command_line "hello Welcome"
command_line "hello Welcome --lower"
command_line "hello Welcome --upper"
command_line "hello Welcome --camel"
command_line "hello Welcome --random"
