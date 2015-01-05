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

# Interpret option arguments passed to `idforge' script and calls actions
# accordingly.
function idforge_setOptions {

    # Define short options we want to support.
    local ARGSS="h,v,q,y,d,f:"

    # Define long options we want to support.
    local ARGSL="help,version,quiet,yes,debug,filter:"

    # Divide command-line arguments in order to process them. Here the
    # command-line is divided in "common arguments" and "specific
    # arguments". Common arguments begin after the main command (e.g.,
    # idforge.sh) and end before the first non-option argument provided
    # in the command-line. Specific arguments include the first
    # non-option argument and all arguments after it.
    local ARGUMENT='' SPECIFIC_ARGUMENTS='' COMMON_ARGUMENTS=''
    for ARGUMENT in ${@};do
        if [[ ${ARGUMENT} =~ ^- ]];then
            if [[ -n ${COMMON_ARGUMENTS} ]];then
                COMMON_ARGUMENTS="${ARGUMENT} ${COMMON_ARGUMENTS}"
            else
                COMMON_ARGUMENTS="${ARGUMENT}"
            fi
            shift 1; continue
        else
            SPECIFIC_ARGUMENTS="${@}"; break
        fi
    done

    # Redefine common arguments using getopt(1) command parser and
    # reset positional parameters for this function, using the output
    # produced from getopt arguments parser.
    COMMON_ARGUMENTS=$(idforge_setArguments ${COMMON_ARGUMENTS})
    [[ ${?} -ne 0 ]] && idforge_printMessage "`gettext "The argument verification failed"`" --as-error-line
    eval set -- "${COMMON_ARGUMENTS}"

    # Look for options passed through command-line.
    while true; do

        case "${1}" in

            -h | --help )
                idforge_printHelp
                ;;

            -v | --version )
                idforge_setModuleEnvironment -t 'parent' -m 'version' -g ${IDFORGE}
                shift 1
                ;;

            -q | --quiet )
                IDFORGE_FLAG_QUIET='true'
                shift 1
                ;;

            -y | --yes )
                IDFORGE_FLAG_YES='true'
                shift 1
                ;;

            -d | --debug )
                IDFORGE_FLAG_DEBUG='true'
                shift 1
                ;;

            -f | --filter )
                IDFORGE_FLAG_FILTER=${2}
                shift 2
                ;;

            -- )
                shift 1
                break
                ;;
        esac
    done

    # Redefine arguments using specific arguments. Only
    # paths should remain as arguments at this point.
    ARGUMENTS="${SPECIFIC_ARGUMENTS}"

}
