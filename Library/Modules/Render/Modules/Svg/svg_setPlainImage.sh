#!/bin/bash
######################################################################
#
#   idFORGE Framework - Manage identity manuals in community
#   Copyright © 2015 CentOS Artwork SIG
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

function svg_setPlainImage {

    # Define plain color that will be used as background image.
    local BG_SRC_FILE_COLOR='#204C8D'

    # Define the file name that will be used to create the final
    # background image needed by design model.
    if [[ -z ${BG_SRC_FILE} ]];then
        BG_SRC_FILE="$(basename ${BG_DST_FILE})"
    else
        BG_SRC_FILE="$(basename ${BG_SRC_FILE})"
    fi

    # Define both width and height of final background image needed by
    # design model.
    BG_SRC_FILE_WIDTH=$(svg_printImageSize -w ${BG_SRC_FILE})
    BG_SRC_FILE_HEIGHT=$(svg_printImageSize -h ${BG_SRC_FILE})

    # Define absolute path for final background image used by design
    # model. This must be a temporal file.
    BG_SRC_FILE=$(idforge_printTemporalFile "${BG_SRC_FILE}")

    # Print action message.
    idforge_printMessage "${BG_SRC_FILE} (${BG_SRC_FILE_COLOR})" --as-creating-line

    # Create the source background file.
    ppmmake -quiet ${BG_SRC_FILE_COLOR} \
        ${BG_SRC_FILE_WIDTH} ${BG_SRC_FILE_HEIGHT} \
        | pnmtopng > ${BG_SRC_FILE}

}
