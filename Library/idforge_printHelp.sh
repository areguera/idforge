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

# Standardize the way idforge.sh script prints help about itself.
function idforge_printHelp {

    # Use the function call stack to determine whether to print script
    # or module documentation manual. This is an effective way of
    # doing this verification even when the script is executed from
    # higher shell environments of itself (e.g., when doing packaging
    # checks).
    if [[ ${#FUNCNAME[*]} -le 4 ]];then
        IDFORGE_MANPAGE_NAME=${IDFORGE}
    else
        IDFORGE_MANPAGE_NAME=${IDFORGE}-${IDFORGE_MODULE_NAME}
    fi

    # Print requested documentation. 
    /usr/bin/man -M ${IDFORGE_MANUALS} "${IDFORGE_MANPAGE_NAME}"

    # Verify man command exit status and terminate the script
    # execution with an error message if it was not a successful
    # command.
    [[ ${?} -ne 0 ]] \
        && idforge_printMessage "`gettext "The documentation manual is not available."`" --as-error-line

}
