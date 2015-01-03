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

function test {

    local QATEST_UNITS=$(idforge_printFileList -t f -p ".+/${IDFORGE_MODULE_NAMES[0]}-${IDFORGE_FLAG_FILTER}\.sh$" ${ARGUMENT} | sort)

    for QATEST_UNIT in ${QATEST_UNITS};do

        local QATEST_UNIT_NAME=$(basename ${QATEST_UNIT%.sh})
        local QATEST_UNIT_DIR=${QATEST_UNIT%/*}
        local QATEST_UNIT_TEMPDIR=${QATEST_UNIT_DIR}/Final

        idforge_printMessage "=" --as-separator-line
        idforge_printMessage "${QATEST_UNIT}" --as-stdout-line
        idforge_printMessage "=" --as-separator-line

        . ${QATEST_UNIT} 2>&1

        test_setIntegrity

    done

}
