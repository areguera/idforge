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

# Standardize construction of translation markers and their related
# expansion. As convention, translation markers must be set inside
# source files (e.g., Docbook, Svg, etc.) and expanded inside temporal
# instances used to produce final contents.
function xml_setInstanceExpanded {

    # Initialize variables.
    local -a SRC
    local -a DST

    # Verify that the source location does exist.
    idforge_checkFiles -ef ${RENDER_FROM_INSTANCES[${OPTION}]}

    # Define translation markers that will always be expanded.
    xml_setInstanceExpandedDefault

    # Define translation markers that will be expanded based on
    # configuration files' options.
    xml_setInstanceExpandedCustom

    # Do replacement of nested translation markers.
    xml_setInstanceExpandedNested

    # Apply replacements for default translation markers.
    xml_setInstanceExpandedCommand

    # Unset specific translation markers and specific replacement
    # variables in order to clean them up. Otherwise, undesired values
    # may remain from one file to another.
    unset SRC
    unset DST

}
