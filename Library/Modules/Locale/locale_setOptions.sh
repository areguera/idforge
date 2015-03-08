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

# Initialize the command-line options used by locale module.
function locale_setOptions {

    # Define short options we want to support.
    local ARGSS="h,v,s,e,d"

    # Define long options we want to support.
    local ARGSL="help,version,description,edit,delete"

    # Redefine arguments using getopt(1) command parser and reset
    # positional parameters on this function, using output produced
    # from (getopt) arguments parser.
    ARGUMENTS=$(idforge_setArguments "${@}")
    [[ ${?} -ne 0 ]] && idforge_printMessage "`gettext "The argument verification failed"`" --as-error-line
    eval set -- "${ARGUMENTS}"

    # Look for options passed through command-line.
    while true; do
        case "${1}" in

            -h | --help )
                idforge_printHelp
                ;;

            -v | --version )
                idforge_setModuleEnvironment -t 'parent' -m 'version' -g ${IDFORGE_MODULE_NAME}
                shift 1
                ;;

            -s | --description )
                idforge_printMessage "`gettext "Manage translation files from configuration files."`" --as-stdout-line
                shift 1
                ;;

            -e | --edit )
                LOCALE_FLAG_EDIT='true'
                shift 1
                ;;

            -d | --delete )
                LOCALE_FLAG_DELETE='true'
                shift 1
                ;;

            -- )
                shift 1
                break
                ;;
        esac
    done

    # Redefine arguments using current positional parameters. Only
    # paths should remain as arguments at this point.
    ARGUMENTS="${@}"

}
