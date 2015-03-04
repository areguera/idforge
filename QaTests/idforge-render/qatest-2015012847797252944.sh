#!/bin/bash
######################################################################
#
#   ./QaTests/idforge-render//qatest-2015012847797252944.sh
#
######################################################################

#=====================================================================
# Enter integrity checks target command:
#=====================================================================
QATEST_FLAG_COMMAND="./idforge.sh"

#=====================================================================
# Enter integrity checks target arguments:
#=====================================================================
# Go section by section considering those subject to localization.
command_line "--filter="idforge-logo.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter="idforge-logo-message.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter="idforge-symbol.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter="idforge-symbol-bg.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter="715x940.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
LANG=es_ES.UTF-8
command_line "--filter="document-copyright.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
LANG=en_US.UTF-8
command_line "--filter="document-copyright.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter="765x990.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter="443x443.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter="443x443-symlink.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter="443x443-branded.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
LANG=es_ES.UTF-8
command_line "--filter="document-media.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter="document.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
LANG=en_US.UTF-8
command_line "--filter="document-media.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter="document.png" render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
