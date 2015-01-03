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

# Retrieve options from specific commands and print them for the usage
# message. With this function there is no time to write one printUsage
# function for each command inside idforge(1) script. With this function
# we reduce the overall maintenance cost.
function usage_setOptions {

    # Define the name of the function you want to retrieve short and
    # long options from. It is required that the function you provide
    # does be defined and use the standard format adopted by idforge.sh
    # script.
    local FUNCTION_NAME=${1:-idforge_setOptions}

    # Define the regular expression pattern that matches option
    # definitions inside _getOptions files.
    local PATTERN='^([[:space:]]*)-([[:alpha:]].+)[[:space:]]*\)[[:space:]]*$'

    # Retrieve options from module's getOptions function and transform
    # the output to include it in the usage preamble.
    declare -f ${FUNCTION_NAME} \
        | egrep ${PATTERN} | sort \
        | tr -d ' ' \
        | sed -r -e 's/^([[:space:]]*)/ [/' \
        | tr ')' ']' | tr -d "\n" \
        | sed -r 's/^[[:space:]]+//'

}
