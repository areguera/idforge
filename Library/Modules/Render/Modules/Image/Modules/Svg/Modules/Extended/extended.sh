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

# Standardize extended production of PNG files from SVG files. The
# extended production consists on producing PNG images in in different
# formats, heights, foreground colors and background colors.
function extended {

    local HEIGHTS='' ; extended_setConfigOption 'heights'
    local FGCOLORS=''; extended_setConfigOption 'fgcolors'
    local BGCOLORS=''; extended_setConfigOption 'bgcolors'

    for BGCOLOR in ${BGCOLORS};do
        idforge_checkFiles -m '^[a-fA-F0-9]{6}-(0|1)$' ${BGCOLOR}
        for FGCOLOR in ${FGCOLORS};do
            idforge_checkFiles -m '^[a-fA-F0-9]{3,6}$' ${FGCOLOR}
            for HEIGHT in ${HEIGHTS};do
                idforge_checkFiles -m '^[[:digit:]]+(.[[:digit:]]+)?$' ${HEIGHT}
                extended_setRenditionBase
            done
        done
    done


    # Unset variables used for extended rendition so they don't
    # transcend it.
    unset BGCOLOR BGCOLORS
    unset FGCOLOR FGCOLORS
    unset HEIGHT HEIGHTS

}
