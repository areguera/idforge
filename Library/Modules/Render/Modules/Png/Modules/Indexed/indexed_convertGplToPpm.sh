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

# Take one palette produced by Gimp (e.g., syslinux.gpl) as input and
# outputs one PPM file based on it (e.g., syslinux.ppm).
function indexed_convertGplToPpm {

    local -a FILES
    local COUNT=0

    # Create temporal images (of 1x1 pixel each) to store each color
    # retrieved from Gimp's palette.
    for COLOR in ${PNG_INDEXED_GPL_VALUES};do
        FILES[${COUNT}]=$(idforge_printTemporalFile ${COUNT}.ppm)
        ppmmake ${COLOR} 1 1 > ${FILES[${COUNT}]}
        COUNT=$(( ++COUNT ))
    done

    # Concatenate each temporal image from left to right to create the
    # PPM file.
    pnmcat -lr ${FILES[*]} > ${PPM_PALETTE}

    # Remove temporal images used to build the PPM palette file.
    rm ${FILES[*]}

    # Verify PPM palette existence.
    idforge_checkFiles -ef "${PPM_PALETTE}"

}
