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

function lss_setImage {

    idforge_printMessage "${LSS_FILE}" --as-creating-line

    idforge_checkFiles -ef ${PPM_FILE}

    # Create LSS16 image from PPM image.
    ppmtolss16 ${PNG_LSS_GPL_VALUES} < ${PPM_FILE} > ${LSS_FILE} 2>>${PNG_FILE_LOG}

    # Create a new PPM image from LSS16 for verification purposes.
    # This step is also used to store the colormap used in the LSS16
    # image in the .log, so it is easier to be aware of the order of
    # colors being used in the image index.
    lss16toppm -map < ${LSS_FILE} > ${LSS_FILE}.ppm 2>>${PNG_FILE_LOG}

}
