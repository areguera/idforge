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

function prepare_setWorkplace {

    [[ -d ${ARGUMENT} ]] \
        && idforge_printMessage "`gettext "The workplace you specified already exists."`" --as-error-line

    idforge_checkFiles -d ${IDFORGE_MODELS}/${PREPARE_FLAG_MODEL}

    idforge_printMessage "${ARGUMENT}" --as-creating-line

    local MODELS_CONFIGURATION=''
    local MODELS_CONFIGURATIONS=$(idforge_printFileList -t 'f' -p '.+\.conf$' "${IDFORGE_MODELS}/${PREPARE_FLAG_MODEL}")

    for MODELS_CONFIGURATION in ${MODELS_CONFIGURATIONS};do

        local WORKPLACE_DIRECTORY=$(dirname ${MODELS_CONFIGURATION} \
            | sed -r "s,${IDFORGE_MODELS}/${PREPARE_FLAG_MODEL}/,${ARGUMENT}/,")

        local WORKPLACE_FILE=${WORKPLACE_DIRECTORY}/$(basename ${MODELS_CONFIGURATION})

        idforge_setParentDir ${WORKPLACE_FILE}

        install ${MODELS_CONFIGURATION} ${WORKPLACE_FILE}

        idforge_checkFiles -ef ${WORKPLACE_FILE}

    done

}
