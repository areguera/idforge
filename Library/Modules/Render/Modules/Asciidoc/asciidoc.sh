#!/bin/bash
######################################################################
#
#   idforge - Manage identity manuals in community.
#   Copyright © 2015 The CentOS Artwork SIG
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

function asciidoc {

    idforge_checkFiles -efm "\.asciidoc$" "${RENDER_FROM[*]}"

    local RENDER_FLOW=''            ; asciidoc_setConfigOption 'render-flow'
    local RENDER_FLOW_OPTIONS=''    ; asciidoc_setConfigOption 'render-flow-options'

    local COUNT=0

    while [[ ${COUNT} -lt ${#RENDER_FROM[*]} ]];do

        asciidoc_setDocbook

        COUNT=$(( ++COUNT ))

    done

    idforge_setModuleEnvironment -m 'docbook' -t 'sibling'

}
