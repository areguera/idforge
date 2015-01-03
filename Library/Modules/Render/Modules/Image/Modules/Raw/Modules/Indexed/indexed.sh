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

# Standardize the way palettes of colors are applied to image files in
# order to produce images with specific number of colors.
function indexed {

    local PALETTE_GPL=''; indexed_setConfigOption 'colors-info'

    [[ -z ${PALETTE_GPL} ]] && return

    local IMAGE_FILE=$(idforge_printTemporalFile "$(idforge_printFileName ${RENDER_FROM[0]})")

    local PALETTE_LOG=${RENDER_FILE}.log

    local PALETTE_GPL_COLORS=$(indexed_getGplColors)

    # Define absolute path to PPM palette. The PPM palette is built
    # from source palette (PALETTE_GPL) and provides the color
    # information understood by `ppmremap', the program used to
    # produce images in a specific amount of colors.
    local PALETTE_PPM=$(idforge_printTemporalFile 'colors.ppm')

    indexed_checkColorFormats "${PALETTE_GPL_COLORS}"

    indexed_convertPngToPnm

    indexed_convertGplToPpm

    indexed_convertPnmToPpm

    idforge_printMessage "${RENDER_FILE}" --as-creating-line

    if [[ ${RENDER_FILE} =~ \.lss$ ]];then
        idforge_setModuleEnvironment -m 'lss' -t 'child'
    else
        indexed_convertPpmToPng
    fi

}
