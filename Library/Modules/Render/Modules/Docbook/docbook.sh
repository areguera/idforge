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

function docbook {

    # Verify content of array of instances and redefine list of source
    # files to process based on them.
    docbook_verifyInstances

    # Redefine array of instances so they hold content localization.
    idforge_setModuleEnvironment -m 'xml' -t 'sibling'

    # Retrieve docbook-specific configuration options.
    local DOCBOOK_EXPORT=''
    local DOCBOOK_EXPORTS=''    ; docbook_setConfigOption 'docbook-exports'

    # Export array of instances from docbook to final formats.
    for RENDER_FROM_FILE in ${RENDER_FROM_INSTANCES[*]};do
        for DOCBOOK_EXPORT in ${DOCBOOK_EXPORTS};do
            idforge_setModuleEnvironment -m "${DOCBOOK_EXPORT}" -t 'child'
        done
    done

}
