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
export LANG=es.UTF-8

#=====================================================================
# Enter integrity checks target models:
#=====================================================================
export IDFORGE_MODELS=$(dirname ${0})/Library/Messages

#=====================================================================
# Enter integrity checks target command:
#=====================================================================
QATEST_FLAG_COMMAND="${0}"

#=====================================================================
# Enter integrity checks target workplace:
#=====================================================================
local QATEST_WORKPLACE=${IDFORGE_TEMPDIR}/qatest-workplace-${RANDOM}

if [[ ! -d ${QATEST_WORKPLACE} ]];then
    command_line "prepare ${QATEST_WORKPLACE}"
fi

pushd ${QATEST_WORKPLACE}

#=====================================================================
# Enter integrity checks target arguments:
#=====================================================================

# Reset models to match configuration files. This is necessary because
# the configuration file and shell scripts are in different locations.
# In this cases, it is necessary to specify a location for
# idforge-prepare to create the workplace, and another location for
# idforge-render to find the shell scripts defined in the
# configuration file.
export IDFORGE_MODELS=$(dirname ${0})/Library

local QATEST_CONFIG_FILE=''
local QATEST_CONFIG_FILES=$(idforge_printFileList -t f -p '.+\.conf$' ${PWD})

for QATEST_CONFIG_FILE in ${QATEST_CONFIG_FILES};do

    local QATEST_CONFIG_SECTION=''
    local QATEST_CONFIG_SECTIONS=$(egrep '^\[' ${QATEST_CONFIG_FILE} | tr -d [ | tr -d ])

    for QATEST_CONFIG_SECTION in ${QATEST_CONFIG_SECTIONS};do
        # Test PO file creation
        command_line "--filter=^${QATEST_CONFIG_SECTION}\$ locale ${QATEST_CONFIG_FILE}"
        # Test PO file actualization
        command_line "--filter=^${QATEST_CONFIG_SECTION}\$ locale ${QATEST_CONFIG_FILE}"
    done

done

popd
