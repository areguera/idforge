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

# Take one palette produced by Gimp (e.g., syslinux.gpl) as input and
# outputs a list of colors in #rrggbb format set in the fourth column
# of it.
function indexed_printGplColors {

    local COLOR=''
    local COLORS=''

    if [[ -f ${PNG_INDEXED_GPL} ]];then

        # Retrieve the fourth column from GPL palette. The fourth
        # column of a GPL palette contains the palette commentary
        # field. The palette commentary field can be anything, but for
        # the sake of our own convenience we use it to store the color
        # value in hexadecimal format (e.g., rrggbb).  Notice that you
        # can put your comments from the fifth column on, using an
        # space as field separator.
        COLORS=$(sed -r '1,/^#/d' ${PNG_INDEXED_GPL} | gawk '{ printf "%s\n", $4 }')

    else

        # Redefine default background color using The CentOS Project
        # default color then.
        COLORS='#204c8d'

    fi

    # Be sure all color information be output in the #rrggbb format.
    for COLOR in ${COLORS};do
        [[ ! ${COLOR} =~ ^# ]] && COLOR="#${COLOR}"
        echo "${COLOR}"
    done

}
