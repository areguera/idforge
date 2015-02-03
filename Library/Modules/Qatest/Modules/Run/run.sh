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

function run {

    local QATEST_UNITS=$(idforge_printFileList -i 1 -a 1 -t f -p ".+/.*${IDFORGE_FLAG_FILTER}\.sh$" ${ARGUMENT})

    idforge_checkFiles -ef ${QATEST_UNITS}

    local QATEST_UNITS_PASSED=0
    local QATEST_UNITS_FAILED=0
    local QATEST_TIMESTAMP=0

    for QATEST_UNIT in ${QATEST_UNITS};do

        idforge_checkFiles -x "${QATEST_UNIT}"
        idforge_printMessage "QATEST_UNIT: ${QATEST_UNIT}" --as-debugger-line

        local QATEST_UNIT_NAME=$(basename ${QATEST_UNIT%.sh})
        idforge_printMessage "QATEST_UNIT_NAME: ${QATEST_UNIT_NAME}" --as-debugger-line

        local QATEST_UNIT_DIR=${QATEST_UNIT%.sh}
        idforge_printMessage "QATEST_UNIT_DIR: ${QATEST_UNIT_DIR}" --as-debugger-line

        local QATEST_UNIT_TEMPDIR=${QATEST_UNIT_DIR}/Final
        idforge_printMessage "QATEST_UNIT_TEMPDIR: ${QATEST_UNIT_TEMPDIR}" --as-debugger-line

        if [[ ${QATEST_FLAG_UPDATE} == 'true' ]];then
            idforge_setModuleEnvironment -m 'update' -t 'child'
        else
            idforge_setModuleEnvironment -m 'check' -t 'child'
        fi

    done

    run_printReport

    return ${QATEST_UNITS_FAILED}

}
