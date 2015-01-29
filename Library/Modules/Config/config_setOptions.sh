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

function config_setOptions {

    # Define short options we want to support.
    local ARGSS="h,v,s,e:,o:,a:"

    # Define long options we want to support.
    local ARGSL="help,version,description,section:,option:,value:"

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
                idforge_printMessage "`gettext "Retrieve information from configuration files."`" --as-stdout-line
                shift 1
                ;;

            -e | --section )
                # Section name.
                CONFIG_FLAG_SECTION="${2:-}"; shift 2
                ;;

            -o | --option )
                # Option name.
                CONFIG_FLAG_OPTION="${2:-}"; shift 2
                ;;

            -a | --value )

                # Option's default value. This is the value used when
                # the specified option doesn't have a value assigned
                # inside the configuration file.
                #
                # FIXME: This option cannot accept empty values as
                # argument in order to work as expected.  However, in
                # some cases, it is necessary to set an empty value as
                # default value to a configuration option.
                #
                # As workaround for this issue, you could adopt the
                # convention of using the 'null' literal string as
                # argument to this option whenever you need an empty
                # value as default value. The implementation of this
                # convention is set in the 'values' function.
                CONFIG_FLAG_VALUE="${2:-null}"; shift 2
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
