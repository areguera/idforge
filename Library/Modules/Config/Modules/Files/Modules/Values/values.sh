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

# Standardize the way configuration values are retrieved from
# configuration files. As arguments, the configuration file absolute
# path, the configuration section name, and the configuration option
# name must be provided.
function values {

    local CONFIG_LINES="$(idforge_setModuleEnvironment -m 'lines' -t 'sibling')"

    for CONFIG_LINE in "${CONFIG_LINES}";do

        local CONFIG_VALUE=$(echo "${CONFIG_LINE}" \
            | cut -s -d= -f2- | sed -r -e 's/"//g' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

        eval echo ${CONFIG_VALUE:-${CONFIG_FLAG_VALUE}}

    done

}
