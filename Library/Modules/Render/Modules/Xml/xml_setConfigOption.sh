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

function xml_setConfigOption {

    local CONFIG_OPTION="${1}"

    case ${CONFIG_OPTION} in

        xml-expand-releases )
            XML_EXPAND_RELEASES="$(render_printConfigValues)"
            ;;

        xml-expand-versions )
            XML_EXPAND_VERSIONS="$(render_printConfigValues)"
            ;;

        xml-expand-architectures )
            XML_EXPAND_ARCHITECTURES="$(render_printConfigValues)"
            ;;

        xml-expand-media )
            XML_EXPAND_MEDIA="$(render_printConfigValues)"
            ;;

        xml-expand )
            XML_EXPAND="$(render_printConfigValues)"
            ;;

        xml-expand-background )
            # Define value of "xml-expand-background" option. This
            # information is used to determine the design model's
            # background image.
            XML_EXPAND_BACKGROUND=$(render_printConfigValues)

            # Verify value of "xml-expand-background" option. It is applied
            # to design models instances using translation marker.
            if [[ -z ${XML_EXPAND_BACKGROUND} ]]; then
                # In case the value passed to "xml-expand-background" option
                # is empty, the script will try to determine the best
                # background image choice, so we need to be sure of
                # the following:
                #   - The design model must exist.
                #   - The design model must have at least one
                #   =BACKGROUND_IMAGE= or =XML_EXPAND_BACKGROUND= translation
                #   marker inside.  In case none of these conditions
                #   are met, end the script execution with an error
                #   message.
                [[ -f ${RENDER_FROM[${COUNT}]} ]] \
                    && [[ -n $(xml_printMarkers -f "=BACKGROUND_IMAGE=" ${RENDER_FROM[${COUNT}]} ) ]] \
                    && idforge_printMessage "`eval_gettext "The \\\"\\\$CONFIG_OPTION\\\" option must be provided."`" --as-error-line

                # The current image doesn't use any background image
                # so go on.
                return

            fi

            # Verify value of "xml-expand-background" option. It is
            # used to determine the image size of the final background
            # image used. So it must comply with the image size
            # convention.
            idforge_checkFiles -m '^[[:digit:]]+x[[:digit:]]+$' $(idforge_printFileName ${XML_EXPAND_BACKGROUND})

            # Verify value of "xml-expand-background" option. It must
            # contain the file:// protocol in the beginning of the
            # path so final PNG images can be exported correctly.
            # Otherwise, when we include external images, they are not
            # printed exactly as they are (they seems to be rendered
            # with low resolution).
            if [[ ! ${XML_EXPAND_BACKGROUND} =~ ^/ ]];then
                XML_EXPAND_BACKGROUND="${RENDER_DIRECTORY}/${XML_EXPAND_BACKGROUND}"
            fi
            XML_EXPAND_BACKGROUND="file://${XML_EXPAND_BACKGROUND}"
            ;;

        * )
            idforge_printMessage "`eval_gettext "The \\\"\\\$CONFIG_OPTION\\\" option isn't supported."`" --as-error-line
            ;;

    esac

}
