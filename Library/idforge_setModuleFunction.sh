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

# Standardize the way module-related functions are exported to the
# execution environment.
function idforge_setModuleFunction {

    # Define regular expression pattern for both function names and
    # function file names. Only function files and function names
    # matching this pattern will be considered as module-related
    # function.
    local FUNCTION_NAME_REGEX="${IDFORGE_MODULE_NAME}(_[[:alnum:]]+|[[:upper:]][[:alnum:]]+)?"

    # Define regular expression pattern used to retrieve function
    # definitions from function files. Only function files holding
    # function definitions that match this patter will be considered
    # as module-related function.
    local FUNCTION_DEF_REGEX="^function[[:space:]]+${FUNCTION_NAME_REGEX}[[:space:]]+{[[:space:]]*$"

    # Define list of module-related function definition files.
    local FUNCTION_FILE="" FUNCTION_FILES=""; idforge_setModuleFunctionFiles

    # Process list of module-related function definition files.
    for FUNCTION_FILE in ${FUNCTION_FILES};do

        idforge_checkFiles -ex ${FUNCTION_FILE}

        local FUNCTION_NAME=''; idforge_setModuleFunctionName

        . ${FUNCTION_FILE}

        export -f ${FUNCTION_NAME}

        idforge_printMessage "export -f : ${FUNCTION_NAME}" --as-debugger-line

    done

}
