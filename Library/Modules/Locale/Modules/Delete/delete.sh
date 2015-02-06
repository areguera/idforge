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

# Standardize elimination of localization files.
function delete {

    local -a LOCALE_MO      ; delete_setConfigOption 'locale-mo'

    local LOCALE_FROM_COUNT=0

    while [[ ${LOCALE_FROM_COUNT} -lt ${#LOCALE_FROM[*]} ]];do

        local PO_FILE=${LOCALE_FROM[${LOCALE_FROM_COUNT}]}
        [[ -f ${PO_FILE} ]] \
            && idforge_printMessage "${PO_FILE}" --as-deleting-line \
            && rm ${PO_FILE}

        local MO_FILE=${LOCALE_MO[${LOCALE_FROM_COUNT}]}
        [[ -f ${MO_FILE} ]] \
            && idforge_printMessage "${MO_FILE}" --as-deleting-line \
            && rm ${MO_FILE}

        LOCALE_FROM_COUNT=$(( ++LOCALE_FROM_COUNT ))

    done

}
