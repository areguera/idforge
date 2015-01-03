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

function download_getUrl {

    local DOWNLOAD_URL='';          download_setConfigOption 'download-url'
    local DOWNLOAD_FILE='';         download_setConfigOption 'download-file'
    local DOWNLOAD_CHUNK_SIZE='';   download_setConfigOption 'download-chunk-size'
    local DOWNLOAD_CHUNKS_TOTAL=0
    local DOWNLOAD_REPORT=${DOWNLOAD_FILE}.log

    tcarlib_printMessage "`gettext "Downloaded from"` ${DOWNLOAD_URL}" --as-stdout-line > ${DOWNLOAD_REPORT}
    tcarlib_printMessage "`gettext "Saved as"` ${DOWNLOAD_FILE}" --as-stdout-line >> ${DOWNLOAD_REPORT}
    tcarlib_printMessage "`gettext "Downloaded in chunks of "; \
                           ngettext "${DOWNLOAD_CHUNK_SIZE} byte" \
                                    "${DOWNLOAD_CHUNK_SIZE} bytes" \
                                    "${DOWNLOAD_CHUNK_SIZE}"`" --as-stdout-line >> ${DOWNLOAD_REPORT}
    tcarlib_printMessage "-" --as-separator-line >> ${DOWNLOAD_REPORT}

    while true;do

        local DOWNLOAD_COMMAND='';  download_setConfigOption 'download-command'      

        ${DOWNLOAD_COMMAND} >> ${DOWNLOAD_FILE}

        download_checkExitStatus ${?}

    done

    tcarlib_printMessage "-" --as-separator-line >> ${DOWNLOAD_REPORT}

}
