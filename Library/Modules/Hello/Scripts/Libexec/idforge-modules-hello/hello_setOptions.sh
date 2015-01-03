#!/bin/bash
######################################################################
#
#   idforge-modules-hello - Print a greeting and exit successfully.
#   Copyright © 2015 CentOS Artwork SIG
#
#   idforge-modules-hello is free software; you can redistribute it
#   and/or modify it under the terms of the GNU General Public License
#   as published by the Free Software Foundation; either version 2 of
#   the License, or (at your option) any later version.
#
#   idforge-modules-hello is distributed in the hope that it will be
#   useful, but WITHOUT ANY WARRANTY; without even the implied
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#   See the GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with idforge-modules-hello; if not, write to the Free
#   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <alain.reguera@gmail.com>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# Interpret module-specific options for hello.
function hello_setOptions {

    # Define short options we want to support.
    local ARGSS="h,v,s,g:,l,u,c,r"

    # Define long options we want to support.
    local ARGSL="help,version,description,lower,upper,camel,random"

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
                hello_printDescription
                shift 1
                ;;

            -l | --lower )
                ACTIONS="lower ${ACTIONS}"
                shift 1
                ;;

            -u | --upper )
                ACTIONS="upper ${ACTIONS}"
                shift 1
                ;;

            -c | --camel )
                ACTIONS="camel ${ACTIONS}"
                shift 1
                ;;

            -r | --random )
                ACTIONS="random ${ACTIONS}"
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
