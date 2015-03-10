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

function idforge_printLines {

    local HEAD=1
    local TAIL=1

    OPTIND=1
    while getopts "h:,t:" OPTION "${@}"; do
        case ${OPTION} in
            h )
                HEAD=${OPTARG}
                ;;
            t )
                TAIL=${OPTARG}
                ;;
        esac
    done

    # Clean up positional parameters to reflect the fact that options
    # have been processed already.
    shift $(( OPTIND - 1 ))

    echo "${@}" \
        | head -n ${HEAD} | tail -n ${TAIL}

}
