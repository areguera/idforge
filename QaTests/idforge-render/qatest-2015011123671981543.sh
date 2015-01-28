#!/bin/bash
######################################################################
#
#  This test verifies production of documentation manuals in several
#  formats from configuration files.
#
######################################################################

#=====================================================================
# Enter integrity checks target command:
#=====================================================================
QATEST_FLAG_COMMAND="./idforge.sh"

#=====================================================================
# Enter integrity checks target arguments:
#=====================================================================
test_setCommand "render ./QaTests/idforge-render/${QATEST_UNIT_NAME}/${QATEST_UNIT_NAME}.conf"
