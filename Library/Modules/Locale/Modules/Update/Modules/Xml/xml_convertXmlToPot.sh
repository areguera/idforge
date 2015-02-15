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

function xml_convertXmlToPot {

    # Move to final location before processing source file in order
    # for relative calls (e.g., image files) inside the source files
    # can be found by xml2po and no warning is printed from it.
    [[ -d ${RENDER_DIRECTORY} ]] && pushd ${RENDER_DIRECTORY} > /dev/null

    xml2po -a -l ${IDFORGE_LANG_LC} ${RENDER_FROM_INSTANCES[${COUNT}]} \
        | msgcat --output-file=${LOCALE_PO_TEMPLATES[${COUNT}]} --width=70 --no-location -

    [[ -d ${RENDER_DIRECTORY} ]] && popd > /dev/null

}
