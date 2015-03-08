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

function xml_convertXmlToPot {

    LOCALE_PO_TEMPLATES[${COUNT}]=$(idforge_printTemporalFile ${XML}).pot

    # Move the current working directory in the stack to the final
    # render directory before processing source file in order for
    # relative calls (e.g., image files) inside the source files to be
    # found by xml2po and no warning is printed from it. Notice that
    # relative paths may be provided as render directory so, a way to
    # go forward and backward in the directory stack without
    # inconsistencies is necessary here.

    PUSHD_EXIT=1

    [[ -d ${RENDER_DIRECTORY} ]] && pushd ${RENDER_DIRECTORY} > /dev/null && PUSHD_EXIT=${?}

    xml2po -a -l ${IDFORGE_LANG_LC} ${XML} \
        | msgcat --output-file=${LOCALE_PO_TEMPLATES[${COUNT}]} --width=70 --no-location -

    [[ ${PUSHD_EXIT} -eq 0 ]] && popd > /dev/null

}
