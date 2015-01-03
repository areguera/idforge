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

function lss_setImage {

    # Create LSS16 image.
    ppmtolss16 ${PALETTE_HEX_COLORS} < ${IMAGE_FILE}.ppm 2>>${PALETTE_LOG} > ${RENDER_FILE}

    # Create PPM image lss to 16 colors. Also the colormap used in
    # the LSS16 image is saved on ${FILE}.log; this is useful to
    # verify the correct order of colors in the image index.
    lss16toppm -map < ${RENDER_FILE} 2>>${PALETTE_LOG} > ${RENDER_FILE}.ppm

}
