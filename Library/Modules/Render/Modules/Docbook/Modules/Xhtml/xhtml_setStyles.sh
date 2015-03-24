#!/bin/bash
######################################################################
#
#   idFORGE Framework - Manage identity manuals in community
#   Copyright © 2015 The CentOS Artwork SIG
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

function xhtml_setStyles {

    local RENDER_FROM_CSS=''    ; xhtml_setConfigOption 'render-from-css'

    # Define directory where common style sheets are stored in the
    # documentation manual directory structure.
    local XHTML_CSS=$(dirname ${XHTML})/Css

    # Rebuild image directory inside documentation manual.
    [[ -d ${XHTML_CSS} ]] && rm -r ${XHTML_CSS}
    [[ ! -d ${XHTML_CSS} ]] && mkdir -p ${XHTML_CSS}

    # Define read-only location where common style sheets are copied
    # from. This location provides the common common style sheets that
    # all documentation manuals in XHTML format will include. Further
    # customization of these common style sheets is possible by using
    # the workplace.
    local XHTML_CSS_MODELS=${IDFORGE_MODELS}/Documents/Css

    # Define list of directories which common style sheets will be
    # copied from.  Set common style sheets from the read-only
    # location first and common style sheets from the workplace later.
    # So, it is possible to use the workplace to customize the common
    # style sheets distributed in the read-only location.
    local DIRECTORY='' DIRECTORIES="${XHTML_CSS_MODELS} ${RENDER_FROM_IMG}"

    # Copy xhtml common style sheets.
    for DIRECTORY in ${DIRECTORIES};do

        [[ ! -d ${DIRECTORY} ]] && continue

        local FILE='' FILES=$(idforge_printFileList -t 'f' -p '.+\.css$' ${DIRECTORY})

        [[ -z ${FILES} ]] && continue

        cp ${FILES} ${XHTML_CSS}

    done

}
