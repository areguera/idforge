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

function checksum {

    local CHECKSUM_REGEX='(sha256sum|sha1sum|md5sum)'

    local CHECKSUMS=$(idforge_printFileList -a 1 -i 1 -t f -p ".+/${QATEST_UNIT_NAME}\.${CHECKSUM_REGEX}$" ${QATEST_UNIT_DIR})

    for CHECKSUM in ${CHECKSUMS};do

        local CHECKSUM_COMMAND=/usr/bin/$(echo ${CHECKSUM} | sed -r "s,^.+\.${CHECKSUM_REGEX}$,\1,")

        [[ ! -x ${CHECKSUM_COMMAND} ]] && continue

        idforge_printMessage "${CHECKSUM}" --as-processing-line

        local COMMAND_TIMESTAMP=$(date '+%s.%N')

        ${CHECKSUM_COMMAND} --quiet -c ${CHECKSUM}

        local COMMAND_EXIT=${?}

        COMMAND_TIMESTAMP=$(check_printTimestamp ${COMMAND_TIMESTAMP})

        check_setCommandStatus "${COMMAND_EXIT}" "`eval_gettext "in \\\$COMMAND_TIMESTAMP seconds"`"

    done

}
