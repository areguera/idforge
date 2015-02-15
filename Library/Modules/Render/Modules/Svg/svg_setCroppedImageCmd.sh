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

function svg_setCroppedImageCmd {

    # Define cropping command and related action message.
    local COMMAND="/usr/bin/convert -quiet -crop ${BG_DST_FILE_WIDTH}x${BG_DST_FILE_HEIGHT}+0+0"
    local MESSAGE="${BG_SRC_FILE} (${BG_DST_FILE_WIDTH}x${BG_DST_FILE_HEIGHT}) --as-cropping-line"

    # When both source and target background images have the same
    # size, don't crop. Copy it instead.
    if [[ ${BG_SRC_FILE_WIDTH} -eq ${BG_DST_FILE_WIDTH} ]] \
        && [[ ${BG_SRC_FILE_HEIGHT} -eq ${BG_DST_FILE_HEIGHT} ]];then
        COMMAND="/bin/cp"
        MESSAGE="${BG_SRC_FILE} --as-creating-line"
    fi

    # Print action message.
    idforge_printMessage ${MESSAGE}

    # Create required background image.
    ${COMMAND} ${BG_SRC_FILE} ${BG_DST_FILE}

}
