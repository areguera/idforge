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

function sh {

    [[ ${#RENDER_FROM_PO[*]} -gt 1 ]] \
        && idforge_printMessage "`gettext "Only one PO file must be provided."`" --as-error-line
    [[ ${#RENDER_FROM_MO[*]} -gt 1 ]] \
        && idforge_printMessage "`gettext "Only one MO file must be provided."`" --as-error-line

    idforge_checkFiles -efi 'text/x-shellscript' "${RENDER_FROM[*]}"

    LOCALE_PO_TEMPLATES[0]=$(idforge_printTemporalFile ${RENDER_FROM_PO[0]})

    # Retrieve translatable strings from shell script files and create
    # the portable object template (.pot) from them.
    xgettext --output=${LOCALE_PO_TEMPLATES[0]} \
        --strict \
        --msgid-bugs-address="centos-docs@centos.org" \
        --copyright-holder="The CentOS Artwork SIG" \
        --width=70 --no-location \
        ${RENDER_FROM[*]}

    [[ -f ${LOCALE_PO_TEMPLATES[0]} ]] \
        && idforge_setModuleEnvironment -m 'po' -t 'sibling'

    [[ -f ${LOCALE_PO_TEMPLATES[0]} ]] \
        && idforge_setModuleEnvironment -m 'mo' -t 'sibling'

}
