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

function mime {

    local MIME=${QATEST_UNIT_DIR}/${QATEST_UNIT_NAME}.mime

    idforge_printMessage "${MIME}" --as-processing-line

    idforge_checkFiles -d ${QATEST_UNIT_TEMPDIR}

    local COMMAND_TIMESTAMP=$(date '+%s.%N')

    /usr/bin/file -i $(idforge_printFileList -t f -p '.+' ${QATEST_UNIT_TEMPDIR}) | diff -q ${MIME} -

    local COMMAND_EXIT=${?}

    COMMAND_TIMESTAMP=$(check_printTimestamp ${COMMAND_TIMESTAMP})

    check_setCommandStatus "${COMMAND_EXIT}" "`eval_gettext "in \\\$COMMAND_TIMESTAMP seconds"`"

}
