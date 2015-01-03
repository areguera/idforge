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

# Standardize the way docbook files are transformed in XHTML format.
function asciidoc_setRenditionXhtml {

    local HTML=${RENDER_FILE}.html

    [[ ! -f ${RENDER_FROM_XSL} ]] \
        && local RENDER_FROM_XSL=/usr/share/sgml/docbook/xsl-stylesheets/xhtml/docbook.xsl

    idforge_printMessage "${HTML}" --as-creating-line

    /usr/bin/xsltproc -o ${HTML} --nonet \
        ${RENDER_FROM_XSL} ${RENDER_FROM_XML}

}
