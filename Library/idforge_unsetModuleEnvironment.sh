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

# Unset functions exported to idforge.sh script execution environment.
function idforge_unsetModuleEnvironment {

    # Define the localization domain for this function.
    local TEXTDOMAIN="${IDFORGE}"

    # Verify suffix value used to retrieve function files.
    if [[ -z ${IDFORGE_MODULE_NAME} ]];then
        idforge_printMessage "`gettext "The module name was not provided."`" --as-error-line
    fi

    # Define list of format-specific functionalities. This is the list
    # of function definitions previously exported by
    # `idforge_setModuleFunctions'.  Be sure to limit the list to
    # function names that start with the suffix specified only.
    local IDFORGE_MODULE_IDFORGE_FN=''
    local IDFORGE_MODULE_IDFORGE_FNS=$(declare -F | gawk '{ print $3 }' | egrep "^${IDFORGE_MODULE_NAME}")

    # Unset function names from current execution environment.
    for IDFORGE_MODULE_IDFORGE_FN in ${IDFORGE_MODULE_IDFORGE_FNS};do
        unset -f ${IDFORGE_MODULE_IDFORGE_FN}
        idforge_printMessage "unset -f : ${IDFORGE_MODULE_IDFORGE_FN}" --as-debugger-line
    done

}
