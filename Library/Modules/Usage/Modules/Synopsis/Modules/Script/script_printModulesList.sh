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

function script_printModulesList {

    local SCRIPT_MODULE_NAME=''
    local SCRIPT_MODULE_DESCRIPTION=''

    for SCRIPT_MODULE_NAME in ${SCRIPT_MODULES};do
        SCRIPT_MODULE_NAME=$(echo ${SCRIPT_MODULE_NAME} | tr '[[:upper:]]' '[[:lower:]]')
        SCRIPT_MODULE_DESCRIPTION=$(idforge_setModuleEnvironment -m ${SCRIPT_MODULE_NAME} -t 'parent' -g '--description')
        idforge_printMessage "   ${SCRIPT_MODULE_NAME}: ${SCRIPT_MODULE_DESCRIPTION}" --as-stdout-line=8
    done

}
