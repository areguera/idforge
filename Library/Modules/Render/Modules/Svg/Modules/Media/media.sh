#!/bin/bash
######################################################################
#
#   idforge - Manage identity manuals in community.
#   Copyright © 2015 CentOS Artwork SIG
#
#   idforge is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   idforge is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with idforge; if not, write to the Free Software Foundation,
#   Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <alain.reguera@gmail.com>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

function media {

    [[ -z ${SVG_FLOW_OPTIONS} ]] \
        && idforge_printMessage "`gettext "The flow options were not provided."`" --as-error-line

    local MEDIA_VERSIONS="$(echo ${SVG_FLOW_OPTIONS} | cut -d: -f1 | tr ',' ' ')"
    local MEDIA_ARCHITECTURES="$(echo ${SVG_FLOW_OPTIONS} | cut -d: -f2 | tr ',' ' ')"
    local MEDIA="$(echo ${SVG_FLOW_OPTIONS} | cut -d: -f3 | tr ',' ' ')"

    for MEDIUM in ${MEDIA};do

        local MEDIA_TYPE="$(echo ${MEDIUM} | cut -d'*' -f1)"
        idforge_checkFiles -m '^[[:alnum:]]+$' "${MEDIA_TYPE}"

        local MEDIA_NUMBER_FIRST=1

        local MEDIA_NUMBER_LAST=$(echo ${MEDIUM} | cut -d'*' -f2)
        idforge_checkFiles -m '^[[:digit:]]+$' "${MEDIA_NUMBER_LAST}"

        local MEDIA_NUMBER_CURRENT=${MEDIA_NUMBER_FIRST}

        while [[ ${MEDIA_NUMBER_CURRENT} -le ${MEDIA_NUMBER_LAST} ]];do
            for MEDIA_VERSION in ${MEDIA_VERSIONS};do
                for MEDIA_ARCHITECTURE in ${MEDIA_ARCHITECTURES};do
                    INKSCAPE_INPUT=$(idforge_printTemporalFile ${RENDER_FROM_INSTANCE})
                    install -Tp ${RENDER_FROM_INSTANCE} ${INKSCAPE_INPUT}
                    media_expandMarkers
                    local INKSCAPE_OUTPUT=$(dirname ${RENDER_FILE})/$(idforge_printFileName ${RENDER_FILE})-${MEDIA_VERSION}-${MEDIA_ARCHITECTURE}-${MEDIA_TYPE}${MEDIA_NUMBER_CURRENT}of${MEDIA_NUMBER_LAST}.$(idforge_printFileExtension ${RENDER_FILE})
                    svg_setInkscapeCommand
                done
            done
            MEDIA_NUMBER_CURRENT=$(( ++MEDIA_NUMBER_CURRENT ))
        done
    done

}
