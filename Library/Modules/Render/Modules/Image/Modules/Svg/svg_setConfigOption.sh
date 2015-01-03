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

function svg_setConfigOption {

    local CONFIG_OPTION="${1}"

    case ${CONFIG_OPTION} in

        render-flow )
            RENDER_FLOW=$(render_printConfigValues "base")
            ;;

        render-back )
            # Define value of "render-back" option. This information
            # is used to determine the design model's background
            # image.
            RENDER_BACK=$(render_printConfigValues)

            # Verify value of "render-back" option. It is applied to design
            # models instances using translation marker.
            if [[ -z ${RENDER_BACK} ]]; then
                # In case the value passed to "render-back" option is
                # empty, the script will try to determine the best
                # background image choice, so we need to be sure of
                # the following:
                #   - The design model must exist.
                #   - The design model must have at least one
                #   =BACKGROUND_IMAGE= or =RENDER_BACK= translation
                #   marker inside.  In case none of these conditions
                #   are met, end the script execution with an error
                #   message.
                [[ -f ${RENDER_FROM[${COUNT}]} ]] \
                    && [[ -n $(svg_printTranslationMarkers -f "=(BACKGROUND_IMAGE|RENDER_BACK)=" ${RENDER_FROM[${COUNT}]} ) ]] \
                    && idforge_printMessage "`eval_gettext "The \\\"\\\$CONFIG_OPTION\\\" option must be provided."`" --as-error-line

                # The current image doesn't use any background image
                # so go on.
                return

            fi

            # Verify value of "render-back" option. It is used to
            # determine the image size of the final background image
            # used. So it must comply with the image size convention.
            idforge_checkFiles -m '^[[:digit:]]+x[[:digit:]]+$' $(idforge_printFileName ${RENDER_BACK})

            # Verify value of "render-back" option. It must contain
            # the file:// protocol in the beginning of the path so
            # final PNG images can be exported correctly. Otherwise,
            # when we include external images, they are not printed
            # exactly as they are (they seems to be rendered with low
            # resolution).
            if [[ ! ${RENDER_BACK} =~ ^/ ]];then
                RENDER_BACK="${RENDER_DIR}/${RENDER_BACK}"
            fi
            RENDER_BACK="file://${RENDER_BACK}"
            ;;

        command )
            COMMAND=$(render_printConfigValues "/bin/cp")
            ;;

        export-id )
            # Define value of "export-id" option. This is the name of
            # the area you want to export from SVG file. By default
            # the value is set empty so no specific area but the
            # entire document is exported.
            EXPORTID=$(render_printConfigValues "")
            ;;

        * )
            idforge_printMessage "`eval_gettext "The \\\"\\\$CONFIG_OPTION\\\" option isn't supported."`" --as-error-line
            ;;

    esac

}
