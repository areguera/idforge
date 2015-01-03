#!/bin/bash
######################################################################
# 
#   qatest configuration file for testing idforge-libconfig scripts.
#
######################################################################

#======================================================================
# Command-line
#======================================================================
test_setCommand config
test_setCommand config --help
test_setCommand config --version
test_setCommand config --description

#======================================================================
# Retrieve configuration files from directory
#======================================================================
test_setCommand config ${QATEST_UNIT_DIR}

#======================================================================
# Retrieve section names from configuration files
#======================================================================
# In this case, all configuration sections matching the section
# pattern, inside all configuration files found, will be printed to
# standard output. 
test_setCommand config -e 'greeting' ${QATEST_UNIT_DIR}

#======================================================================
# Retrieve option value from specific section
#======================================================================
# Without default value. In this case, when the option has no value
# set in the configuration file, an empty value is sent to standard
# output.
test_setCommand config -e 'greeting' -o 'message' ${QATEST_UNIT_DIR}
# With default value. In this case, when the option has no value set
# in the configuration file, the default value set in the command-line
# will be sent to standard output.
test_setCommand config -e 'greeting' -o 'message' -a 'Hello' ${QATEST_UNIT_DIR}
