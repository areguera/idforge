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

function add {

    local QATEST_UNIT_NAME="${IDFORGE_MODULE_NAMES[0]}-$(date +"%Y%m%d%S%N")"
    local QATEST_UNIT=${ARGUMENT}/${QATEST_UNIT_NAME}
    local QATEST_UNIT_TEMPDIR=${ARGUMENT}/Final

    [[ -f ${QATEST_UNIT}.sh ]] && idforge_printMessage "`The file already exist.`" --as-error-line

    idforge_setModuleEnvironment -t 'child' -m 'scripts'

    [[ ${QATEST_FLAG_FILETYPES} == 'true' ]] && idforge_setModuleEnvironment -t 'child' -m 'filetypes'
    [[ ${QATEST_FLAG_DIGESTS}   == 'true' ]] && idforge_setModuleEnvironment -t 'child' -m 'digests'

    [[ -d ${QATEST_UNIT_TEMPDIR} ]] && rm -r ${QATEST_UNIT_TEMPDIR}

}
