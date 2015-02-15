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

# Standardize update actions related to localization.
function update {

    local -a RENDER_FROM            ; update_setConfigOption 'render-from'
    local -a RENDER_FROM_INSTANCES
    local -a RENDER_FROM_MO         ; update_setConfigOption 'render-from-mo'

    local RENDER_TYPE=$(idforge_printFileExtension "${RENDER_FROM[0]}")

    [[ -n ${RENDER_FROM_PO[0]} ]] && idforge_setModuleEnvironment -m ${RENDER_TYPE} -t 'child'

    # Unset array variables to avoid undesired concatenations of their
    # values between different sections blocks in the same
    # configuration file.
    unset RENDER_FROM
    unset RENDER_FROM_MO

}
