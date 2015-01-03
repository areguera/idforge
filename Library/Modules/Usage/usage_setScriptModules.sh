#!/bin/bash
######################################################################
#
#   idforge - Manage identity manuals in community.
#   Copyright © 2015 CentOS Artwork SIG
#
#   idforge is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   idforge is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with idforge; if not, write to the Free Software Foundation,
#   Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <alain.reguera@gmail.com>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

function usage_setScriptModules {

    # Define the localization domain for this function.
    local TEXTDOMAIN="${IDFORGE}"

    local MODULE=''
    local MODULES=$(idforge_printModuleNames)
    local MODULES_TOTAL=$(echo "${MODULES}" | wc -l)

    echo

    if [[ -n ${MODULES} ]];then
        idforge_printMessage "`eval_ngettext "The following \\\$IDFORGE command is available:" \
                             "The following \\\$IDFORGE commands are available:" \
                             "${MODULES_TOTAL}"`" --as-stdout-line
        usage_setScriptModulesList
        usage_setMore
    else
        idforge_printMessage "`eval_gettext "It looks like no module has been install so far."`" --as-stdout-line
        idforge_printMessage "`eval_gettext "See '\\\$IDFORGE --help' for more information."`" --as-stdout-line
    fi

}
