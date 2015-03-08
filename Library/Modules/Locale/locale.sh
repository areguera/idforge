#!/bin/bash
######################################################################
#
#   idFORGE Framework - Manage identity manuals in community
#   Copyright © 2015 CentOS Artwork SIG
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

function locale {

    # Initialize module's flags.
    local LOCALE_FLAG_EDIT='false'
    local LOCALE_FLAG_DELETE='false'

    # Initialize command-line arguments and interpret arguments and
    # options passed through command-line.
    local ARGUMENT='' ARGUMENTS=''; locale_setOptions "${@}"

    # Verify existence of command-line arguments. When they don't
    # exist, just return to caller. This is necessary to print the
    # module's usage information cleanly.
    [[ -z ${ARGUMENTS} ]] && return

    # Initialize list of configuration files based on arguments
    # provided in the command-line.
    local CONFIG_FILE='' CONFIG_FILES=$(locale_printConfigFiles "${ARGUMENTS}")

    # Process list of configuration files.
    for CONFIG_FILE in "${CONFIG_FILES}"; do
        locale_setConfigSections
    done

}
