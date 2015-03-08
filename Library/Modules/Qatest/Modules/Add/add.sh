#!/bin/bash
######################################################################
#
#   idFORGE Framework - Manage identity manuals in community
#   Copyright © 2015 CentOS Artwork SIG
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

function add {

    [[ ${QATEST_FLAG_MIME} == 'true' ]] || [[ ${QATEST_FLAG_CHECKSUM} == 'true' ]] \
        && idforge_printMessage "`gettext "Content validation isn't supported while a new test is being added."`" --as-error-line

    # Define shell script location. Since the final shell script
    # content is concatenated at different times, it is be possible to
    # end with an incomplete shell script if the creation process
    # doesn't count with some sort of atomicity. To do so, we store
    # the under-construction shell script (instance) in a temporal
    # directory and move it, once completed, up to its final location.
    local QATEST_UNIT_INSTANCE=${IDFORGE_TEMPDIR}/qatest-$(date '+%Y%m%d%H%M%S%N').sh

    # Create shell script instance.
    add_setInstance

    # Create shell script based on its instance.
    add_setScript

}
