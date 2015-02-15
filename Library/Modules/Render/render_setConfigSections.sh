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

function render_setConfigSections {

    idforge_checkFiles -efm '\.conf$' "${CONFIG_FILE}"

    idforge_printMessage "${CONFIG_FILE}" --as-processing-line

    local CONFIG_SECTIONS=$(render_printConfigSections)

    [[ -z ${CONFIG_SECTIONS} ]] && return

    # Process sections found in the configuration file.
    for CONFIG_SECTION in ${CONFIG_SECTIONS};do

        # Initialize the configuration options. CAUTION! The order in
        # which these variables are defined is relevant because some
        # of them are dependent one another.
        local -a RENDER_FROM_PO     ; render_setConfigOption 'render-from-po'
        local RENDER_DIRECTORY=''   ; render_setConfigOption 'render-directory'
        local RENDER_FILE=''        ; render_setConfigOption 'render-file'
        local -a RENDER_FROM        ; render_setConfigOption 'render-from'
        local RENDER_TYPE=''        ; render_setConfigOption 'render-type'
        local RENDER_LOGIC=''       ; render_setConfigOption 'render-logic'

        idforge_setModuleEnvironment -m ${RENDER_TYPE} -t 'child'

        # Reset array variables to avoid undesired concatenations of
        # their values between different sections blocks in the same
        # configuration file.
        unset RENDER_FROM_PO
        unset RENDER_FROM

    done

    # Reset array variables to avoid undesired concatenations between
    # configuration files.
    unset CONFIG_SECTIONS

    # Execute make files to final files produced.
    idforge_setModuleEnvironment -m 'make' -t 'child'

}
