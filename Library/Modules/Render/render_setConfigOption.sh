#!/bin/bash
######################################################################
#
#   idforge - Manage identity manuals in community.
#   Copyright © 2015 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <alain.reguera@gmail.com>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

function render_setConfigOption {

    local CONFIG_OPTION="${1}"

    case ${CONFIG_OPTION} in

        render-from-po )
            # Define value to "render-from-po" option. This
            # information is used to retrieve the translation file -in
            # PO format- associated to the source files provided
            # through "render-from" option. This option can be empty
            # -to specify no translation available- or receive one or
            # more values.  The order in which translation files are
            # provided here must be the same provided by render-from
            # to specify source files. So, the file relation between
            # source files and translation file can be the same.
            local FILE=''
            local FILES=$(render_printConfigValues)

            [[ -z ${FILES} ]] && return

            local COUNT=0

            for FILE in ${FILES};do
                if [[ ${FILE} =~ ^/ ]];then
                    RENDER_FROM_PO[${COUNT}]=${FILE}
                else
                    RENDER_FROM_PO[${COUNT}]=${RENDER_DIRECTORY}/${FILE}
                fi
                COUNT=$(( ++COUNT ))
            done

            # Translation files can be provided or not. But, when they
            # are provided, they must exist.
            idforge_checkFiles -e ${RENDER_FROM_PO[*]}
            ;;

        render-directory )
            # Define value of "render-directory" option. This
            # information is used to customize the directory where
            # final files are stored in.
            RENDER_DIRECTORY=$(render_printConfigValues "${CONFIG_FILE%/*}/Final")

            # Verify whether the design model has a related
            # translation file assigned or not and, redefine the
            # target directory based on it.
            if [[ ${#RENDER_FROM_PO[*]} -gt 0 ]];then
                RENDER_DIRECTORY="${RENDER_DIRECTORY}/${IDFORGE_LANG_LC}"
            fi
            ;;

        render-file )
            # Define value of "render-file" option. This information
            # is used to customize the path of final file being
            # produced.
            RENDER_FILE=$(render_printConfigValues "${CONFIG_SECTION}")
            if [[ ${RENDER_FILE} =~ ^/ ]];then
                RENDER_FILE=${RENDER_FILE}
            else
                RENDER_FILE=${RENDER_DIRECTORY}/${RENDER_FILE}
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
            local FILES=$(render_printConfigValues)

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

        render-type )
            # Define value to "render-type" option. This information
            # is used to determine the kind of processing that will be
            # performed. When the "render-type" option isn't provided
            # in the configuration file, use the file extension of the
            # first source file provided by "render-from" option as
            # value.
            RENDER_TYPE=$(render_printConfigValues "$(idforge_printFileExtension ${RENDER_FROM[0]})")
            idforge_checkFiles -m '^[[:alnum:]]+$' ${RENDER_TYPE}
            ;;

        render-logic )
            # Define value of "render-logic" option. This information
            # is used to determined whether to remove or not the
            # directory where final content is stored in, before new
            # content be put inside it.
            RENDER_LOGIC=$(render_printConfigValues 'overwrite')
            if [[ ${RENDER_LOGIC} == 'remove-first' ]];then
                if [[ -d ${RENDER_DIRECTORY} ]];then
                    idforge_printMessage "${RENDER_DIRECTORY}" --as-deleting-line
                    rm -r ${RENDER_DIRECTORY}
                    idforge_setParentDir "${RENDER_FILE}"
                fi
            fi
            ;;

        * )
            idforge_printMessage "`eval_gettext "The \\\"\\\$CONFIG_OPTION\\\" option isn't supported."`" --as-error-line
            ;;

    esac

}
