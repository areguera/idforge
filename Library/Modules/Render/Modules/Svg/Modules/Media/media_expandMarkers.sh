#!/bin/bash
######################################################################
#
#   idforge - Manage identity manuals in community.
#   Copyright © 2015 CentOS Artwork SIG
#
#   idforge is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   idforge is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with idforge; if not, write to the Free Software Foundation,
#   Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <alain.reguera@gmail.com>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

function media_expandMarkers {

    sed -i \
        -e "s,=MEDIA_TYPE=,${MEDIA_TYPE},g" \
        -e "s,=MEDIA_NUMBER_FIRST=,${MEDIA_NUMBER_FIRST},g" \
        -e "s,=MEDIA_NUMBER_LAST=,${MEDIA_NUMBER_LAST},g" \
        -e "s,=MEDIA_NUMBER_CURRENT=,${MEDIA_NUMBER_CURRENT},g" \
        -e "s,=MEDIA_VERSION=,${MEDIA_VERSION},g" \
        -e "s,=MEDIA_ARCHITECTURE=,${MEDIA_ARCHITECTURE},g" \
        ${INKSCAPE_INPUT}

}
