#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository
#   Copyright © 2014 The CentOS Artwork SIG
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

function files_setConfigOption {

    local OPTION="${1}"

    case ${OPTION} in

        render-from )
            # Define value to "render-from" option. This information
            # is used to determine the source file that will be used
            # as input and must not be empty. This option can receive
            # more than one value by using several "render-from"
            # option definitions in the configuration file or one,
            # using path expansion.
            local FILE=''
            local FILES=$(idforge_getConfigValue)
            [[ -z ${FILES} ]] \
                && idforge_printMessage "`eval_gettext "The \\\"\\\$OPTION\\\" option cannot be empty."`" --as-error-line

            local COUNT=0

            for FILE in ${FILES};do
                if [[ ${FILE} =~ ^/ ]];then
                    RENDER_FROM[${COUNT}]=${FILE}
                else
                    RENDER_FROM[${COUNT}]=$(dirname ${CONFIGURATION})/${FILE}
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
            RENDER_TYPE=$(idforge_getConfigValue)
            [[ -z ${RENDER_TYPE} ]] \
                && RENDER_TYPE=$(idforge_getFileExtension ${RENDER_FROM[0]})
            idforge_checkFiles -m '^[[:alnum:]]+$' ${RENDER_TYPE}

            # Verify localize-able modules. When a module is not
            # supported by any of locale actions, continue with the
            # next section in the file. This behaviour is useful to
            # reuse configuration files that have unsupported modules
            # by locale module but useful to other modules (e.g.,
            # configuration files used to render compressed manpages).
            if [[ ! ${RENDER_TYPE} =~ ^(asciidoc|xhtml|html|xml|svgz|svg|sh)$ ]];then
                COUNT=$(( ++COUNT ))
                continue
            fi
            ;;

        render-flow )
            RENDER_FLOW=$(idforge_getConfigValue)
            [[ -n ${RENDER_FLOW} ]] && idforge_checkFiles -m '[[:alpha:]]+' ${RENDER_FLOW}
            ;;

        locale-from )
            # Define value to "locale-from" option. This information
            # is used to retrieve the translation file -in PO format-
            # associated to the source files provided through
            # "render-from" option. This option can be empty at
            # rendition time -to say: render design model without
            # translation- but it cannot be empty at localization time
            # -it is required to know where the PO file is.
            local FILE=''
            local FILES=$(idforge_getConfigValue)

            # Go to next configuration section if there isn't any
            # translation file for the current one being processed.
            [[ -z ${FILES} ]] && COUNT=$(( ++COUNT )) && continue

            local COUNT=0

            for FILE in ${FILES};do
                if [[ ${FILE} =~ ^/ ]];then
                    LOCALE_FROM[${COUNT}]=${FILE}
                else
                    LOCALE_FROM[${COUNT}]=$(dirname ${CONFIGURATION})/${FILE}
                fi
                COUNT=$(( ++COUNT ))
            done

            # Don't verify existence of translation files here. Such
            # situation is used as reference to determine whether the
            # translation file needs to be created or updated.
            ;;

        locale-mo )
            local FILE=''
            local FILES=$(idforge_getConfigValue)

            local COUNT=0

            for FILE in ${FILES};do
                if [[ ${FILE} =~ ^/ ]];then
                    LOCALE_MO[${COUNT}]=${FILE}
                else
                    LOCALE_MO[${COUNT}]=$(dirname ${CONFIGURATION})/${FILE}
                fi
                COUNT=$(( ++COUNT ))
            done
            ;;

        * )
            idforge_printMessage "`eval_gettext "The \\\"\\\$OPTION\\\" option isn't supported."`" --as-error-line
            ;;

    esac

}
