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

function download_checkProtocol {

    # When we use file:// protocol in the url, cURL cannot determine
    # the end of file and it continue downloading the range specified
    # infinitely. So, it is necessary to break the loop when both URL
    # file and the downloaded file reach the same size.
    if [[ ${DOWNLOAD_URL} =~ ^file:// ]];then
        local DOWNLOAD_URL_FILE=$(echo ${DOWNLOAD_URL} | sed 's,file://,,')
        local DOWNLOAD_URL_FILE_SIZE=$(download_printBytesTotal ${DOWNLOAD_URL_FILE})
        local DOWNLOAD_FILE_SIZE=$(download_printBytesTotal ${DOWNLOAD_FILE})
        [[ ${DOWNLOAD_URL_FILE_SIZE} == ${DOWNLOAD_FILE_SIZE} ]] && break
    fi

}
