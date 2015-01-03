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

function image_setRenditionFormats {

    # Create path for different image formats creation using PNG image
    # extension as reference.
    local RENDER_FILE_NEW=$(echo ${RENDER_FILE} | sed -r "s/\.png$//")

    local FORMAT=''
    local FORMATS=''    ; image_setConfigOption 'render-as'

    # Convert images from PNG to those formats specified in the
    # configuration file.
    for FORMAT in ${FORMATS};do
        [[ ${FORMAT} == 'png' ]] && continue
        idforge_printMessage "${RENDER_FILE_NEW}.${FORMAT}" --as-creating-line
        convert ${RENDER_FILE} ${RENDER_FILE_NEW}.${FORMAT}
    done

}
