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

# Standardize the way palettes of colors are applied to image files in
# order to produce images with specific number of colors.
function indexed {

    local PNG_INDEXED_GPL=''; indexed_setConfigOption 'png-indexed-gpl'

    idforge_checkFiles -ef ${PNG_INDEXED_GPL}

    local PNG_FILE=${RENDER_FROM_FILE}
    local PPM_FILE=$(idforge_printTemporalFile ${RENDER_FILE}).ppm
    local PPM_PALETTE=$(idforge_printTemporalFile ${PPM_FILE})
    local PNM_FILE=$(idforge_printTemporalFile ${RENDER_FILE}).pnm
    local PNG_FILE_LOG=${RENDER_FILE}.log

    # Create list of colors in hexadecimal format.
    local PNG_INDEXED_GPL_VALUES="$(indexed_printGplColors)"

    # Define the number of colors in hexadecimal format.
    local PNG_INDEXED_GPL_COLORS=$(echo "${PNG_INDEXED_GPL_VALUES}" | wc -l)

    idforge_printMessage "${RENDER_FILE}" --as-indexing-line=${PNG_INDEXED_GPL_COLORS}

    indexed_checkGplPalette "${PNG_INDEXED_GPL_VALUES}"

    indexed_convertPngToPnm
    indexed_convertGplToPpm
    indexed_convertPnmToPpm

    if [[ ${RENDER_FILE} =~ \.lss$ ]];then
        idforge_setModuleEnvironment -m 'lss' -t 'child'
    else
        indexed_convertPpmToPng
    fi

}
