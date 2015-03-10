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

# Print greeting messages and exit successfully.
function hello {

    # Initialize module's flags.
    local HELLO_FLAGS=''

    # Initialize command-line arguments and interpret arguments and
    # options passed through command-line.
    local ARGUMENT='' ARGUMENTS=''; hello_setOptions "${@}"

    # Verify existence of command-line arguments. When they don't
    # exist, just return to caller. This is necessary to print the
    # module's usage information cleanly.
    [[ -z ${ARGUMENTS} ]] && return

    # Execute output child module to process actions for each
    # argument.
    for ARGUMENT in ${ARGUMENTS};do
        idforge_setModuleEnvironment -m 'output' -t 'child' -g "${ARGUMENT}"
    done

}
