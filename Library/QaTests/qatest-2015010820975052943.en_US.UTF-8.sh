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
command_line "config"
command_line "config --version"
command_line "config --description"
#command_line "qatest --help"

# Retrieve configuration files from a directory and print them to
# standard output.
command_line "config ${QATEST_UNIT_DIR}"

# Retrieve section names from configuration files and print them to
# standard output.  In this case, all configuration sections matching
# the section pattern, inside all configuration files found, will be
# printed to standard output.
command_line "config -e 'greeting' ${QATEST_UNIT_DIR}"

# Retrieve option value from specific section without default value.
# In this case, when the option has no value set in the configuration
# file, an empty value is sent to standard output.
command_line "config -e 'greeting' -o 'message' ${QATEST_UNIT_DIR}"

# Retrieve option value from specific section with default value. In
# this case, when the option has no value set in the configuration
# file, the default value set in the command-line will be sent to
# standard output.
command_line "config -e 'greeting' -o 'message' -a 'Hello' ${QATEST_UNIT_DIR}"
