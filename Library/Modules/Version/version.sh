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

function version {

    # Initialize module's flags.
    # ...

    # Initialize module command-line and interpret both arguments and
    # options passed through through it.
    local ARGUMENT='' ARGUMENTS=''; version_setOptions "${@}"

    # Verify existence of command-line arguments. When they don't
    # exist, just return to caller. This is necessary to print the
    # module's usage information cleanly.
    [[ -z ${ARGUMENTS} ]] && return

    for ARGUMENT in ${ARGUMENTS};do
        idforge_setModuleEnvironment -t 'child' -m 'status' -g ${ARGUMENT}
    done

}
