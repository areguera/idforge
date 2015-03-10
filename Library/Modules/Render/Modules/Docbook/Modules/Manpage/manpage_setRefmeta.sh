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

function manpage_setRefmeta {

    # Define the manpage product name.
    local MANPAGE_SOFTWARE=''   ; manpage_setConfigOption 'manpage-software'
    local MANPAGE_VERSION=''    ; manpage_setConfigOption 'manpage-version'
    local MANPAGE_SECTDESC=''   ; manpage_setConfigOption 'manpage-sectdesc'

    # Define the section title of the reference page (e.g., User
    # Commands) based on the section number.
    manpage_setRefmetaMisc

    # Define refmiscinfo entries to remove notes and warning about
    # them missing when the manpage is produced.
    local MANPAGE_REFMISCINFO="\
<refmiscinfo class=\"source\">${MANPAGE_SOFTWARE}</refmiscinfo>
<refmiscinfo class=\"software\">${MANPAGE_SOFTWARE}</refmiscinfo>
<refmiscinfo class=\"version\">${MANPAGE_VERSION}</refmiscinfo>
<refmiscinfo class=\"manual\">${MANPAGE_SECTDESC}</refmiscinfo>
<refmiscinfo class=\"sectdesc\">${MANPAGE_SECTDESC}</refmiscinfo>"

    # Apply replacements in the man page file.
    sed -r -i "/<\/refmeta>/i$(echo ${MANPAGE_REFMISCINFO})" ${RENDER_FROM_FILE}

}
