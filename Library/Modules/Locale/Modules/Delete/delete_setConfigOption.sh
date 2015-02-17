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

function delete_setConfigOption {

    local CONFIG_OPTION="${1}"

    case ${CONFIG_OPTION} in

        render-from-mo )
            # Define value to "render-from-mo" option. This
            # information is used to retrieve the translation file -in
            # MO format- associated to the source files provided
            # through "render-from" option.
            local FILE=''
            local FILES=$(locale_printConfigValues)

            local COUNT=0

            [[ -z ${FILES} ]] \
                && RENDER_FROM_MO[${COUNT}]=${FILE} \
                && return

            for FILE in ${FILES};do
                if [[ ${FILE} =~ ^/ ]];then
                    RENDER_FROM_MO[${COUNT}]=${FILE}
                else
                    RENDER_FROM_MO[${COUNT}]=${RENDER_DIRECTORY}/${FILE}
                fi
                COUNT=$(( ++COUNT ))
            done

            # Don't verify existence of translation files here. They
            # are optional.
            ;;

        * )
            idforge_printMessage "`eval_gettext "The \\\"\\\$CONFIG_OPTION\\\" option isn't supported."`" --as-error-line
            ;;

    esac

}