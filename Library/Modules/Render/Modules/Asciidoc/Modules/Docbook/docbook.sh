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

# Standardize transformation of asciidoc files into docbook files.
function docbook {

    idforge_printMessage "${RENDER_FROM_ASCIIDOC}" --as-processing-line

    local RENDER_FROM_XML=$(idforge_printTemporalFile ${RENDER_FROM_ASCIIDOC})

    local RENDER_FORMATS=''

    docbook_setInstance

    render_setLocalizedXml

    render_setTmarkers "${RENDER_FROM_XML}"

    idforge_setModuleEnvironment -m "${RENDER_FLOW}" -t "child"

    # Redefine the final file name when you are producing manpages so
    # the file names of all other formats can benefit from it.
    if [[ ${RENDER_FLOW} == 'manpage' ]];then
        local MANPAGE_SECTION=$(head -n 1 ${RENDER_FROM_ASCIIDOC} | sed -r 's,^.+\(([[:digit:]])\)[[:space:]]*$,\1,')
        idforge_checkFiles -m '^[1-8]$' ${MANPAGE_SECTION}
        local RENDER_FILE=${RENDER_FILE}.${MANPAGE_SECTION}
    fi

    for RENDER_FORMAT in ${RENDER_FORMATS};do
        idforge_setModuleEnvironment -m "${RENDER_FORMAT}" -t "sibling"
    done

}
