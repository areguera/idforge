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

function system_printUsers {

    local SYSTEM_USERS='';  system_setConfigOption 'system-users'

    [[ ${SYSTEM_USERS} != 'yes' ]] && return

    echo

    tcarlib_printMessage "`gettext "Registered Users"`" --as-banner-line

    gawk \
        -v TEXTDOMAIN=${SCRIPT_NAME} \
        -v DOMAINNAME=$(echo ${HOSTNAME} | cut -d. -f2-) \
        -F: -f ${SCRIPT_MODULE_DIR}/system_printUsers.awk \
        /etc/passwd

}
