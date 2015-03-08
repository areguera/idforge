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

# Output the absolute path you need to use to create temporal files to
# standard output.  Use this function whenever you need to create new
# temporal files inside idforge.sh script.
function idforge_printTemporalFile {

    # Define the localization domain for this function.
    local TEXTDOMAIN="${IDFORGE}"

    # Define base name for temporal file. This is required when svg
    # instances are created previous to be parsed by inkscape in order
    # to be exported as png. In such cases .svg file extension is
    # required in order to avoid complains from inkscape.
    local FILENAME="${RANDOM}${RANDOM}-$(idforge_printFileNameStyle ${1} -f)"

    # Check default base name for temporal file, it can't be an empty
    # value.
    if [[ -z "${FILENAME}" ]];then
        idforge_printMessage "`gettext "The first argument cannot be empty."`" --as-error-line
    fi

    # Define absolute path for temporal file and send it out to
    # standard output.
    echo "${IDFORGE_TEMPDIR}/${FILENAME}"

}
