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

# Standardize man page section titles based on the section number. The
# relation between section number ans section title was taken from
# man(1).
function manpage_setRefmetaMisc {

    [[ -n ${MANPAGE_SECTDESC} ]] && return

    local MANPAGE_VOLNUM=$(egrep '<manvolnum>([[:digit:]])</manvolnum>' ${RENDER_FROM_FILE} \
        | sed -r 's,<manvolnum>([[:digit:]])</manvolnum>.*,\1,')

    idforge_checkFiles -m '[1-8]' ${MANPAGE_VOLNUM}

    case ${MANPAGE_VOLNUM} in
        1 ) MANPAGE_SECTDESC=`gettext "User Commands"`;;
        2 ) MANPAGE_SECTDESC=`gettext "System Calls"`;;
        3 ) MANPAGE_SECTDESC=`gettext "C Library Functions"`;;
        4 ) MANPAGE_SECTDESC=`gettext "Devices and Special Files"`;;
        5 ) MANPAGE_SECTDESC=`gettext "File Formats and Conventions"`;;
        6 ) MANPAGE_SECTDESC=`gettext "Games et. Al."`;;
        7 ) MANPAGE_SECTDESC=`gettext "Miscellanea"`;;
        8 ) MANPAGE_SECTDESC=`gettext "System Administration tools and Deamons"`;;
    esac

}
