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

# Standardize source files maintenance.
function tuneup {

    # Initialize module's flags.
    # ...

    # Initialize command-line arguments and interpret arguments and
    # options passed through command-line.
    local ARGUMENT='' ARGUMENTS=''; tuneup_setOptions "${@}"

    # Verify existence of command-line arguments. When they don't
    # exist, just return to caller. This is necessary to print the
    # module's usage information cleanly.
    [[ -z ${ARGUMENTS} ]] && return

    # Verify command-line arguments to be sure they are directories.
    idforge_checkFiles -ed ${ARGUMENTS}

    local INKSCAPE_COMMANDS=''

    # Process list of configuration files.
    for ARGUMENT in ${ARGUMENTS};do

        local TUNEUP_FILE='' 
        local TUNEUP_FILES=$(idforge_printFileList -t 'f' -p '.+\.svg$' ${ARGUMENT})

        for TUNEUP_FILE in ${TUNEUP_FILES}; do
            idforge_printMessage "${TUNEUP_FILE}" --as-tuningup-line
            INKSCAPE_COMMANDS="${INKSCAPE_COMMANDS} $(echo "--vacuum-defs --export-plain-svg=${TUNEUP_FILE} ${TUNEUP_FILE}")\n"
        done

    done

    [[ -n ${INKSCAPE_COMMANDS} ]] \
        && echo -e "${INKSCAPE_COMMANDS}" | /usr/bin/inkscape --shell > /dev/null

}
