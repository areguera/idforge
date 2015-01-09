#!/bin/bash
######################################################################
#
#   QaTests/idforge-config/qatest-2015010820975052943.sh
#
######################################################################

#=====================================================================
# Enter integrity checks target command:
#=====================================================================
QATEST_FLAG_COMMAND="./idforge.sh"

#=====================================================================
# Enter integrity checks target arguments:
#=====================================================================
test_setCommand "config"
test_setCommand "config --version"
test_setCommand "config --description"
test_setCommand "config --help"

# Retrieve configuration files from a directory and print them to
# standard output.
test_setCommand "config ${QATEST_UNIT_DIR}"

# Retrieve section names from configuration files and print them to
# standard output.  In this case, all configuration sections matching
# the section pattern, inside all configuration files found, will be
# printed to standard output. 
test_setCommand "config -e 'greeting' ${QATEST_UNIT_DIR}"

# Retrieve option value from specific section without default value.
# In this case, when the option has no value set in the configuration
# file, an empty value is sent to standard output.
test_setCommand "config -e 'greeting' -o 'message' ${QATEST_UNIT_DIR}"

# Retrieve option value from specific section with default value. In
# this case, when the option has no value set in the configuration
# file, the default value set in the command-line will be sent to
# standard output.
test_setCommand "config -e 'greeting' -o 'message' -a 'Hello' ${QATEST_UNIT_DIR}"
