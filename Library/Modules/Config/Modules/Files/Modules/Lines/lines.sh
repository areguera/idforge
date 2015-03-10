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

# Standardize the way configuration lines are retrieved form
# configuration files. As arguments, the configuration file absolute
# path, the configuration section name, and the configuration option
# name must be provided.
function lines {

    # Retrieve configuration lines from configuration file. Don't sort
    # the value of this value so as to preserve the order given in the
    # configuration file. This is important because configuration
    # files are being used for setting render-from priorities.
    local CONFIG_LINES=$(cat ${CONFIG_FILE} \
        | sed -r 's/#.+$//' \
        | egrep -v '^[[:space:]]*$' \
        | sed -r -n "/^\[${CONFIG_FLAG_SECTION:-[[:alnum:]_.-]+}\][[:space:]]*$/,/^\[/p" \
        | egrep -v '^\[' \
        | egrep "^${CONFIG_FLAG_OPTION:-[[:alnum:]-]+}[[:space:]]*=")

    # Output value related to variable name.
    echo "${CONFIG_LINES}"

}
