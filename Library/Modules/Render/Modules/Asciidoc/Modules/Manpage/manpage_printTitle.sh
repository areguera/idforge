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

# Standardize man page section titles based on the section number. The
# relation between section number ans section title was taken from
# man(1).
function manpage_printTitle {

    idforge_checkFiles -m '[1-8]' "${MANPAGE_SECTION}"

    case ${MANPAGE_SECTION} in

        1 )
            echo `gettext "User Commands"`
            ;;
        2 )
            echo `gettext "System Calls"`
            ;;
        3 )
            echo `gettext "C Library Functions"`
            ;;
        4 )
            echo `gettext "Devices and Special Files"`
            ;;
        5 )
            echo `gettext "File Formats and Conventions"`
            ;;
        6 )
            echo `gettext "Games et. Al."`
            ;;
        7 )
            echo `gettext "Miscellanea"`
            ;;
        8 )
            echo `gettext "System Administration tools and Deamons"`
            ;;

    esac

}
