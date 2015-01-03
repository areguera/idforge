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

function media_setRenditionBase {

    local -a SOURCE_INSTANCES

    SOURCE_INSTANCES[${RENDER_FROM_COUNT}]=$(idforge_printTemporalFile "${RENDER_FROM[${RENDER_FROM_COUNT}]}")

    local SOURCE_INSTANCE=${SOURCE_INSTANCES[${RENDER_FROM_COUNT}]}

    svg_setInstances "${RENDER_FROM[${RENDER_FROM_COUNT}]}" '(svgz|svg)' 'svg'

    RENDER_FROM_FILE=${RENDER_FROM[${RENDER_FROM_COUNT}]}

    render_setLocalizedXml

    media_setTranslationMarkers

    RENDER_FILE="${RENDER_DIR}/$(idforge_printFileName "${CONFIG_SECTION}")-${TYPE}-${RELEASE}-${ARCH}-${MEDIA_NUMBER_CURRENT}of${MEDIA_NUMBER}.$(idforge_printFileExtension "${CONFIG_SECTION}")"

    RENDER_FROM_FILE=${SOURCE_INSTANCE}

    svg_setRenditionBase

    rm ${SOURCE_INSTANCE}

    svg_exportInstance

}
