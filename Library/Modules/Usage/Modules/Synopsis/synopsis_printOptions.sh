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

# Retrieve options from specific commands and print them for the usage
# message. With this function there is no need to write one printUsage
# function for each command inside idforge(1) script. With this
# function we reduce the overall maintenance cost.
function synopsis_printOptions {

    # Define the regular expression pattern that matches option
    # definitions inside _getOptions files.
    local PATTERN='^([[:space:]]*)-([[:alpha:]].+)[[:space:]]*\)[[:space:]]*$'

    # Retrieve options from module's getOptions function and transform
    # the output to include it in the usage preamble.
    egrep ${PATTERN} ${USAGE_OPTIONS_FILE} | sort \
        | tr -d ' ' \
        | sed -r -e 's/^([[:space:]]*)/ [/' \
        | tr ')' ']' | tr -d "\n" \
        | sed -r 's/^[[:space:]]+//'

}
