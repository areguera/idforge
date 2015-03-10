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

# This function searches translation markers in a given file.
function xml_printMarkers {

    local MARKERS_FILTER=''

    # Initialize option locally.
    local OPTION=''

    # Initialize option index locally.
    OPTIND=1

    # Initialize option parser.
    while getopts "f:" OPTION "${@}"; do

        case "${OPTION}" in
            f )
                MARKERS_FILTER="${OPTARG}"
                ;;
        esac

    done

    # Clean up positional parameters to reflect the fact that options
    # have been processed already.
    shift $(( OPTIND - 1 ))

    # Define list of files we want to apply verifications to, now that
    # all option-like arguments have been removed from positional
    # parameters list so we are free to go with the verifications.
    local FILES=${@}

    # Verify existence of files where translation markers will be
    # searched in.
    idforge_checkFiles -ef ${FILES}

    # Define list of translation markers found inside the design
    # model.
    local MARKERS=$(\
        egrep "xlink:href=\"=[[:upper:][:digit:]_]+=\"" ${FILES} \
            | sed -r "s,.+=\"(=[[:upper:][:digit:]_]+=)\".*,\1," | sort | uniq )

    # Apply filter to the list of translation markers found inside the
    # design model.
    if [[ -n "${MARKERS_FILTER}" ]];then
       MARKERS=$(echo "${MARKERS}" | grep "${MARKERS_FILTER}")
    fi

    # Output the final list of translation markers found.
    echo "${MARKERS}"

}
