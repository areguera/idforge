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

function base_setComposition {

    local PNG_BASE_COMPOSITION='' PNG_BASE_COMPOSITIONS='' ; base_setConfigOption 'png-base-composition'

    [[ -z ${PNG_BASE_COMPOSITIONS} ]] && return

    idforge_printMessage "${RENDER_FROM_FILE}" --as-composing-line

    for PNG_BASE_COMPOSITION in ${PNG_BASE_COMPOSITIONS};do

        local PNG_BASE_COMPOSITION_FILE=$(echo ${PNG_BASE_COMPOSITION} | cut -d: -f1)

        [[ ! ${PNG_BASE_COMPOSITION_FILE} =~ ^/ ]] && PNG_BASE_COMPOSITION_FILE=${RENDER_DIRECTORY}/${PNG_BASE_COMPOSITION_FILE}

        idforge_checkFiles -efi 'image' ${PNG_BASE_COMPOSITION_FILE}

        local PNG_BASE_COMPOSITION_GEOMETRY=$(echo ${PNG_BASE_COMPOSITION} | cut -d: -f2)

        /usr/bin/composite -geometry ${PNG_BASE_COMPOSITION_GEOMETRY} ${PNG_BASE_COMPOSITION_FILE} ${RENDER_FROM_FILE} ${RENDER_FROM_FILE}

        [[ ${?} -ne 0 ]] && idforge_printMessage "`gettext "The png-base-composition failed."`" --as-error-line

    done

}
