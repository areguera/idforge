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

function extended_setConfigOption {

    local CONFIG_OPTION="${1}"

    case ${CONFIG_OPTION} in

        heights )
            # Retrieve heights you want to produce the image for. This
            # variable contains one or more numerical values. For
            # example, `16', `24', `32', etc.
            HEIGHTS=$(render_printConfigValues "16 20 22 24 26 32 36 38 40 48 52 64 72 78 96 112 124 128 148 164 196 200 512")
            ;;

        fgcolors )
            # Retrieve foreground colors you want to produce the image
            # for.  This variable contains one or more color number in
            # hexadecimal format. For example, `000000', `ffffff',
            # etc.
            FGCOLORS=$(render_printConfigValues)
            [[ -z ${FGCOLORS} ]] && FGCOLORS="000000"
            ;;

        bgcolors )
            # Retrieve background colors you want to produce the image
            # for.  This variable contains one or more color number in
            # hexadecimal format with opacity information included.
            # Opacity is specified between 0.0 and 1.0 where 0.0 is
            # full transparency and 1.0 full opacity. For example, the
            # following values are accepted: `000000-0', `ffffff-1',
            # etc.
            BGCOLORS=$(render_printConfigValues "ffffff-0 ffffff-1")
            ;;

        * )
            idforge_printMessage "`eval_gettext "The \\\"\\\$OPTION\\\" option isn't supported."`" --as-error-line
            ;;

    esac

}
