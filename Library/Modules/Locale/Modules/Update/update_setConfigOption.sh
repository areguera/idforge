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

function update_setConfigOption {

    local CONFIG_OPTION="${1}"

    case ${CONFIG_OPTION} in

        render-directory )
            # Define value of "render-dir" option. This information is
            # used to customize the directory where final files are
            # stored in.
            RENDER_DIRECTORY=$(locale_printConfigValues "${CONFIG_FILE%/*}/Final")

            # Verify whether the design model has a related
            # translation file assigned or not and, redefine the
            # target directory based on it.
            if [[ -n ${RENDER_FROM_PO[0]} ]];then
                RENDER_DIRECTORY="${RENDER_DIRECTORY}/${IDFORGE_LANG_LC}"
            fi
            ;;

        render-from )
            # Define value to "render-from" option. This information
            # is used to determine the source file that will be used
            # as input and must not be empty. This option can receive
            # more than one value by using several "render-from"
            # option definitions in the configuration file or one,
            # using path expansion.
            local FILE=''
            local FILES=$(locale_printConfigValues)

            if [[ -z ${FILES} ]];then
                idforge_printMessage "`eval_gettext "The \\\"\\\$CONFIG_OPTION\\\" option is required."`" --as-error-line
            fi

            local COUNT=0

            for FILE in ${FILES};do
                if [[ ${FILE} =~ ^/ ]];then
                    RENDER_FROM[${COUNT}]=${FILE}
                else
                    RENDER_FROM[${COUNT}]=${RENDER_DIRECTORY}/${FILE}
                fi
                COUNT=$(( ++COUNT ))
            done

            idforge_checkFiles -ef ${RENDER_FROM[*]}
            ;;

        render-from-mo )
            # Define value to "render-from-mo" option. This
            # information is used to retrieve the translation file -in
            # MO format- associated to the source files provided
            # through "render-from-po" option.
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
