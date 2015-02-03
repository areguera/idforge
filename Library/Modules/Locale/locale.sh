#!/bin/bash
######################################################################
#
#   tcar - The CentOS Artwork Repository
#   Copyright © 2014 The CentOS Artwork SIG
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

function locale {

    # Verify the current locale information to avoid English messages
    # from being localized to themselves. The English language is used
    # as reference to write translatable strings inside the source
    # files.
    if [[ ${SCRIPT_LANG_LC} =~ ^C$ ]];then
        idforge_printMessage "`gettext "The C locale cannot be localized to itself."`" --as-error-line
    fi

    # Define flag controlling the way locale module produces
    # localization files.
    local LOCALE_FLAG_RECURSIVE="false"

    # Initialize module's actions.
    local ACTIONS=''

    # Initialize command-line arguments and interpret arguments and
    # options passed through command-line.
    local ARGUMENT='' ARGUMENTS=''; locale_setOptions "${@}"

    # Verify command-line arguments. They must be provided. Otherwise
    # there is not anything elese to do here so return to caller
    # function.
    [[ -z ${ARGUMENTS} ]] && return

    # Initialize configuration files processing.
    local CONFIG_FILE='' CONFIG_FILES=$(locale_printConfigFiles "${ARGUMENTS}")

    # Process configuration files.
    for CONFIG_FILE in "${CONFIG_FILES}"; do
        locale_setConfigSections
    done

}
