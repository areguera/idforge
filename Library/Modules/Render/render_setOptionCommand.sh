#!/bin/bash
######################################################################
#
#   idforge - Manage identity manuals in community.
#   Copyright © 2015 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <alain.reguera@gmail.com>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Standardize interpretation of values related to "command" options
# provided inside configuration files. By default all arguments except
# the last one are considered source files. The last file is
# considered the target file.
function render_setOptionCommand {

    # Define the total number of parameters considered source files.
    # This all arguments except the last one.
    local TOTAL_SOURCE_FILES=$(( ${#} - 1 ))

    # Define list of source files from positional parameters.
    local -a SOURCE_FILES; local COUNT=0
    if [[ ${TOTAL_SOURCE_FILES} -gt 1 ]];then
        while [[ ${COUNT} -lt ${TOTAL_SOURCE_FILES} ]];do
            SOURCE_FILES[${COUNT}]="${1}"
            COUNT=$(( ++COUNT ))
            shift 1
        done
    else
        SOURCE_FILES[${COUNT}]=${1}; shift 1
    fi

    # Define target file from positional parameters.
    local TARGET_FILE=${1}; shift 1
    [[ -z ${TARGET_FILE} ]] && idforge_printMessage "The target location cannot be empty." --as-error-line

    # Define value of "command" option.
    local COMMAND=''; render_setConfigOption 'command'

    # Define target file's parent directory.
    idforge_setParentDir "${TARGET_FILE}"

    idforge_printMessage "${TARGET_FILE}" --as-creating-line

    # Execute command with source and target files.
    eval ${COMMAND} ${SOURCE_FILES[*]} ${TARGET_FILE}

    # Unset array variables to prevent undesired concatenations.
    unset SOURCE_FILES

}
