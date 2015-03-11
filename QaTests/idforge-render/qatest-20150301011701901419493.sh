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
# Enter integrity checks target command:
#=====================================================================
QATEST_FLAG_COMMAND="./idforge.sh"

#=====================================================================
# Enter integrity checks target arguments:
#=====================================================================
command_line "--filter='section-id-1' render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"

# Test the action of passing more than one option to idforge.sh
# command-line.
command_line "--debug --filter='manpage.1.gz' render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
