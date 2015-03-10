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

function check_setCommandStatus {

    if [[ ${1} -eq 0 ]];then
        idforge_printMessage "[ `gettext "PASSED"` ]" --as-nonew-line='1;32'
        QATEST_UNITS_PASSED=$(( QATEST_UNITS_PASSED + 1 ))
    else
        idforge_printMessage "[ `gettext "FAILED"` ]" --as-nonew-line='1;31'
        QATEST_UNITS_FAILED=$(( QATEST_UNITS_FAILED + 1 ))
    fi

    shift 1

    idforge_printMessage " : ${@}" --as-stdout-line=0

    QATEST_TIMESTAMP=$(echo ${QATEST_TIMESTAMP} ${COMMAND_TIMESTAMP} | gawk '{ print $1 + $2 }')

}
