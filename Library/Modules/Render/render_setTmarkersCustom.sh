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

function render_setTmarkersCustom {

    local RENDER_MARK=""   ; render_setConfigOption 'render-mark'

    [[ -z ${RENDER_MARK} ]] && return

    # Create a new line for each marker and its value so they can be
    # processed individually line by line.
    local RENDER_MARKS="$(echo ${RENDER_MARK} | sed -r 's,[[:space:]]+=,\n=,g')"

    local RENDER_MARKS_TOTAL=$(echo "${RENDER_MARKS}" | wc -l)

    local RENDER_MARKS_REGEX='^(=[[:upper:]_]+=)(.+)$'

    local RENDER_MARKS_COUNT=1

    # Define the translation marker and its expansion value.
    while [[ ${RENDER_MARKS_COUNT} -le ${RENDER_MARKS_TOTAL} ]];do
        SRC[((++${#SRC[*]}))]=$(idforge_printLines -h ${RENDER_MARKS_COUNT} "${RENDER_MARKS}" | sed -r "s,${RENDER_MARKS_REGEX},\1,")
        DST[((++${#DST[*]}))]=$(idforge_printLines -h ${RENDER_MARKS_COUNT} "${RENDER_MARKS}" | sed -r "s,${RENDER_MARKS_REGEX},\2,")
        RENDER_MARKS_COUNT=$((++RENDER_MARKS_COUNT))
    done

}
