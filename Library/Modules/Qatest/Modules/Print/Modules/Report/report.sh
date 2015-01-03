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

function report {

    local QATEST_UNITS_TOTAL=$(( QATEST_UNITS_PASSED + QATEST_UNITS_FAILED ))

    [[ ${QATEST_UNITS_TOTAL} -eq 0 ]] && idforge_printMessage "`gettext "didn't find any test in the location you provided."`" --as-error-line

    idforge_printMessage "=" --as-separator-line
    idforge_printMessage "${QATEST_UNITS_TOTAL} `ngettext  "test was executed | " \
                                                           "tests were executed | " \
                                                           "${QATEST_UNITS_TOTAL}"`" --as-nonew-line
    idforge_printMessage "${QATEST_UNITS_FAILED} `ngettext "failed" \
                                                           "failed" \
                                                           "${QATEST_UNITS_FAILED}"`" --as-nonew-line
    idforge_printMessage " | " --as-nonew-line
    idforge_printMessage "${QATEST_UNITS_PASSED} `ngettext "passed" \
                                                           "passed" \
                                                           "${QATEST_UNITS_PASSED}"`" --as-nonew-line
    echo
    echo
    if [[ ${QATEST_UNITS_FAILED} -gt 0 ]];then
        idforge_printMessage "`gettext "[ FAILED ]"` " --as-nonew-line='1;31'
        idforge_printMessage "`gettext "Don't commit your changes yet. Fix what you broke first."`" --as-stdout-line
    else
        idforge_printMessage "`gettext "[ PASSED ]"` " --as-nonew-line='1;32'
        idforge_printMessage "`gettext "You can commit your changes now. Good work!"`" --as-stdout-line
    fi
    echo

}
