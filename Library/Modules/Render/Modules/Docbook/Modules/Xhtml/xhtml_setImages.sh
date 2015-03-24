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

function xhtml_setImages {

    local RENDER_FROM_IMG=''    ; xhtml_setConfigOption 'render-from-img'

    # Define directory where images are stored in the documentation
    # manual directory structure.
    local XHTML_IMAGES=$(dirname ${XHTML})/Images

    # Rebuild image directory inside documentation manual.
    [[ -d ${XHTML_IMAGES} ]] && rm -r ${XHTML_IMAGES}
    [[ ! -d ${XHTML_IMAGES} ]] && mkdir -p ${XHTML_IMAGES}

    # Define read-only location where images are copied from. This
    # location provides the common images that all documentation
    # manuals in XHTML format will include. Further customization of
    # these images is possible by using the workplace.
    local XHTML_IMAGES_MODELS=${IDFORGE_MODELS}/Documents/Images

    # Define list of directories which images will be copied from.
    # Set images from the read-only location first and images from the
    # workplace later. So, it is possible to use the workplace to
    # customize the images distributed in the read-only location.
    local DIRECTORY='' DIRECTORIES="${XHTML_IMAGES_MODELS} ${RENDER_FROM_IMG}"

    # Copy xhtml images.
    for DIRECTORY in ${DIRECTORIES};do

        [[ ! -d ${DIRECTORY} ]] && continue

        local FILE='' FILES=$(idforge_printFileList -t 'f' -p '.+\.(png|svg)$' ${DIRECTORY})

        [[ -z ${FILES} ]] && continue

        cp ${FILES} ${XHTML_IMAGES}

    done

}
