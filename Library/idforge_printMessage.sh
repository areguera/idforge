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

# Standardize the way messages are printed by idforge.sh script.
function idforge_printMessage {

    # Define the localization domain for this function.
    local TEXTDOMAIN=${IDFORGE}

    local MESSAGE="${1}"
    local FORMAT="${2}"

    # Verify message variable, it cannot have an empty value.
    if [[ -z ${MESSAGE} ]];then
        idforge_printMessage "`gettext "The message cannot be empty."`" --as-error-line
    fi

    # Define message horizontal width. This is the max number of
    # horizontal characters the message will use to be displayed on
    # the screen.
    local MESSAGE_WIDTH=66

    # Remove empty spaces from message.
    #MESSAGE=$(printf %s "${MESSAGE}" | sed -r -e 's!^[[:space:]]+!!')

    # Remove current working directory from message to print smaller
    # messages.
    MESSAGE=$(printf %s "${MESSAGE}" | sed -r "s,${PWD}/?,,")

    # Print messages that will always be printed no matter what value
    # the IDFORGE_FLAG_QUIET variable has.
    case "${FORMAT}" in

        --as-stdout-line* )

            local MARGIN_LEFT=15
            if [[ ${FORMAT} =~ --as-stdout-line=[[:digit:]]+ ]];then
                MARGIN_LEFT=$(echo ${FORMAT} | cut -s -d'=' -f2)
            fi

            # Default printing format. This is the format used when no
            # other specification is passed to this function. As
            # convenience, we transform absolute paths into relative
            # paths in order to free horizontal space on final output
            # messages.
            printf %s "${MESSAGE}" | sed -r \
                -e "s!> /!> !g" \
                -e 's!([[:alnum:]])/{2,}!\1/!g' \
                | gawk 'BEGIN { FS=": " }
                    { 
                        if ( $0 ~ /^-+$/ )
                            print $0
                        else
                            printf "%-'${MARGIN_LEFT}'s\t%s\n", $1, $2
                    }
                    END {}'
            ;;

        --as-error-line )

            if [[ ${IDFORGE_FLAG_DEBUG} == 'true' ]];then
                # Build error trail. This output is very useful to
                # track errors.
                idforge_printMessage '-' --as-separator-line=2
                idforge_printMessage "${FUNCNAME[*]}" --as-tree-line
                idforge_printMessage '-' --as-separator-line=2
                idforge_printMessage "$(idforge_printCaller 1) ${MESSAGE}" --as-stderr-line
                idforge_printMessage '-' --as-separator-line=2
            else
                # Build error message. This output communicates what
                # happened in simple words, without too much details.
                if [[ -n ${IDFORGE_MODULE_NAME} ]];then
                    idforge_printMessage "${IDFORGE} (${IDFORGE_MODULE_NAME}): ${MESSAGE}" --as-stderr-line
                else
                    idforge_printMessage "${IDFORGE}: ${MESSAGE}" --as-stderr-line
                fi
            fi

            # Finish script execution with exit status 1 (SIGHUP) to
            # imply the script finished because an error.  We are
            # using this as convention to finish the script execution.
            # So, don't remove the following line, please.
            exit 1
            ;;

        --as-debugger-line )
            [[ ${IDFORGE_FLAG_DEBUG} != 'true' ]] && return 0

            # Default printing format for debugging output. This
            # output is very similar to default printing format
            # nevertheless it is redirected to standard error to avoid
            # merging standard output of parent modules when they are
            # executed nested one inside another.
            printf %s "$(date +"%x %X") ${MESSAGE}" | sed -r \
                -e "s!> /!> !g" \
                -e 's!([[:alnum:]])/{2,}!\1/!g' \
                | gawk 'BEGIN { FS=": " }
                    {
                        if ( $0 ~ /^-+$/ )
                            print $0
                        else
                            printf "%-50s\t%s\n", $1, $2
                    }
                    END {}' 1>&2
            ;;

        --as-tree-line )
            local NAME
            local -a FN
            for NAME in ${MESSAGE};do
                FN[++((${#FN[*]}))]=${NAME}
            done
            local COUNT=$(( ${#FN[*]} - 2 ))
            local SEPARATOR='`--'
            local SPACES=0
            echo "${0}" 1>&2
            while [[ ${COUNT} -gt 0  ]];do
                if [[ ${COUNT} -eq $(( ${#FN[*]} - 2 )) ]];then
                    echo ${SEPARATOR} ${FN[${COUNT}]} 1>&2
                else
                    echo ${FN[${COUNT}]} \
                        | gawk '{ printf "%'${SPACES}'s%s %s\n", "", "'${SEPARATOR}'", $1 }' 1>&2
                fi
                COUNT=$((${COUNT} - 1))
                SPACES=$((${SPACES} + 4))
            done
            ;;

        --as-toknowmore-line )
            idforge_printMessage "`gettext "To know more, run"` ${IDFORGE} ${MESSAGE} --help" --as-stderr-line
            ;;

        --as-yesornorequest-line )

            # Define positive answer.
            local Y="`gettext "yes"`"

            # Define negative answer.
            local N="`gettext "no"`"

            # Define default answer.
            local ANSWER=${N}

            if [[ ${IDFORGE_FLAG_YES} == 'true' ]];then

                ANSWER=${Y}

            else

                # Print the question to standard error.
                idforge_printMessage "${MESSAGE} [${Y}/${N}]" --as-request-line

                # Redefine default answer based on user's input.
                read ANSWER

            fi

            # Verify user's answer. Only positive answer let the
            # script flow to continue. Otherwise, if something
            # different from positive answer is passed, the script
            # terminates its execution immediately.
            if [[ ! ${ANSWER} =~ ^${Y} ]];then
                exit 0
            fi
            ;;

        --as-selection-line )
            # Create selection based on message.
            local NAME=''
            select NAME in ${MESSAGE};do
                echo ${NAME}
                break
            done
            ;;

        --as-response-line )
            idforge_printMessage "--> ${MESSAGE}" --as-stdout-line
            ;;

        --as-request-line )
            idforge_printMessage "${MESSAGE}:\040" --as-nonew-line
            ;;

        --as-nonew-line* )
            local COLOR=$(echo ${FORMAT} | cut -s -d'=' -f2-)
            if [[ -n "${COLOR}" ]];then
                echo -e -n '\033['${COLOR}'m'
                echo -n "${MESSAGE}"
                echo -n -e '\033[0;39m'
            else
                echo -n "${MESSAGE}"
            fi
            ;;

        --as-stderr-line )
            echo "${MESSAGE}" 1>&2
            ;;

    esac

    # Verify quiet option. The quiet option controls whether messages
    # are printed or not.
    if [[ "${IDFORGE_FLAG_QUIET}" == 'true' ]];then
        return
    fi

    # Print messages that will be printed only when the IDFORGE_FLAG_QUIET
    # variable is provided to idforge.sh script.
    case "${FORMAT}" in

        --as-separator-line* )

            # Build the separator line.
            MESSAGE=$(\
                until [[ ${MESSAGE_WIDTH} -eq 0 ]];do
                    echo -n "$(echo ${MESSAGE} | sed -r 's!(.).*!\1!')"
                    MESSAGE_WIDTH=$((${MESSAGE_WIDTH} - 1))
                done) 

            # Draw the separator line.
            if [[ ${FORMAT##--as-separator-line=} -eq 2 ]];then
                echo "${MESSAGE}" 1>&2
            else
                echo "${MESSAGE}"
            fi
            ;;

        --as-banner-line )
            idforge_printMessage '-' --as-separator-line
            idforge_printMessage "$(echo ${MESSAGE} | fold -s -w 66)" --as-stdout-line
            idforge_printMessage '-' --as-separator-line
            ;;

        --as-processing-line )
            idforge_printMessage "`gettext "Processing"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-cropping-line )
            idforge_printMessage "`gettext "Cropping from"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-tuningup-line )
            idforge_printMessage "`gettext "Tuning-up"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-checking-line )
            idforge_printMessage "`gettext "Checking"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-combining-line )
            idforge_printMessage "`gettext "Combining"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-editing-line )
            idforge_printMessage "`gettext "Editing"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-indexing-line* )
            local COLORS=$(echo ${FORMAT} | cut -d'=' -f2)
            idforge_checkFiles -m '[[:digit:]]+' ${COLORS}
            idforge_printMessage "`eval_gettext "Indexing (${COLORS})"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-composing-line )
            idforge_printMessage "`gettext "Composing"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-commenting-line )
            idforge_printMessage "`gettext "Commenting"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-creating-line | --as-updating-line )
            if [[ -a "${MESSAGE}" ]];then
                idforge_printMessage "`gettext "Updating"`: ${MESSAGE}" --as-stdout-line
            else
                idforge_printMessage "`gettext "Creating"`: ${MESSAGE}" --as-stdout-line
            fi
            ;;

        --as-deleting-line )
            idforge_printMessage "`gettext "Deleting"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-reading-line )
            idforge_printMessage "`gettext "Reading"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-savedas-line )
            idforge_printMessage "`gettext "Saved as"`: ${MESSAGE}" --as-stdout-line
            ;;
            
        --as-linkto-line )
            idforge_printMessage "`gettext "Linked to"`: ${MESSAGE}" --as-stdout-line
            ;;
        
        --as-movedto-line )
            idforge_printMessage "`gettext "Moved to"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-translation-line )
            idforge_printMessage "`gettext "Translation"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-translating-line )
            idforge_printMessage "`gettext "Translating"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-validating-line )
            idforge_printMessage "`gettext "Validating"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-template-line )
            idforge_printMessage "`gettext "Template"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-configuration-line )
            idforge_printMessage "`gettext "Configuration"`: ${MESSAGE}" --as-stdout-line
            ;;

        --as-palette-line )
            idforge_printMessage "`gettext "Palette"`: ${MESSAGE}" --as-stdout-line
            ;;

    esac

}
