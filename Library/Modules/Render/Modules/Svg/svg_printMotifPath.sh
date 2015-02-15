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

function svg_printMotifPath {

    # Define parent directory where background images are retrieved
    # from.
    local BG_DST_DIR="$(dirname ${BG_DST_FILE})"

    # Create parent directory if it doesn't exist. This is required in
    # order for idforge_printFileList to work as expected. We cannot
    # make a search in a directory that doesn't exist.
    idforge_setParentDir ${BG_DST_FILE}

    # Define required image width and height. This is the image size
    # the design model needs to render the background as expected.
    local MODEL_BG_W=$(svg_printImageSize -w ${BG_DST_FILE})
    local MODEL_BG_H=$(svg_printImageSize -h ${BG_DST_FILE})

    # Define list of background images available in the same directory
    # where the final image is expected.
    local BG_FILE='' BG_FILES=$(idforge_printFileList -t 'f' \
        -p '.+/[[:digit:]]+x[[:digit:]]+.png$' ${BG_DST_DIR}/)

    # If no image file is found at this point, it is because there is
    # none available. In these cases, we need to be sure an image is
    # output so, it is possible to build a plain color image using its
    # dimensions. Since we don't know any better image than the one
    # provided in the configuration file, use it as default value
    # here.
    [[ -z ${BG_FILES} ]] && echo ${BG_DST_FILE} && return

    # Sort the list of background images from smallest to biggest.
    # This is necessary in order to use the smallest image available
    # that is bigger than the one required in the design model.
    local BG_FILES_SORTED=$(svg_printMotifPathSorted)

    for BG_FILE in ${BG_FILES_SORTED};do

        local BG_W=$(svg_printImageSize -w ${BG_FILE})
        local BG_H=$(svg_printImageSize -h ${BG_FILE})

        local BG_W_DIFF=$(svg_printIntDiff "${BG_W}" "${MODEL_BG_W}")
        local BG_H_DIFF=$(svg_printIntDiff "${BG_H}" "${MODEL_BG_H}")

        if [[ ${BG_W_DIFF} -ge 0 ]] && [[ ${BG_H_DIFF} -ge 0 ]];then
            echo ${BG_FILE} && return
        fi

    done

}
