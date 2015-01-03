#!/bin/bash
######################################################################
#
#   ahs - AHS automation tools
#   Copyright © 2015 Alain Reguera Delgado
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

function system_setConfigOption {

    local OPTION="${1}"

    case ${OPTION} in

        system-info )
            SYSTEM_INFO=$(tcarlib_getConfigValue)
            ;;

        system-processor )
            SYSTEM_PROCESSOR=$(tcarlib_getConfigValue)
            ;;

        system-memory )
            SYSTEM_MEMORY=$(tcarlib_getConfigValue)
            ;;

        system-diskusage )
            SYSTEM_DISKUSAGE=$(tcarlib_getConfigValue)
            ;;

        system-network )
            SYSTEM_NETWORK=$(tcarlib_getConfigValue)
            ;;

        system-users )
            SYSTEM_USERS=$(tcarlib_getConfigValue)
            ;;

        * )
            tcarlib_printMessage "${OPTION}: `gettext "isn't a supported option"`" --as-error-line
            ;;
    esac

}
