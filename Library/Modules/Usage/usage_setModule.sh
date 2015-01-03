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

function usage_setModule {

    # Define the localization domain for this function.
    local TEXTDOMAIN="${IDFORGE}"

    # Define the name of the module that the usage message will be
    # printed for. Since we are using the usage module to print the
    # information, the name of the module we want to print the usage
    # message for is the module loaded before usage.
    local USAGE_MODULE_NAME=${IDFORGE_MODULE_NAMES[$(( IDFORGE_MODULE_COUNT - 2 ))]}

    local OPTIONS=$(usage_setOptions "${USAGE_MODULE_NAME}_setOptions")

    idforge_printMessage "`eval_gettext "Usage"`: ${IDFORGE} ${USAGE_MODULE_NAME} ${OPTIONS} [ARGS]" --as-stdout-line=5

    usage_setMore

}
