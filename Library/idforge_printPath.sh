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

# Print non-option arguments passed through the command-line for
# further processing.
function idforge_printPath {

    # Define base directory's default value.
    local BASEDIR="${PWD}"

    # Define the function's options.
    OPTIND=1
    while getopts "b:" OPTION "${@}"; do

        case "${OPTION}" in

             b )
                BASEDIR=${OPTARG}
                ;;

        esac

    done

    # Clean up positional parameters to reflect the fact that options
    # have been processed already.
    shift $(( ${OPTIND} - 1 ))

    # Retrieve all locations passed as non-option arguments to this
    # function.
    local LOCATIONS="${@}"

    for LOCATION in ${LOCATIONS};do

        # Concatenate both base directory and provided location to
        # build the final path.
        if [[ ${BASEDIR} =~ ^/ && ! ${LOCATION} =~ ^/ ]];then
            LOCATION=${BASEDIR}/${LOCATION}
        fi

        # Remove consecutive slashes, trailing slashes and any
        # dot-slash or double-dot slash constructions from final
        # location.
        echo "${LOCATION}" \
            | sed -r -e 's,\.+/?$,,g' -e 's,\.+/,,g' -e 's,/+,/,g' \
                     -e 's,/+$,,g'

    done

}
