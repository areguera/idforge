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

function script_printModules {

    local SCRIPT_MODULES=$(script_printModulesName)
    local SCRIPT_MODULES_TOTAL=$(echo "${SCRIPT_MODULES}" | wc -l)

    echo

    if [[ -n ${SCRIPT_MODULES} ]];then
        idforge_printMessage "`eval_ngettext "The following \\\$IDFORGE command is available:" \
                             "The following \\\$IDFORGE commands are available:" \
                             "${SCRIPT_MODULES_TOTAL}"`" --as-stdout-line
        script_printModulesList
    else
        idforge_printMessage "`eval_gettext "It looks like no module has been install so far."`" --as-stdout-line
    fi

}
