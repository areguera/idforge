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

# Process command-line arguments using getopt and store result inside
# the ARGUMENTS variable.
function idforge_setArguments {

    # Define the localization domain for this function.
    local TEXTDOMAIN=${IDFORGE}

    if [[ -n ${ARGSS} || -n ${ARGSL} ]];then
        if [[ -n ${IDFORGE_MODULE_NAME} ]];then
            getopt -o "${ARGSS}" -l "${ARGSL}" -n "${IDFORGE} (${IDFORGE_MODULE_NAME})" -- "${@}"
        else
            getopt -o "${ARGSS}" -l "${ARGSL}" -n "${IDFORGE}" -- "${@}"
        fi
    fi

}
