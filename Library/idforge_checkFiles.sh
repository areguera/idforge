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

# Standardizes the way file conditional expressions are applied to
# files.  Here is where idforge.sh script answers questions like: is the
# file a regular file or a directory?  Or, is it a symbolic link? Or
# even, does it have execution rights, etc.  If the verification fails
# somehow at any point, an error message is output and idforge.sh script
# finishes its execution.
function idforge_checkFiles {

    # Define the localization domain for this function.
    local TEXTDOMAIN="${IDFORGE}"

    # Define whether this function prints messages to standard output
    # or just its return status. This allows us to use the function
    # inside [[ ]] expressions. By default, when an error occurs, this
    # function prints a message to standard error and finishes the
    # script execution. However, when the -q option is provided it
    # returns 1 and no message is output to standard error nor the
    # script finishes its execution.
    local FLAG_QUIET="${IDFORGE_FLAG_QUIET}"

    # Initialize local array variables.
    local -a CONDITION_COMMAND
    local -a CONDITION_PATTERN
    local -a CONDITION_MESSAGE

    # Initialize counter used by local arrays.
    local COUNTER=0

    # Initialize option locally.
    local OPTION=''

    # Initialize option index locally.
    local OPTIND=1

    # Initialize option parser.
    while getopts "i:,m:,n,d,e,f,h,r,w,x,q" OPTION "${@}"; do

        case "${OPTION}" in

            d )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='/usr/bin/test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-d'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't a directory."`"
                ;;

            e )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='/usr/bin/test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-e'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "doesn't exist."`"
                ;;

            f )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='/usr/bin/test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-f'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't a regular file."`"
                ;;

            h )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='/usr/bin/test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-h'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't a symbolic link."`"
                ;;

            x )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='/usr/bin/test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-x'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't executable."`"
                ;;

            r )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='/usr/bin/test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-r'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't readable."`"
                ;;

            w )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='/usr/bin/test'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-w'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't writable."`"
                ;;

            i )
                local MIME=${OPTARG}
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='/usr/bin/file'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]='-b -i'
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`eval_gettext "isn't a \\\"\\\$MIME\\\" file."`"
                ;;

            m )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]='match'
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]="${OPTARG}"
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "doesn't match its pattern."`"
                ;;

            n )
                CONDITION_COMMAND[((++${#CONDITION_COMMAND[*]}))]="/bin/rpm"
                CONDITION_PATTERN[((++${#CONDITION_PATTERN[*]}))]="-q --quiet"
                CONDITION_MESSAGE[((++${#CONDITION_MESSAGE[*]}))]="`gettext "isn't installed in the system."`"
                ;;

            q )
                FLAG_QUIET='true'
                ;;

        esac
    done

    # Clean up positional parameters to reflect the fact that options
    # have been processed already.
    shift $(( ${OPTIND} - 1 ))

    # Define list of files we want to apply verifications to, now that
    # all option-like arguments have been removed from positional
    # parameters list so we are free to go with the verifications.
    local FILE=''
    local FILES=${@}

    # Verify existence of files to prevent idforge.sh script from
    # using the current location in cases when it shouldn't (e.g.,
    # here it is expecting a list of files to process.).
    if [[ -z ${FILES} ]];then
        idforge_printMessage "`gettext "No file for processing found."`" --as-error-line
    fi

    for FILE in ${FILES};do

        until [[ ${COUNTER} -eq ${#CONDITION_PATTERN[*]} ]];do

            case ${CONDITION_COMMAND[${COUNTER}]} in

                "/usr/bin/test" | "/bin/rpm" )
                ${CONDITION_COMMAND[${COUNTER}]} ${CONDITION_PATTERN[${COUNTER}]} ${FILE}
                if [[ $? -ne 0 ]];then
                    if [[ ${FLAG_QUIET} == 'false' ]];then
                        idforge_printMessage "${FILE} ${CONDITION_MESSAGE[${COUNTER}]}" --as-error-line
                    else
                        return 1
                    fi
                fi
                ;;

                "/usr/bin/file" )
                if [[ ! $(${CONDITION_COMMAND[${COUNTER}]} ${CONDITION_PATTERN[${COUNTER}]} ${FILE}) =~ ${MIME} ]];then
                    if [[ ${FLAG_QUIET} == 'false' ]];then
                        idforge_printMessage "${FILE} ${CONDITION_MESSAGE[${COUNTER}]}" --as-error-line
                    else
                        return 1
                    fi
                fi
                ;;

                "match" )
                if [[ ! ${FILE} =~ ${CONDITION_PATTERN[${COUNTER}]} ]];then
                    if [[ ${FLAG_QUIET} == 'false' ]];then
                        idforge_printMessage "${FILE} ${CONDITION_MESSAGE[${COUNTER}]}" --as-error-line
                    else
                        return 1
                    fi
                fi
                ;;

                * )
                idforge_printMessage "`gettext "The condition command provided isn't supported."`" --as-error-line
                ;;

            esac

            COUNTER=$((${COUNTER} + 1))

        done

    done

    return 0

}
