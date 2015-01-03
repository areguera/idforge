#!/bin/bash
######################################################################
#
#   idforge-modules-hello - Print a greeting and exit successfully.
#   Copyright © 2015 CentOS Artwork SIG
#
#   idforge-modules-hello is free software; you can redistribute it
#   and/or modify it under the terms of the GNU General Public License
#   as published by the Free Software Foundation; either version 2 of
#   the License, or (at your option) any later version.
#
#   idforge-modules-hello is distributed in the hope that it will be
#   useful, but WITHOUT ANY WARRANTY; without even the implied
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#   See the GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with idforge-modules-hello; if not, write to the Free
#   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <alain.reguera@gmail.com>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Print greeting messages in camel-case (e.g., "HeLlO, WoRlD!").  The
# output is printed out one character per line. This might not have
# sense but it helps to describe how execution of sibling modules
# work. Notice that, when printing final output, punctuation marks
# doesn't count for formating. 
function camel {

    local GREETING_CAMEL=1
    local GREETING_OFFSET=0
    local GREETING_CHARS=${#ARGUMENT}
    local GREETING_MESSAGE=${ARGUMENT}

    while [[ ${GREETING_OFFSET} -lt ${GREETING_CHARS} ]]; do

        local ARGUMENT=${GREETING_MESSAGE:${GREETING_OFFSET}:1}

        if [[ ${GREETING_MESSAGE:${GREETING_OFFSET}:1} =~ [[:alpha:]]+ ]];then

            if [[ ${GREETING_CAMEL} -eq 1 ]];then
                idforge_setModuleEnvironment -m 'upper' -t 'sibling'
                GREETING_CAMEL=0
            else
                idforge_setModuleEnvironment -m 'lower' -t 'sibling'
                GREETING_CAMEL=1
            fi

        else
            
            if [[ ${GREETING_MESSAGE:${GREETING_OFFSET}:1} =~ [[:space:]]* ]];then
                ARGUMENT='·'
            fi

            idforge_printMessage "${ARGUMENT}" --as-stdout-line

        fi

        GREETING_OFFSET=$(( ${GREETING_OFFSET} + 1 ))

    done

}
