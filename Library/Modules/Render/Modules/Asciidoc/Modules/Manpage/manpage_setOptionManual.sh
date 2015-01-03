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

function manpage_setManualInformation {

    idforge_checkFiles -ef ${MANPAGE}

    # Define the section title of the reference page (e.g., User
    # Commands) based on the section number.
    local MANPAGE_MANUAL=$(manpage_getSectionTitle)

    # Define pattern used for replacement. This is based on the output
    # produced by xsltproc when the xsl stylesheets provided in the
    # docbook-style-xsl-1.75.2-6.el6.noarch package are used.
    local MANPAGE_FIXME='\[FIXME: manual\]'

    # Apply replacements in the man page file.
    sed -r -i "s/${MANPAGE_FIXME}/${MANPAGE_MANUAL}/g" ${MANPAGE}

}
