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

# Standardize content rendition.
function render {

    # Initialize command-line arguments and interpret arguments and
    # options passed through command-line.
    local ARGUMENTS=''; render_setOptions "${@}"

    # Verify common-options that we expect to terminate the script
    # execution successfully.
    [[ ${IDFORGE_MODULE_FLAG_HELP} == 'true' ]] \
        || [[ ${IDFORGE_MODULE_FLAG_VERSION} == 'true' ]] \
        || [[ ${IDFORGE_MODULE_FLAG_DESCRIPTION} == 'true' ]] \
        && return

    # Initialize configuration files processing.
    local CONFIG_FILE='' CONFIG_FILES=$(render_printConfigFiles "${ARGUMENTS}")

    # Verify configuration files.
    idforge_checkFiles -e ${CONFIG_FILES}

    # Process configuration files.
    for CONFIG_FILE in "${CONFIG_FILES}"; do

        idforge_printMessage "${CONFIG_FILE}" --as-processing-line

        render_setConfigSections

    done

}
