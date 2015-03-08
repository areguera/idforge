#!/bin/bash
######################################################################
#
#   idFORGE Framework - Manage identity manuals in community
#   Copyright © 2015 CentOS Artwork SIG
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

function docbook_verifyInstances {

    if [[ ${#RENDER_FROM_INSTANCES[*]} -eq 0 ]];then
        return
    fi

    if [[ ${#RENDER_FROM_INSTANCES[*]} -ne ${#RENDER_FROM[*]} ]];then
        idforge_printMessage "`gettext "The number of source files and their instances don't coincide."`" --as-error-line
    fi

    # Redefine source files based on whether there are instances of
    # them or not. This is necessary to process formats that have been
    # already transformed because they cannot be processed directly
    # through (e.g., asciidoc files must be transformed into docbook
    # first in order to be localized through xml2po and then exported
    # to final formats).

    local COUNT=0

    while [[ ${COUNT} -lt ${#RENDER_FROM[*]} ]];do
        RENDER_FROM[${COUNT}]=${RENDER_FROM_INSTANCES[${COUNT}]}
        COUNT=$(( ++COUNT ))
    done

}
