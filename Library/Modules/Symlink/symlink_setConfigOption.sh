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

function symlink_setConfigOption {

    local OPTION="${1}"

    case ${OPTION} in

        link-options )
            # Retrieve command options (values are not required here).
            # Just grant you are always creating symbolic links.
            LN_OPTIONS=$(idforge_printConfValue)
            LN_OPTIONS="-si ${LN_OPTIONS}"
            ;;

        link-target )
            # Retrieve link target. This is the link you want to
            # create. This link may be inside or outside the
            # repository. The value passed to this value must be a
            # directory because it is concatenated with the section
            # name to build the final path where link will be created.
            LN_TARGET=$(idforge_printConfValue)
            idforge_checkFiles -ed ${LN_TARGET}
            LN_TARGET=${LN_TARGET}/${SECTION}
            ;;

        * )
            idforge_printMessage "`eval_gettext "The \\\"\\\$OPTION\\\" option isn't supported."`" --as-error-line
            ;;

    esac

}
