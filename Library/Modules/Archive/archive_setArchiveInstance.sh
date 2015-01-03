#!/bin/bash
######################################################################
#
#   idforge - Manage identity manuals in community.
#   Copyright © 2015 The CentOS Artwork SIG
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

function archive_setArchiveInstance {

    local FILE=''

    # Let file names to be renamed before being compressed.
    for FILE in ${RENDER_FROM[*]};do

        local ARCHIVE_COMMAND='cp'

        local FILE_LH=$(echo ${FILE} | gawk -F: '{ print $1 }')

        idforge_checkFiles -ef ${FILE_LH}

        local FILE_RH=$(echo ${FILE} | gawk -F: '{ print $2 }')

        if [[ -n ${FILE_RH} ]];then
            idforge_checkFiles -m '^[[:alnum:].-]+$' ${FILE_RH}
            ${ARCHIVE_COMMAND} ${FILE_LH} ${ARCHIVE_DIR}/${FILE_RH}
        else
            ${ARCHIVE_COMMAND} ${FILE_LH} ${ARCHIVE_DIR}/$(basename ${FILE_LH})
        fi

    done

}
