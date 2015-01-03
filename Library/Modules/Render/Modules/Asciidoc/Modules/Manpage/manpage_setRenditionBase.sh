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

function manpage_setRenditionBase {

    local MANPAGE=${RENDER_FILE}

    [[ ! -f ${RENDER_FROM_XSL} ]] \
        && local RENDER_FROM_XSL=/usr/share/sgml/docbook/xsl-stylesheets/manpages/docbook.xsl

    idforge_printMessage "${MANPAGE}" --as-creating-line

    /usr/bin/xsltproc -o ${MANPAGE} --nonet \
        ${RENDER_FROM_XSL} ${RENDER_FROM_XML}

    # When you produce the final man page with the xsl style sheets
    # provided by docbook-style-xsl-1.75.2-6.el6.noarch package, the
    # manual and source information aren't in the final output because
    # the intermediate docbook file we produced from
    # asciidoc-8.4.5-4.1.el6.noarch doesn't include the required
    # information. As result, the final man page suggests you to fix
    # such information by yourself. So, let's intrude manpage
    # automation scripts to do it for us :).
    manpage_setManualInformation
    manpage_setSourceInformation

}
