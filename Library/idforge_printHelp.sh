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
    /usr/bin/man -M ${TEXTDOMAINDIR} "${IDFORGE_MANPAGE_NAME}"

    # Finish script execution successfully.
    exit ${?}

}
