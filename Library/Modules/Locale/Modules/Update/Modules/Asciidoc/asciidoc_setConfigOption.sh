#!/bin/bash
######################################################################
#
#   idFORGE Framework - Manage identity manuals in community
#   Copyright © 2015 CentOS Artwork SIG
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

function asciidoc_setConfigOption {

    local CONFIG_OPTION="${1}"

    case ${CONFIG_OPTION} in

        render-from-xsl )
            RENDER_FROM_XSL=$(locale_printConfigValues)
            ;;

        render-flow )
            RENDER_FLOW=$(locale_printConfigValues "article")
            idforge_checkFiles -m '^(article|book|manpage)$' "${RENDER_FLOW}"
            ;;

        render-flow-options )
            RENDER_FLOW_OPTIONS=$(locale_printConfigValues "--attribute=lang=${IDFORGE_LANG_LL}")
            ;;

        * )
            idforge_printMessage "`eval_gettext "The \\\"\\\$CONFIG_OPTION\\\" option isn't supported."`" --as-error-line
            ;;

    esac

}
