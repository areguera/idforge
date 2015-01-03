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

function download_printReportChunks {

    local DOWNLOAD_FILE_BYTES=$(download_printBytesTotal ${DOWNLOAD_FILE})
    local DOWNLOAD_FILE_BYTES_MSG=`ngettext \
        "${DOWNLOAD_FILE_BYTES} byte" \
        "${DOWNLOAD_FILE_BYTES} bytes" "${DOWNLOAD_FILE_BYTES}"`
    tcarlib_printMessage "$(date) - `eval_gettext "Chunk \\\$DOWNLOAD_CHUNKS_TOTAL received \\\$DOWNLOAD_FILE_BYTES_MSG"`" --as-stdout-line >> ${DOWNLOAD_REPORT}

}
