#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository
#   Copyright © 2014 The CentOS Artwork SIG
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

# This function takes a portable object template (.pot) and creates a
# language-specific portable object (.po) for it.
function update_convertPotToPo {

    local POT_FILE="${1}"; idforge_checkFiles -ef ${POT_FILE}

    local PO_FILE="${2}"

    idforge_printMessage "${PO_FILE}" --as-creating-line

    if [[ -f ${PO_FILE} ]];then

        msgcat --use-first --output-file="${PO_FILE}" "${PO_FILE}" "${POT_FILE}"

    else

        update_setLocalesDir

        msginit -i ${POT_FILE} -o ${PO_FILE} --width=70 \
            --no-translator > /dev/null 2>&1

    fi

    update_setPoMetadata "${PO_FILE}"

    update_convertPoToMo "${PO_FILE}" "${MO_FILE}"

}
