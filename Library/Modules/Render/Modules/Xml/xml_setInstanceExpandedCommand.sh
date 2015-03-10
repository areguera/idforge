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

function xml_setInstanceExpandedCommand {

    local COUNT=0

    while [[ ${COUNT} -lt ${#SRC[*]} ]];do
        sed -r -i "s!${SRC[${COUNT}]}!${DST[${COUNT}]}!g" ${RENDER_FROM_INSTANCES[${OPTION}]}
        COUNT=$((++COUNT))
    done

    # Remove escaped character from translation markers. This is one
    # of the reasons why translation marker should be expanded in
    # source files instances not the source files themselves.
    # Escaping translation markers provides a way of talking about
    # them without expanding them.
    sed -r -i 's/(=)\\([[:upper:]_]+=)/\1\2/g' ${RENDER_FROM_INSTANCES[${OPTION}]}

}
