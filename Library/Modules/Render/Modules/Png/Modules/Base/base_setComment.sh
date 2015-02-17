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

# Take comment information from configuration files, process it, and
# apply it on final PNG image file.
function base_setComment {

    local PNG_BASE_COMMENT=''    ; base_setConfigOption 'png-base-comment'

    [[ -z "${PNG_BASE_COMMENT}" ]] && return

    idforge_printMessage "${RENDER_FROM_FILE}" --as-commenting-line

    /usr/bin/mogrify -comment "${PNG_BASE_COMMENT}" "${RENDER_FROM_FILE}"

    [[ ${?} -ne 0 ]] && idforge_printMessage "`gettext "The png-base-comment failed."`" --as-error-line

}