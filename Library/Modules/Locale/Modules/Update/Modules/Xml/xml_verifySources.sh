#!/bin/bash
######################################################################
#
#   idforge - Manage identity manuals in community.
#   Copyright © 2015 CentOS Artwork SIG
#
#   idforge is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   idforge is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with idforge; if not, write to the Free Software Foundation,
#   Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <alain.reguera@gmail.com>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

function xml_verifySources {

    [[ ${#RENDER_FROM_INSTANCES[*]} -eq 0 ]] && return

    # Verify the number of instances produced is exactly the same of
    # source files available.
    [[ ${#RENDER_FROM_INSTANCES[*]} -ne ${#RENDER_FROM[*]} ]] \
        && idforge_printMessage "`gettext "Incorrect relation between source files and their instances."`" --as-error-line

    # Verify relation between source files and translation files.
    [[ ${#RENDER_FROM_PO[*]} -gt ${#RENDER_FROM[*]} ]] \
        && idforge_printMessage "`gettext "Incorrect relation between source files and their translations."`" --as-error-line

    local COUNT=0

    # Redefine localization source files based on whether there are
    # instances of them or not. This is necessary to implement
    # localization of file formats that cannot be localized directly
    # through xml2po (e.g., asciidoc).
    while [[ ${COUNT} -lt ${#RENDER_FROM[*]} ]];do
        RENDER_FROM[${COUNT}]=${RENDER_FROM_INSTANCES[${COUNT}]}
        COUNT=$(( ++COUNT ))
    done

}