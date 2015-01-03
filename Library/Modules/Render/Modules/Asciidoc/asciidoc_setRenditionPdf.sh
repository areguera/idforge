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

# Standardize the way docbook files are transformed in PDF format.
function asciidoc_setRenditionPdf {

    local PDF="${RENDER_FILE}.pdf"

    idforge_printMessage "${PDF}" --as-creating-line

    local FOP=$(idforge_printTemporalFile ${PDF}.fo)

    [[ ! -f ${RENDER_FROM_XSL} ]] \
        && local RENDER_FROM_XSL=/usr/share/sgml/docbook/xsl-stylesheets/fo/docbook.xsl

    /usr/bin/xsltproc -o ${FOP} --nonet \
        ${RENDER_FROM_XSL} ${RENDER_FROM_XML}

    idforge_checkFiles -efi '^application/xml;' ${FOP}

    /usr/bin/fop ${FOP} ${PDF} &> /dev/null

    idforge_checkFiles -efi '^application/pdf;' ${PDF}

}
