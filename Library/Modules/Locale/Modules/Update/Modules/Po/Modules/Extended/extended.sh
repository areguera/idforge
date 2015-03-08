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

function extended {

    local COUNT=0

    local PO=${RENDER_FROM_PO[${COUNT}]}

    while [[ ${COUNT} -lt ${#LOCALE_PO_TEMPLATES[*]} ]];do

        local POT=${LOCALE_PO_TEMPLATES[${COUNT}]}

        idforge_printMessage "${PO}" --as-creating-line

        po_setPotMetadata

        po_convertPotToPo

        po_setPoMetadata

        COUNT=$(( ++COUNT ))

    done

}
