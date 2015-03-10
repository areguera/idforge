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

function xml {

    local -a LOCALE_PO_TEMPLATES

    xml_verifySources

    xml_createPoTemplates

    [[ ${#LOCALE_PO_TEMPLATES[*]} -gt 0 ]] \
        && idforge_setModuleEnvironment -m 'po' -t 'sibling'

    unset LOCALE_PO_TEMPLATES

    [[ ${#RENDER_FROM_MO[*]} -gt 0 ]] \
        && idforge_setModuleEnvironment -m 'mo' -t 'sibling'

}
