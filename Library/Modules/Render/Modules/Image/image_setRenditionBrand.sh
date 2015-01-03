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

# Take brand information from configuration files, process it, and
# apply it on final PNG image file.
function image_setRenditionBrand {

    local BRAND='' BRANDS='' ; image_setConfigOption 'brand'

    [[ -z ${BRANDS} ]] && return

    idforge_checkFiles -efi 'image' ${RENDER_FILE}

    for BRAND in ${BRANDS};do

        local BRAND_FILE=$(echo ${BRAND} | cut -d: -f1)

        [[ ! ${BRAND_FILE} =~ ^/ ]] && BRAND_FILE=${RENDER_DIR}/${BRAND_FILE}

        idforge_checkFiles -efi 'image' ${BRAND_FILE}

        local BRAND_GEOMETRY=$(echo ${BRAND} | cut -d: -f2)

        /usr/bin/composite -geometry ${BRAND_GEOMETRY} ${BRAND_FILE} ${RENDER_FILE} ${RENDER_FILE}

    done

}
