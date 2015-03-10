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

function locale_setConfigOption {

    local CONFIG_OPTION="${1}"

    case ${CONFIG_OPTION} in

        render-from-po )
            # Define value to "render-from-po" option. This information
            # is used to retrieve the translation file -in PO format-
            # associated to the source files provided through
            # "render-from" option. This option can be empty -to
            # specify no translation available- or receive one or more
            # values. The order in which translation files are
            # provided here must be the same provided in render-from
            # to specify source files. So, the relation source
            # file-translation file can be accurate.
            local FILE=''
            local FILES=$(locale_printConfigValues)

            # When no configuration file is found, continue with the
            # next configuration in the list of configuration files to
            # process.
            [[ -z ${FILES} ]] && continue

            local COUNT=0

            for FILE in ${FILES};do
                if [[ ${FILE} =~ ^/ ]];then
                    RENDER_FROM_PO[${COUNT}]=${FILE}
                else
                    RENDER_FROM_PO[${COUNT}]=${RENDER_DIRECTORY}/${FILE}
                fi
                COUNT=$(( ++COUNT ))
            done

            # Don't validate the existence of translation files
            # provided in PO format here. Remember that the locale
            # module creates translation files. So, it is valid to
            # have non-existent translation files specified as value
            # to render-from-po configuration option in such
            # situations.
            ;;

        render-directory )
            # Define value of "render-dir" option. This information is
            # used to customize the directory where final files are
            # stored in.
            RENDER_DIRECTORY=$(locale_printConfigValues "${CONFIG_FILE%/*}/Final")

            # Verify whether the design model has a related
            # translation file assigned or not and, redefine the
            # target directory based on it.
            if [[ ${#RENDER_FROM_PO[*]} -gt 0 ]];then
                RENDER_DIRECTORY="${RENDER_DIRECTORY}/${IDFORGE_LANG_LC}"
            fi
            ;;

        * )
            idforge_printMessage "`eval_gettext "The \\\"\\\$CONFIG_OPTION\\\" option isn't supported."`" --as-error-line
            ;;

    esac

}
