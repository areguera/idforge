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

function svg_printImageSize {

    local CUT_FIELD='1'
    local CUT_DELIMITER='x'

    OPTIND=1
    while getopts "w,h" OPTION "${@}"; do

        case "${OPTION}" in

            w )
                CUT_FIELD="1"
                ;;
            h )
                CUT_FIELD="2"
                ;;
        esac

    done

    # Clean up positional parameters to reflect the fact that options
    # have been processed already.
    shift $(( OPTIND - 1 ))

    # Define list of files we want to retrieve image size from.
    local FILE='' FILES=${@}

    # Verify list of files we want to retrieve image size from. These
    # files don't have to exist because the information is retrieved
    # from their file names.
    [[ -z ${FILES} ]] && return

    # Output size for each file provided.
    for FILE in ${FILES};do

        idforge_printFileName ${FILE} | cut -d ${CUT_DELIMITER} -f ${CUT_FIELD}

    done

}
