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

function qatest {

    # Initialize module flags.
    local QATEST_FLAG_COMMAND="/usr/bin/${IDFORGE}"
    local QATEST_FLAG_ADD='false'
    local QATEST_FLAG_UPDATE='false'
    local QATEST_FLAG_MIME='false'
    local QATEST_FLAG_CHECKSUM='false'

    # Initialize command-line arguments and interpret arguments and
    # options passed through command-line.
    local ARGUMENT='' ARGUMENTS=''; qatest_setOptions "${@}"

    # Verify existence of command-line arguments. When they don't
    # exist, just return to caller. This is necesary to print the
    # module's usage information cleanly.
    [[ -z ${ARGUMENTS} ]] && return

    # Verify command-line arguments. They must be directories.
    # Otherwise, stop script execution with an error message.
    idforge_checkFiles -d ${ARGUMENTS}

    # Process command-line arguments.
    for ARGUMENT in ${ARGUMENTS};do
        if [[ ${QATEST_FLAG_ADD} == 'true' ]];then
            idforge_setModuleEnvironment -m 'add' -t 'child'
        else
            idforge_setModuleEnvironment -m 'run' -t 'child'
        fi
    done

}
