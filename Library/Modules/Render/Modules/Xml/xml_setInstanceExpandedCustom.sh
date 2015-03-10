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

function xml_setInstanceExpandedCustom {

    local XML_EXPAND=''         ; xml_setConfigOption 'xml-expand'

    [[ -z ${XML_EXPAND} ]] && return

    # Create a new line for each marker and its value so they can be
    # processed individually line by line.
    local XML_EXPAND_LINES="$(echo ${XML_EXPAND} | sed -r 's,[[:space:]]+=,\n=,g')"

    local XML_EXPAND_LINES_TOTAL=$(echo "${XML_EXPAND_LINES}" | wc -l)
    local XML_EXPAND_LINES_REGEX='^(=[[:upper:]_]+=)(.+)$'
    local XML_EXPAND_LINES_COUNT=1

    # Define the translation marker and its expansion value.
    while [[ ${XML_EXPAND_LINES_COUNT} -le ${XML_EXPAND_LINES_TOTAL} ]];do
        SRC[((++${#SRC[*]}))]=$(idforge_printLines -h ${XML_EXPAND_LINES_COUNT} "${XML_EXPAND_LINES}" | sed -r "s,${XML_EXPAND_LINES_REGEX},\1,")
        DST[((++${#DST[*]}))]=$(idforge_printLines -h ${XML_EXPAND_LINES_COUNT} "${XML_EXPAND_LINES}" | sed -r "s,${XML_EXPAND_LINES_REGEX},\2,")
        XML_EXPAND_LINES_COUNT=$((++XML_EXPAND_LINES_COUNT))
    done

}
