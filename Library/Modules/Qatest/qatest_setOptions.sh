#!/bin/bash
######################################################################
#
#   idforge - Manage identity manuals in community.
#   Copyright © 2015 The CentOS Artwork SIG
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

# Interpret option arguments passed to `qatest' module and calls
# actions accordingly.
function qatest_setOptions {

    # Define short options we want to support.
    local ARGSS="h,v,s,c:,a,f,g"

    # Define long options we want to support.
    local ARGSL="help,version,description,command:,add,filetypes,digests"

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
                idforge_printVersion
                ;;

            -s | --description )
                idforge_setModuleEnvironment -t 'child' -m 'print' -g 'description'
                exit 0
                ;;

            -c | --command )
                QATEST_FLAG_COMMAND="${2:-${QATEST_FLAG_COMMAND}}"
                shift 2
                idforge_checkFiles -ex ${QATEST_FLAG_COMMAND}
                ;;

           -a | --add )
                QATEST_FLAG_ADD='true'
                shift 1
                ;;

           -f | --filetypes )
                QATEST_FLAG_FILETYPES='true'
                shift 1
                ;;

           -g | --digests )
                QATEST_FLAG_DIGESTS='true'
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
