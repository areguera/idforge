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

# Standardize the export id used inside svg files and the way of
# verify them.
function svg_verifyInstanceExportId {

    # Verify instance.
    idforge_checkFiles -ef ${RENDER_FROM_INSTANCE}

    # Verify export id.
    idforge_checkFiles -m '[[:alnum:]]+' ${SVG_EXPORT_ID}

    # Check export id inside design templates.
    grep "id=\"${SVG_EXPORT_ID}\"" ${RENDER_FROM_INSTANCE} > /dev/null
    if [[ ${?} -gt 0 ]];then
        idforge_printMessage "`eval_gettext "The \\\"\\\$SVG_EXPORT_ID\\\" export id isn't found in the source file:"` ${RENDER_FROM_INSTANCE}" --as-error-line
    fi

}
