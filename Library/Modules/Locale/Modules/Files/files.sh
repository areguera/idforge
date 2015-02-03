#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository
#   Copyright © 2014 The CentOS Artwork SIG
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

# Set file-specific information needed by localization actions and
# executes the actions requested through the command-line.
function files {

    local CONFIGURATION="${1}"

    idforge_checkFiles -efm '\.conf$' ${CONFIGURATION}

    local -a SECTIONS; idforge_setConfigSections

    local COUNT=0

    while [[ ${COUNT} -lt ${#SECTIONS[*]} ]];do

        local SECTION=${SECTIONS[${COUNT}]}

        local RENDER_TYPE=''; files_setConfigOption 'render-type'

        local -a RENDER_FROM; files_setConfigOption 'render-from'

        local RENDER_FLOW=''; files_setConfigOption 'render-flow'

        local -a LOCALE_FROM; files_setConfigOption 'locale-from'

        local -a LOCALE_MO  ; files_setConfigOption 'locale-mo'

        files_setActions

        COUNT=$(( ++COUNT ))

    done

    # Reset array variables to avoid undesired concatenations between
    # configuration files.
    unset SECTIONS

}
