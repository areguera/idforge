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

# Initialize files processing based on the information provided by the
# configuration files passed in the command-line.
function locale_setConfigSections {

    idforge_checkFiles -efm '\.conf$' "${CONFIG_FILE}"

    idforge_printMessage "${CONFIG_FILE}" --as-processing-line

    local CONFIG_SECTIONS=$(locale_printConfigSections)

    [[ -z ${CONFIG_SECTIONS} ]] && return

    # Process sections found in the configuration file.
    for CONFIG_SECTION in ${CONFIG_SECTIONS};do

        local -a LOCALE_FROM    ; locale_setConfigOption 'locale-from'
        local -a RENDER_FROM    ; locale_setConfigOption 'render-from'

        idforge_setModuleEnvironment -m ${RENDER_TYPE} -t 'child'

        COUNT=$(( ++COUNT ))

        # Reset array variable related to section content to avoid
        # undesired concatenations of their values between different
        # sections blocks.
        unset RENDER_FROM
        unset LOCALE_FROM

    done

    # Reset array variables to avoid undesired concatenations between
    # configuration files.
    unset SECTIONS

    # Execute make files to final files produced.
    idforge_setModuleEnvironment -m 'make' -t 'child'

}

