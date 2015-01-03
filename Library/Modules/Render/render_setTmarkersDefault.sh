#!/bin/bash
######################################################################
#
#   idforge - Manage corporate identity manuals in community.
#   Copyright © 2015 CentOS Artwork SIG
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

function render_setTmarkersDefault {

    # Define copyright translation markers.
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_YEAR_FIRST='
    DST[((++${#DST[*]}))]="$(idforge_printCopyright --first-year)"
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_YEAR(_LAST)?='
    DST[((++${#DST[*]}))]="$(idforge_printCopyright --year)"
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_YEAR(S)?_LIST='
    DST[((++${#DST[*]}))]="$(idforge_printCopyright --years-list)"
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_YEAR(S)?_RANGE='
    DST[((++${#DST[*]}))]="$(idforge_printCopyright --years-range)"
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_HOLDER='
    DST[((++${#DST[*]}))]="$(idforge_printCopyright --holder)"
    SRC[((++${#SRC[*]}))]='=COPYRIGHT_HOLDER_PREDICATE='
    DST[((++${#DST[*]}))]="$(idforge_printCopyright --holder-predicate)"

    # Define license translation markers.
    SRC[((++${#SRC[*]}))]='=(LICENSE_URL|LICENSE)='
    DST[((++${#DST[*]}))]="$(idforge_printCopyright --license)"

    # Define theme translation markers.
    SRC[((++${#SRC[*]}))]='=THEME='
    DST[((++${#DST[*]}))]="$(idforge_printFileNameStyle ${LOCATION} --motif)"

    # Define url translation markers. Don't define url translation
    # markers here. Use the render-mark configuration option instead.

    # Define release translation markers.
    SRC[((++${#SRC[*]}))]='=RELEASE='
    DST[((++${#DST[*]}))]=${RELEASE}
    SRC[((++${#SRC[*]}))]='=MAJOR_RELEASE='
    DST[((++${#DST[*]}))]=${MAJOR_RELEASE}

    # Define emails translation markers. Don't define email
    # translation markers here. Use the render-mark configuration
    # option instead.

    # Define design models translation markers.
    SRC[((++${#SRC[*]}))]='=(BACKGROUND_IMAGE|RENDER_BACK)='
    DST[((++${#DST[*]}))]="${RENDER_BACK}"

    # Define locale translation markers.
    SRC[((++${#SRC[*]}))]='=LOCALE='
    DST[((++${#DST[*]}))]="${IDFORGE_LANG_LC}"
    SRC[((++${#SRC[*]}))]='=LOCALE_LL='
    DST[((++${#DST[*]}))]="${IDFORGE_LANG_LL}"
    SRC[((++${#SRC[*]}))]='=LOCALE_CC='
    DST[((++${#DST[*]}))]="${IDFORGE_LANG_CC}"

    # Define working directory translation markers.
    SRC[((++${#SRC[*]}))]='=(IDFORGE_WORKDIR|WORKDIR|WD)='
    DST[((++${#DST[*]}))]="${IDFORGE_WORKDIR}"

}
