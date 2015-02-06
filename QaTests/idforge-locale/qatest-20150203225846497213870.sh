#!/bin/bash
######################################################################
#
#   Validate localization of supported formats. It also validates the
#   actions related elimination of automatically generated
#   localization files.
#
#   ------------------------------------------------------------------
#   ${QATEST_UNIT_DIR}/
#   `-- Locales/
#       `-- es_ES/
#           |-- asciidoc.po
#           |-- asciidoc.mo
#           |-- svg.po
#           |-- svg.mo
#           |-- html.po
#           `-- html.mo
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
command_line "locale ${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.conf"

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
