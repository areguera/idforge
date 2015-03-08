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

# Initialize files processing based on the information provided by the
# configuration files passed in the command-line.
function locale_setConfigSections {

    idforge_checkFiles -efm '\.conf$' "${CONFIG_FILE}"

    idforge_printMessage "${CONFIG_FILE}" --as-processing-line

    local CONFIG_SECTIONS=$(locale_printConfigSections)

    [[ -z ${CONFIG_SECTIONS} ]] && return

    # Process sections found in the configuration file.
    for CONFIG_SECTION in ${CONFIG_SECTIONS};do

        local -a RENDER_FROM_PO    ; locale_setConfigOption 'render-from-po'
        local RENDER_DIRECTORY=''  ; locale_setConfigOption 'render-directory'

        if [[ ${LOCALE_FLAG_EDIT} == 'true' ]];then
            idforge_setModuleEnvironment -m 'edit' -t 'child'
        elif [[ ${LOCALE_FLAG_DELETE} == 'true' ]];then
            idforge_setModuleEnvironment -m 'delete' -t 'child'
        else
            idforge_setModuleEnvironment -m 'update' -t 'child'
        fi

        # Unset array variables to avoid undesired concatenations of
        # their values between different sections blocks in the same
        # configuration file.
        unset RENDER_FROM_PO

    done

}

