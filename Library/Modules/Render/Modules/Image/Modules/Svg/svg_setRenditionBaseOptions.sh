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

# Standardize the way base rendition options are set.
function svg_setRenditionBaseOptions {

    if [[ -n ${FGCOLOR} ]] && [[ ${FGCOLOR} != '000000' ]];then
        sed -i -r "s/((fill|stroke):#)000000/\1${FGCOLOR}/g" ${SOURCE_INSTANCE}
    fi

    if [[ -z ${EXPORTID} ]];then
        INKSCAPE_OPTIONS="${INKSCAPE_OPTIONS} --export-area-drawing "
    else
        svg_checkModelExportId "${SOURCE_INSTANCE}" "${EXPORTID}"
        INKSCAPE_OPTIONS="${INKSCAPE_OPTIONS} --export-id=${EXPORTID} "
    fi

    if [[ -n ${BGCOLOR} ]];then
       INKSCAPE_OPTIONS="${INKSCAPE_OPTIONS} --export-background=$(echo ${BGCOLOR} | cut -d'-' -f1) "
       INKSCAPE_OPTIONS="${INKSCAPE_OPTIONS} --export-background-opacity=$(echo ${BGCOLOR} | cut -d'-' -f2) "
    fi

    if [[ -n ${HEIGHT} ]];then
        INKSCAPE_OPTIONS="${INKSCAPE_OPTIONS} --export-height=${HEIGHT} "
    fi

}
