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
LANG=en_US.UTF-8

#=====================================================================
# Enter integrity checks target command:
#=====================================================================
QATEST_FLAG_COMMAND="${0}"

#=====================================================================
# Enter integrity checks target workplace:
#=====================================================================
local QATEST_WORKPLACE=${IDFORGE_TEMPDIR}/qatest-workplace

if [[ ! -d ${QATEST_WORKPLACE} ]];then
    command_line "prepare ${QATEST_WORKPLACE}"
fi

pushd ${QATEST_WORKPLACE}

#=====================================================================
# Enter integrity checks target arguments:
#=====================================================================
command_line "render"
command_line "render --description"
command_line "render --version"

local QATEST_CONFIG_FILE=''
local QATEST_CONFIG_FILES=$(idforge_printFileList -t f -p '.+\.conf$' ${PWD})

for QATEST_CONFIG_FILE in ${QATEST_CONFIG_FILES};do

    local QATEST_CONFIG_SECTION=''
    local QATEST_CONFIG_SECTIONS=$(egrep '^\[' ${QATEST_CONFIG_FILE} | tr -d [ | tr -d ])

    for QATEST_CONFIG_SECTION in ${QATEST_CONFIG_SECTIONS};do
        command_line "--filter=^${QATEST_CONFIG_SECTION}\$ render ${QATEST_CONFIG_FILE}"
    done

done

popd
