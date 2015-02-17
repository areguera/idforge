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

function xml_createInstance {

    if [[ ${RENDER_FROM[${COUNT}]} =~ ^${IDFORGE_TEMPDIR} ]];then
        # Don't create source files instances for source files that
        # are instances already (e.g., source files which path begins
        # with /tmp).  This happens to source files that cannot be
        # localized directly through xml2po (e.g., asciidoc.) and
        # localized instances for them are created outside the xml
        # module.
        XML=${RENDER_FROM[${COUNT}]}
    else
        # Create source file instance.
        XML=$(idforge_printTemporalFile ${RENDER_FROM[${COUNT}]})
        if (idforge_checkFiles -q -i 'application/x-gzip' ${RENDER_FROM[${COUNT}]});then
            /bin/zcat ${RENDER_FROM[${COUNT}]} > ${XML}
        elif (idforge_checkFiles -q -i 'application/x-bzip2' ${RENDER_FROM[${COUNT}]});then
            /usr/bin/bzcat ${RENDER_FROM[${COUNT}]} > ${XML}
        else
            /bin/cp ${RENDER_FROM[${COUNT}]} ${XML}
        fi
    fi

}
