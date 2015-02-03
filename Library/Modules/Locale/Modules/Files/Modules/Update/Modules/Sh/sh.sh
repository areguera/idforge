#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository
#   Copyright © 2014 The CentOS Artwork SIG
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

function sh {

    idforge_checkFiles -efi 'text/x-shellscript' "${RENDER_FROM_FILE}"

    local FILES=''

    local DIRECTORY=$(dirname ${RENDER_FROM_FILE})

    if [[ ${LOCALE_FLAG_RECURSIVE} == 'true' ]];then
        FILES=$(idforge_getFilesList -t 'f' -p '.+\.sh$' "${DIRECTORY}")
    else
        FILES=$(idforge_getFilesList -i '1' -a '1' -t 'f' -p '.+\.sh$' "${DIRECTORY}")
    fi

    idforge_checkFiles -efi 'text/x-shellscript' "${FILES}"

    # Retrieve translatable strings from shell script files and create
    # the portable object template (.pot) from them.
    xgettext --output=${POT_FILE} --width=70 \
        --package-name=${SECTION} \
        --copyright-holder="$(idforge_printCopyright --holder)" \
        --msgid-bugs-address="centos-docs@centos.org" \
        --sort-by-file ${FILES}

    [[ ! -f ${POT_FILE} ]] && return

    update_convertPotToPo "${POT_FILE}" "${PO_FILE}"

}
