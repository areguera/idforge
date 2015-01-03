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

function download_getOptions {

    # Define short options we want to support.
    local ARGSS="h,v,s"

    # Define long options we want to support.
    local ARGSL="help,version,description"

    # Redefine arguments using getopt(1) command parser and reset
    # positional parameters on this function, using output produced
    # from (getopt) arguments parser.
    ARGUMENTS=''; tcarlib_setArguments "${@}"; eval set -- "${ARGUMENTS}"

    # Look for options passed through command-line.
    while true; do
        case "${1}" in

            -h | --help )
                tcarlib_printHelp
                ;;

            -v | --version )
                tcarlib_printVersion
                ;;

            -s | --description )
                download_printDescription
                shift 1
                ;;

            -- )
                # Remove the `--' argument from the list of arguments
                # in order for processing non-option arguments
                # correctly. At this point all option arguments have
                # been processed already but the `--' argument still
                # remains to mark ending of option arguments and
                # beginning of non-option arguments. The `--' argument
                # needs to be removed here in order to avoid
                # tcar.sh script to process it as a path inside
                # the repository, which obviously is not.
                shift 1
                break
                ;;
        esac
    done

    # Redefine arguments using current positional parameters. Only
    # paths should remain as arguments at this point.
    ARGUMENTS="${@}"

}
