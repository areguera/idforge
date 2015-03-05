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

function tar {

    idforge_printMessage "${RENDER_FILE}" --as-creating-line

    local TAR_COMMAND=''    ; tar_setConfigOption 'tar-command'
    local TAR_OPTIONS=''    ; tar_setConfigOption 'tar-options'
    local TAR_DIRECTORY=${IDFORGE_TEMPDIR}/${RANDOM}/${CONFIG_SECTION}

    tar_setInstance

    idforge_setParentDir ${RENDER_FILE}

    pushd $(dirname ${TAR_DIRECTORY}) > /dev/null

    ${TAR_COMMAND} ${TAR_OPTIONS} ${RENDER_FILE} *

    popd > /dev/null

}