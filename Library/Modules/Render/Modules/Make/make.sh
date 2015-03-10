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

function make {

    local MAKEFILE=''
    local MAKEFILES=$(idforge_printFileList -a 1 -i 1 -t 'f' \
        -p '.+/(GNUmakefile|(m|M)akefile)$' ${RENDER_DIRECTORY})

    for MAKEFILE in ${MAKEFILES};do

        idforge_printMessage "${MAKEFILE}" --as-processing-line

        # Define make file instance.
        local MAKEFILE_INSTANCE=$(idforge_printTemporalFile ${MAKEFILE})

        # Create make file instance.
        cp ${MAKEFILE} ${MAKEFILE_INSTANCE}

        # Apply translation makers in make file instance.
        render_setTmarkers "${MAKEFILE_INSTANCE}"

        # Get in the directory where all render action take place.
        pushd ${RENDER_DIRECTORY} &> /dev/null

        # Execute make file.
        /usr/bin/make -s -f ${MAKEFILE_INSTANCE}

        # Remove make file instance.
        rm ${MAKEFILE_INSTANCE}

        # Get back to the current directory you were before.
        popd &> /dev/null

    done

}
