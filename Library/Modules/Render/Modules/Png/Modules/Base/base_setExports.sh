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

function base_setExports {

    local PNG_BASE_EXPORT=''
    local PNG_BASE_EXPORTS=''    ; base_setConfigOption 'png-base-exports'

    [[ -z ${PNG_BASE_EXPORTS} ]] && return

    local RENDER_FROM_FILE_NEW=$(dirname ${RENDER_FROM_FILE})/$(idforge_printFileName ${RENDER_FROM_FILE})

    for PNG_BASE_EXPORT in ${PNG_BASE_EXPORTS};do
        idforge_printMessage "${RENDER_FROM_FILE_NEW}.${PNG_BASE_EXPORT}" --as-creating-line
        /usr/bin/convert ${RENDER_FROM_FILE} ${RENDER_FROM_FILE_NEW}.${PNG_BASE_EXPORT}
        [[ ${?} -ne 0 ]] && idforge_printMessage "`gettext "The png-base-exports failed."`" --as-error-line
    done

}
