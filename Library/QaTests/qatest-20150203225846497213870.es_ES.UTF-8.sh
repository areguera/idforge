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
# Enter integrity checks target locale:
#=====================================================================
LANG=es_ES.UTF-8

#=====================================================================
# Enter integrity checks target command:
#=====================================================================
QATEST_FLAG_COMMAND="${0}"

#=====================================================================
# Enter integrity checks target arguments:
#=====================================================================
local QATEST_CONFIG_SECTION=''
local QATEST_CONFIG_SECTIONS=$(egrep '^\[' ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf | tr -d [ | tr -d ])

for QATEST_CONFIG_SECTION in ${QATEST_CONFIG_SECTIONS};do
    # Create both PO and MO files from configuration file.
    command_line "--filter=^${QATEST_CONFIG_SECTION}\$ locale ${QATEST_CONFIG_FILE}"

    # Edit the PO file generated from the SVG file. CAUTION: This
    # validation must not be performed here. Instead, the command must
    # be run outside qatest and tested personally. This is because the
    # standard output of commands executed inside qatest is redirected
    # to /dev/null and so, it is not possible for any editor to grab
    # the information.
    #command_line "--filter=^${QATEST_CONFIG_SECTION}\$ locale -e ${QATEST_CONFIG_FILE}"

    # Remove both PO and MO files generated configuration file.
    command_line "--filter=^${QATEST_CONFIG_SECTION}\$ locale -d ${QATEST_CONFIG_FILE}"

done

[[ -d ${QATEST_UNIT_DIR}/Locales ]] && rm -r ${QATEST_UNIT_DIR}/Locales
