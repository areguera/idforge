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

# Standardize the way section names are retrieved from configuration
# files. Once section names are retrieved they are printed to standard
# output for further processing.
function sections {

    # Define regular expression pattern used to retrieve section names
    # from configuration files. Don't permit any regular expression
    # meta-character either.
    local CONFIG_SECTION_REGEX="^\[(${CONFIG_FLAG_SECTION:-[[:alnum:]_.-]+})\][[:space:]]*(#.+)?$"

    # Output all section names without brackets, one per line. Don't
    # permit any kind of expansion here. Section names are used as
    # reference to retrieve information from configuration file,
    # expanding them would create different points of verifications.
    egrep ${CONFIG_SECTION_REGEX} ${CONFIG_FILE} \
        | sed -r "s,${CONFIG_SECTION_REGEX},\1," \
        | egrep ${IDFORGE_FLAG_FILTER}

}
