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

        svg-flow )
            SVG_FLOW=$(render_printConfigValues 'base')
            ;;

        svg-flow-options )
            SVG_FLOW_OPTIONS=$(render_printConfigValues)
            ;;

        svg-export-id )
            # Define value of "svg-export-id" option. This is the name of
            # the area you want to export from SVG file. By default
            # the value is set empty so no specific area but the
            # entire document is exported.
            SVG_EXPORT_ID=$(render_printConfigValues)
            ;;

        svg-enable-siblings )
            SVG_ENABLE_SIBLINGS="$(render_printConfigValues)"
            ;;


        * )
            idforge_printMessage "`eval_gettext "The \\\"\\\$CONFIG_OPTION\\\" option isn't supported."`" --as-error-line
            ;;

    esac

}
