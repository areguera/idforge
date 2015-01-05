#!/bin/bash
######################################################################
#
#   idforge - Manage identity manuals in community.
#   Copyright © 2015 CentOS Artwork SIG
#
#   idforge is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   idforge is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with idforge; if not, write to the Free Software Foundation,
#   Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <alain.reguera@gmail.com>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

function idforge_runModuleEnvironment {

    # Initialize current module's text domain. This is the name of the
    # last parent module in the chain of modules.
    local TEXTDOMAIN="${IDFORGE}" ; idforge_setModuleTextDomain

    idforge_printMessage "TEXTDOMAIN: ${TEXTDOMAIN}" --as-debugger-line
    idforge_printMessage "TEXTDOMAINDIR: ${TEXTDOMAINDIR}" --as-debugger-line

    # Print usage information when no argument is provided to a
    # module's command-line.  This applies to parent modules only.
    if [[ ${IDFORGE_MODULE_NAME} != 'usage' ]] && [[ -z ${IDFORGE_MODULE_ARGUMENT} ]] && [[ ${#FUNCNAME[*]} -eq 4 ]];then
        idforge_setModuleEnvironment -m 'usage' -g "${IDFORGE_MODULE_NAME}" -g "${IDFORGE_MODULE_DIR}"
        return
    fi

    # Define next module's base directory.
    IDFORGE_MODULE_BASEDIRS[${IDFORGE_MODULE_COUNT}]=${IDFORGE_MODULE_DIR_MODULES}

    # Check function script execution rights.
    idforge_checkFiles -ex ${IDFORGE_MODULE_INIT_FILE}

    # Load module-specific (function) scripts into current
    # execution environment.  Keep this function call after all
    # variables and arguments definitions.
    idforge_setModuleFunction

    # Execute module's initialization script with its arguments.
    idforge_printMessage '-------------------------> : '"${IDFORGE_MODULE_NAME} ${IDFORGE_MODULE_ARGUMENT}" --as-debugger-line
    ${IDFORGE_MODULE_NAME} ${IDFORGE_MODULE_ARGUMENT}

    # Unset module-specific environment.
    idforge_printMessage '<------------------------- : '"${IDFORGE_MODULE_NAME} ${IDFORGE_MODULE_ARGUMENT}" --as-debugger-line
    idforge_unsetModuleEnvironment

}
