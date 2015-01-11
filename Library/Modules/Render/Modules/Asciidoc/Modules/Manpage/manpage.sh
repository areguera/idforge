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

# Produce docbook documents using manpage document type.
function manpage {

    local MANPAGE_SECTION=''    ; manpage_setSectionNumber

    local RENDER_FILE=${RENDER_FILE}.${MANPAGE_SECTION}

    for FORMAT in ${RENDER_AS:-manpage};do

        case ${FORMAT} in 

            'manpage' )
                manpage_setRenditionBase
                ;;

            'xhtml' )
                manpage_setRenditionXhtml
                ;;

            'pdf' )
                manpage_setRenditionPdf
                ;;

            * )
                idforge_printMessage "`eval_gettext "The \\\"\\\$FORMAT\\\" format isn't supported."`" --as-error-line
                ;;

        esac

    done

}
