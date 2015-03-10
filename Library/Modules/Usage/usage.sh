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

function usage {

    # Initialize module's flags.
    local USAGE_FLAG_RETURN='no'

    # Initialize module command-line and interpret both arguments and
    # options passed through through it.
    local ARGUMENT='' ARGUMENTS=''; usage_setOptions "${@}"

    # Define whether to continue or return to caller. Normally, this
    # module doesn't return to its caller at this point unless any of
    # the --help, --version or --description command-line options are
    # provided when it was called.
    [[ ${USAGE_FLAG_RETURN} == 'yes' ]] && return

    # Define absolute path to function where command-line options will
    # be retrieved from. It is required that the function you provide
    # does be defined and use the standard format adopted by
    # idforge.sh script.
    local USAGE_OPTIONS_FILE=${1:-${IDFORGE_LIBRARY}/${IDFORGE}_setOptions.sh}

    # Verify the existence of the file provided.
    idforge_checkFiles -ef ${USAGE_OPTIONS_FILE}

    # Print usage information based on collected information.
    idforge_setModuleEnvironment -t 'child' -m 'synopsis'

}
