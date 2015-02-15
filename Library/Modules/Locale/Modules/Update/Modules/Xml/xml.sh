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

function xml {

    [[ ${#RENDER_FROM_INSTANCES[*]} -gt 0 ]] && return

    local -a LOCALE_PO_TEMPLATES

    # In an xml-based rendition, translation and source files should
    # be in a one-to-one relation. No translation file is acceptable
    # to prevent that source file from being localized.
    [[ ${#RENDER_FROM_PO[*]} -gt ${#RENDER_FROM[*]} ]] \
        && idforge_printMessage "`gettext "Incorrect relation between translation and source files."`" --as-error-line

    local COUNT=0

    while [[ ${COUNT} -lt ${#RENDER_FROM[*]} ]];do

        RENDER_FROM_INSTANCES[${COUNT}]=$(idforge_printTemporalFile ${RENDER_FROM[${COUNT}]})

        xml_createInstance

        xml_verifyInstance

        xml_convertXmlToPot

        COUNT=$(( ++COUNT ))

    done

    [[ ${#LOCALE_PO_TEMPLATES[*]} -gt 0 ]] && idforge_setModuleEnvironment -m 'po' -t 'sibling'

    unset LOCALE_PO_TEMPLATES

}
