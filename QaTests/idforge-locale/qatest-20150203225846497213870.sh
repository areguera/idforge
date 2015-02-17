#!/bin/bash
######################################################################
#
#   Validate localization of supported formats. It also validates the
#   actions related elimination of automatically generated
#   localization files.
#
#   ------------------------------------------------------------------
#   QaTests/idforge-locale/qatest-20150203225846497213870/Locales/
#   `-- es_ES
#       |-- file.asciidoc.mo
#       |-- file.asciidoc.po
#       |-- file.html.mo
#       |-- file.html.po
#       |-- file.svg.mo
#       |-- file.svg.po
#       |-- hello.svg.mo
#       |-- hello.svg.po
#       |-- hello_world.svg.mo
#       |-- hello_world.svg.po
#       |-- idforge-locale.sh.po
#       |-- idforge.sh.po
#       |-- world.svg.mo
#       `-- world.svg.po
#
#   1 directory, 14 files
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

# Change current locale to a non-English language (e.g., Spanish).
LANG=es_ES.UTF-8;

# Create both PO and MO files from configuration file.
command_line "--filter='file.asciidoc' locale ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter='file.html' locale ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter='file.svg' locale ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter='hello_world.svg' locale ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter='hello_world-2.svg' locale ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter='idforge\$' locale ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"
command_line "--filter='idforge-locale' locale ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"

# Edit the PO file generated from the SVG file. CAUTION: This
# validation must not be performed here. Instead, the command must be
# run outside qatest and tested personally. This is because standard
# output of commands executed inside qatest is redirected to /dev/null
# and so, it is not possible for any editor to grab the information.
#command_line "locale -e ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"

# Remove both PO and MO files generated configuration file.
command_line "locale -d ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"

# Change current locale to English.
LANG=en_US.UTF-8;
