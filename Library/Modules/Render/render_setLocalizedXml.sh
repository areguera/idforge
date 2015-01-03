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

# Standardize the way translation file in PO format is applied to XML
# file (e.g., .docbook, .svg) in order to produce the translated
# instance of it.
function render_setLocalizedXml {

    [[ ! -f ${PO_FILE} ]] && return

    local RENDER_FROM_XML_L10N=$(idforge_printTemporalFile ${RENDER_FROM_XML})

    # Move the directory stack to final location before processing
    # source file in order for relative calls (e.g., image files)
    # inside the source files can be found by xml2po and no warning be
    # printed from it.
    pushd ${RENDER_DIR} > /dev/null

    # Create the localized instance from design model.
    xml2po -a -l ${IDFORGE_LANG_LC} -p ${PO_FILE} -o ${RENDER_FROM_XML_L10N} ${RENDER_FROM_XML}

    # Remove .xml2po.mo temporal file.
    [[ -f ./.xml2po.mo ]] && rm ./.xml2po.mo

    # xml2po (gnome-doc-utils-0.18.1-1.el6.noarch) bug? For some
    # reason xml2po is not adding/replacing the lang attribute.  This
    # make intrinsic docbook constructions (e.g., navigation, table of
    # contents, chapters, etc.) be rendered without localization.
    if [[ ${IDFORGE_LANG_LL} != 'en' ]];then
        sed -i -r "s/[[:space:]]+lang=\"[[:alpha:]]+\">/ lang=\"${IDFORGE_LANG_LL}\">/" ${RENDER_FROM_XML_L10N}
    fi

    # Add localization to xml instance for further processing.
    mv ${RENDER_FROM_XML_L10N} ${RENDER_FROM_XML}

    # Return to previous location.
    popd > /dev/null

}
