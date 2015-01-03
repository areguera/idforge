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

        locale-from )
            # Define value to "locale-from" option. This information
            # is used to retrieve the translation file -in PO format-
            # associated to the source files provided through
            # "render-from" option. This option can be empty -to
            # specify no translation available- or receive one or more
            # values. The order in which translation files are
            # provided here must be the same provided in render-from
            # to specify source files. So, the relation source
            # file-translation file can be accurate.
            local FILE=''
            local FILES=$(render_printConfigValues)

            local COUNT=0

            [[ -z ${FILES} ]] \
                && LOCALE_FROM[${COUNT}]=${FILE} \
                && return

            for FILE in ${FILES};do
                if [[ ${FILE} =~ ^/ ]];then
                    LOCALE_FROM[${COUNT}]=${FILE}
                else
                    LOCALE_FROM[${COUNT}]=${RENDER_DIR}/${FILE}
                fi
                COUNT=$(( ++COUNT ))
            done

            # Don't verify existence of translation files here. They
            # are optional.
            ;;

        render-dir )
            # Define value of "render-dir" option. This information is
            # used to customize the directory where final files are
            # stored in.
            RENDER_DIR=$(render_printConfigValues "${CONFIG_FILE%/*}/Final")

            # Verify whether the design model has a related
            # translation file assigned or not and, redefine the
            # target directory based on it.
            if [[ -n ${LOCALE_FROM[0]} ]];then
                RENDER_DIR="${RENDER_DIR}/${IDFORGE_LANG_LC}"
            fi
            ;;

        render-file )
            # Define value of "render-file" option. This information
            # is used to customize the path of final file being
            # produced.
            RENDER_FILE=$(render_printConfigValues)
            if [[ ${RENDER_FILE} =~ ^/ ]];then
                RENDER_FILE=${RENDER_FILE}
            else
                RENDER_FILE=${RENDER_DIR}/${RENDER_FILE:-${CONFIG_SECTION}}
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
                    RENDER_FROM[${COUNT}]=${RENDER_DIR}/${FILE}
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
            RENDER_LOGIC=$(render_printConfigValues "overwrite")
            if [[ ${RENDER_LOGIC} == 'remove-first' ]];then
                if [[ -d ${RENDER_DIR} ]];then
                    rm -r ${RENDER_DIR}
                    idforge_setParentDir "${RENDER_FILE}"
                fi
            fi
            ;;

        render-mark )
            # Define value to "render-mark" option. This option can be
            # provided several times in the same configuration section
            # and is useful to expand customized translation markers
            # inside source files' instances. When this option is not
            # provided only default translation markers expansion is
            # performed.
            RENDER_MARK="$(render_printConfigValues '')"
            ;;

        release )
            # Define value to "release" option. This information is
            # used by translation markers when source files are
            # processed.
            RELEASE=$(render_printConfigValues $(idforge_printSystemRelease))
            ;;

        release-major )
            # Define value to "release-major" option. This information
            # is used by translation markers when source files are
            # processed.
            MAJOR_RELEASE=$(render_printConfigValues $(echo ${RELEASE%.*}))
            ;;

        command )
            COMMAND=$(render_printConfigValues "/bin/cp")
            ;;

        * )
            idforge_printMessage "`eval_gettext "The \\\"\\\$CONFIG_OPTION\\\" option isn't supported."`" --as-error-line
            ;;

    esac

}
