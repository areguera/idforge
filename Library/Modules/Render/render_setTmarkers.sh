#!/bin/bash
######################################################################
#
#   idforge - Manage corporate identity manuals in community.
#   Copyright © 2015 CentOS Artwork SIG
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

# Standardize construction of translation markers and their related
# expansion. As convention, translation markers must be set inside
# source files (e.g., Docbook, Svg, etc.) and expanded inside temporal
# instances used to produce final contents.
function render_setTmarkers {

    # Initialize variables.
    local -a SRC
    local -a DST
    local COUNT=0

    # Define source location were translation markers expansion will
    # take place on.
    local LOCATION="${1}"

    # Verify that the source location does exist.
    idforge_checkFiles -ef ${LOCATION}

    # Define translation markers that will always be expanded.
    render_setTmarkersDefault

    # Define translation markers that will be expanded based on
    # configuration files' options.
    render_setTmarkersCustom

    # Do replacement of nested translation markers.
    render_setTmarkersNested

    # Apply replacements for default translation markers.
    while [[ ${COUNT} -lt ${#SRC[*]} ]];do
        sed -r -i "s!${SRC[${COUNT}]}!${DST[${COUNT}]}!g" ${LOCATION}
        COUNT=$((++COUNT))
    done

    # Remove escaped character from translation markers. This is one
    # of the reasons why translation marker should be expanded in
    # source files instances not the source files themselves.
    # Escaping translation markers provides a way of talking about
    # them without expanding them.
    sed -r -i 's/(=)\\([[:upper:]_]+=)/\1\2/g' ${LOCATION}

    # Unset specific translation markers and specific replacement
    # variables in order to clean them up. Otherwise, undesired values
    # may remain from one file to another.
    unset SRC
    unset DST

}
