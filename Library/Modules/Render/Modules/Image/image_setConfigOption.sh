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

function image_setConfigOption {

    local CONFIG_OPTION="${1}"

    case ${CONFIG_OPTION} in

        brand )
            BRANDS=$(render_printConfigValues)
            ;;

        comment )
            COMMENT=$(render_printConfigValues)
            ;;

        render-as )
            # Define value to "render-as" configuration option. This
            # information is used to retrieve the image formats you
            # want to produce the image for. This variable contains
            # one or more image format supported by ImageMagick.  For
            # example, `xpm', `jpg', 'tiff', etc.
            FORMATS=$(render_printConfigValues "png")
            ;;

        * )
            idforge_printMessage "`eval_gettext "The \\\"\\\$OPTION\\\" option isn't supported."`" --as-error-line
            ;;

    esac

}
