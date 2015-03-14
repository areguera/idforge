#!/bin/bash
######################################################################
#
#   ./QaTests/idforge-render/qatest-2015011135476500711.sh
#
######################################################################

#=====================================================================
# Enter integrity checks target command:
#=====================================================================
QATEST_FLAG_COMMAND="./idforge.sh"

#=====================================================================
# Enter integrity checks target arguments:
#=====================================================================
LANG=en_US.UTF-8 
command_line "--filter='section-id-1' render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter='archive-1.0' render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter='send_plain_mail_using_mailx' render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter='send_signed_mail_using_mailx_and_gpg' render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter='send_encrypted_mail_using_mailx_and_gpg' render ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
