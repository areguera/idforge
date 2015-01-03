#!/bin/bash
######################################################################
#
#   ahs - AHS automation tools
#   Copyright © 2015 Alain Reguera Delgado
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

function report_parseSection {

    local REPORT_TYPE='';       report_setConfigOption 'report-type'
    local REPORT_TITLE='';      report_setConfigOption 'report-title'
    local REPORT_TRANSPORT='';  report_setConfigOption 'report-transport'

    local REPORT_FILE=$(tcarlib_getTemporalFile ${SECTION})
    tcarlib_printMessage "${REPORT_FILE}" --as-debbuger-line

    local REPORT_DATE=$(date)

    local REPORT_HOST="${HOSTNAME}"

    report_printHeader > ${REPORT_FILE}
    tcarlib_setModuleEnvironment -m "${REPORT_TYPE}" -t 'child' >> ${REPORT_FILE}
    report_printFooter >> ${REPORT_FILE}

    tcarlib_setModuleEnvironment -m "${REPORT_TRANSPORT}" -t "child"

}
