#!/bin/bash
######################################################################
#
#   idFORGE Framework - Manage identity manuals in community
#   Copyright © 2015 CentOS Artwork SIG
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

# Standardize the way files are concatenated inside idforge.sh script.
function idforge_printFile {

    # Define absolute path to file you want to print. Take into
    # consideration that this file might be out of the repository
    # (e.g., it would be a temporal file stored under
    # /tmp/idforge-XXXXXX/ directory).
    local FILE="${1}"

    idforge_checkFiles -ef ${FILE}

    if (idforge_checkFiles -q -i 'application/x-gzip' ${FILE});then
        /bin/zcat ${FILE}
    elif (idforge_checkFiles -q -i 'application/x-bzip2' ${FILE});then
        /bin/bzcat ${FILE}
    else
        /bin/cat ${FILE}
    fi

}
