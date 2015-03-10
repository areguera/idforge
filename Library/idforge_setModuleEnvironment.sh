#!/bin/bash
######################################################################
#
#   idFORGE Framework - Manage identity manuals in community
#   Copyright © 2015 The CentOS Artwork SIG
#
#   idFORGE Framework is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   idFORGE Framework is distributed in the hope that it will be
#   useful, but WITHOUT ANY WARRANTY; without even the implied
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#   See the GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with idFORGE Framework; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <alain.reguera@gmail.com>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Initiate module environments inside the idforge.sh script.
function idforge_setModuleEnvironment {

    local ARG_MODULE_NAME=''
    local ARG_MODULE_TYPE=''
    local ARG_MODULE_ARGS=''

    # Retrieve module's name and module's type from arguments passed
    # through this function positional parameters.
    OPTIND=1
    while getopts "m:,t:,g:" OPTION "${@}"; do
        case "${OPTION}" in
            m ) ARG_MODULE_NAME="${OPTARG}" ;;
            t ) ARG_MODULE_TYPE="${OPTARG}" ;;
            g ) ARG_MODULE_ARGS="${OPTARG} ${ARG_MODULE_ARGS}" ;;
        esac
    done

    # Clean up positional parameters to reflect the fact that options
    # have been processed already.
    shift $(( ${OPTIND} - 1 ))

    # Initialize module's exit status.
    local IDFORGE_MODULE_EXIT=0

    # Initialize module's global counter.
    IDFORGE_MODULE_COUNT=${IDFORGE_MODULE_COUNT:-0}
    idforge_printMessage "=========================>: [${IDFORGE_MODULE_COUNT}] ${FUNCNAME[1]}" --as-debugger-line

    # When the last module in the chain of executed modules is the
    # same module being currently executed, don't create a new
    # position for it in the chain of modules. Instead, use the
    # information it already has from its previous execution. In order
    # for this to work, the current module must be executed as sibling
    # module of other module or itself.
    if [[ ${IDFORGE_MODULE_COUNT} -gt 0 ]];then
        if [[ ${IDFORGE_MODULE_NAMES[((${IDFORGE_MODULE_COUNT} - 1))]} == ${ARG_MODULE_NAME} ]];then
            if [[ ${ARG_MODULE_TYPE} == 'sibling' ]];then
                idforge_printMessage '~~~~~~~~~~~~~~~~~~~~~~~~~> : '"${IDFORGE_MODULE_NAME} ${IDFORGE_MODULE_ARGUMENT}" --as-debugger-line
                ${ARG_MODULE_NAME} ${ARG_MODULE_ARGS} ${@}
                return
            fi
        fi
    fi

    # Define module's base directory. This is the directory where the
    # initialization script is stored in.
    local IDFORGE_MODULE_BASEDIR=${IDFORGE_MODULES}
    if [[ ${#IDFORGE_MODULE_BASEDIRS[*]} -gt 0 ]];then
        if [[ ${ARG_MODULE_TYPE} == "parent" ]];then
            IDFORGE_MODULE_BASEDIR=${IDFORGE_MODULES}
        elif [[ ${ARG_MODULE_TYPE} == "sibling" ]];then
            if [[ ${IDFORGE_MODULE_TYPES[((${IDFORGE_MODULE_COUNT} - 1 ))]} == 'sibling' ]];then
                IDFORGE_MODULE_BASEDIR=${IDFORGE_MODULE_BASEDIRS[((${IDFORGE_MODULE_COUNT}-2))]}
            else
                IDFORGE_MODULE_BASEDIR=${IDFORGE_MODULE_BASEDIRS[((${IDFORGE_MODULE_COUNT}-1))]}
            fi
        else
            IDFORGE_MODULE_BASEDIR=${IDFORGE_MODULE_BASEDIRS[${IDFORGE_MODULE_COUNT}]}
        fi
    fi
    idforge_printMessage "IDFORGE_MODULE_BASEDIR: ${IDFORGE_MODULE_BASEDIR}" --as-debugger-line

    # Define module's name.
    IDFORGE_MODULE_NAMES[${IDFORGE_MODULE_COUNT}]=$(idforge_printFileNameStyle "${ARG_MODULE_NAME:-unknown}" "-f")
    local IDFORGE_MODULE_NAME=${IDFORGE_MODULE_NAMES[${IDFORGE_MODULE_COUNT}]}
    idforge_printMessage "IDFORGE_MODULE_NAME: ${IDFORGE_MODULE_NAME}" --as-debugger-line

    # Define module's type.
    IDFORGE_MODULE_TYPES[${IDFORGE_MODULE_COUNT}]="${ARG_MODULE_TYPE:-parent}"
    local IDFORGE_MODULE_TYPE=${IDFORGE_MODULE_TYPES[${IDFORGE_MODULE_COUNT}]}
    idforge_printMessage "IDFORGE_MODULE_TYPE: ${IDFORGE_MODULE_TYPE}" --as-debugger-line

    # Define module's directory.
    IDFORGE_MODULE_DIRS[${IDFORGE_MODULE_COUNT}]=${IDFORGE_MODULE_BASEDIR}/$(idforge_printFileNameStyle "${IDFORGE_MODULE_NAME}" '-d')
    local IDFORGE_MODULE_DIR=${IDFORGE_MODULE_DIRS[${IDFORGE_MODULE_COUNT}]}
    idforge_printMessage "IDFORGE_MODULE_DIR: ${IDFORGE_MODULE_DIR}" --as-debugger-line

    # Define module's arguments.  This variable is used in different
    # module environments to pass positional parameters from one
    # environment to another using local definitions.
    IDFORGE_MODULE_ARGUMENTS[${IDFORGE_MODULE_COUNT}]="${ARG_MODULE_ARGS:-}"
    local IDFORGE_MODULE_ARGUMENT=${IDFORGE_MODULE_ARGUMENTS[${IDFORGE_MODULE_COUNT}]}
    idforge_printMessage "IDFORGE_MODULE_ARGUMENT: ${IDFORGE_MODULE_ARGUMENT}" --as-debugger-line

    # Define module-specific directories which are not reused from
    # module's parent directory structure.
    IDFORGE_MODULE_DIRS_MODULES[${IDFORGE_MODULE_COUNT}]=${IDFORGE_MODULE_DIR}/Modules
    local IDFORGE_MODULE_DIR_MODULES=${IDFORGE_MODULE_DIRS_MODULES[${IDFORGE_MODULE_COUNT}]}
    idforge_printMessage "IDFORGE_MODULE_DIR_MODULES: ${IDFORGE_MODULE_DIR_MODULES}" --as-debugger-line

    IDFORGE_MODULE_DIRS_CONFIGS[${IDFORGE_MODULE_COUNT}]=${IDFORGE_MODULE_DIR}/Configs
    local IDFORGE_MODULE_DIR_CONFIGS=${IDFORGE_MODULE_DIRS_CONFIGS[${IDFORGE_MODULE_COUNT}]}
    idforge_printMessage "IDFORGE_MODULE_DIR_CONFIGS: ${IDFORGE_MODULE_DIR_CONFIGS}" --as-debugger-line

    # Define module's initialization file.
    IDFORGE_MODULE_INIT_FILES[${IDFORGE_MODULE_COUNT}]=${IDFORGE_MODULE_DIR}/${IDFORGE_MODULE_NAME}.sh
    local IDFORGE_MODULE_INIT_FILE=${IDFORGE_MODULE_INIT_FILES[${IDFORGE_MODULE_COUNT}]}
    idforge_printMessage "IDFORGE_MODULE_INIT_FILE: ${IDFORGE_MODULE_INIT_FILE}" --as-debugger-line

    # Increment module's counter just before creating next module's
    # base directory.
    IDFORGE_MODULE_COUNT=$(( ${IDFORGE_MODULE_COUNT} + 1 ))

    # Run module environment based on collected information.
    idforge_runModuleEnvironment

    # Decrement module counter just after unset unused module
    # environments.
    IDFORGE_MODULE_COUNT=$(( ${IDFORGE_MODULE_COUNT} - 1 ))

    idforge_printMessage "<=========================: [${IDFORGE_MODULE_COUNT}] ${FUNCNAME[1]}" --as-debugger-line

    idforge_printMessage "TEXTDOMAIN: ${TEXTDOMAIN}" --as-debugger-line
    idforge_printMessage "TEXTDOMAINDIR: ${TEXTDOMAINDIR}" --as-debugger-line

    # Unset array and non-array variables used in this function.
    if [[ ${IDFORGE_MODULE_COUNT} -eq 0 ]];then
        unset IDFORGE_MODULE_NAMES
        unset IDFORGE_MODULE_BASEDIRS
        unset IDFORGE_MODULE_DIRS
        unset IDFORGE_MODULE_DIRS_MODULES
        unset IDFORGE_MODULE_DIRS_CONFIGS
        unset IDFORGE_MODULE_NAME
        unset IDFORGE_MODULE_DIR
        unset IDFORGE_MODULE_DIR_MODULES
        unset IDFORGE_MODULE_DIR_CONFIGS
    fi

    # Return based on module's exit status.
    return ${IDFORGE_MODULE_EXIT}

}
