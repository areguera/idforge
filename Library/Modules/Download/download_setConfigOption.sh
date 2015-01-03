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

function download_setConfigOption {

    local -a CONFIGPATHS; 
    local CONFIGPATH=''; 
    local CONFIGURATION=''

    CONFIGPATHS[0]=/etc/${SCRIPT_NAME}/${SCRIPT_NAME}-${SCRIPT_MODULE_NAME}.conf
    CONFIGPATHS[1]=${HOME}/.${SCRIPT_NAME}-${SCRIPT_MODULE_NAME}.conf
    CONFIGPATHS[2]=.${SCRIPT_NAME}-${SCRIPT_MODULE_NAME}.conf
    for CONFIGPATH in ${CONFIGPATHS[*]};do
        [[ -f ${CONFIGPATH} ]] && CONFIGURATION=${CONFIGPATH}
    done

    tcarlib_checkFiles -f ${CONFIGURATION}

    local SECTION="${SCRIPT_NAME}-${SCRIPT_MODULE_NAME}"

    local OPTION=${1}

    case ${OPTION} in

        download-file )
            local DOWNLOAD_URL=''; download_setConfigOption 'download-url'
            local DOWNLOAD_DIR=''; download_setConfigOption 'download-dir'
            local DOWNLOAD_FILENAME=$(basename ${DOWNLOAD_URL})
            DOWNLOAD_FILE="${DOWNLOAD_DIR}/${DOWNLOAD_FILENAME}"
            tcarlib_setParentDir "${DOWNLOAD_FILE}"
            ;;

        download-url )
            DOWNLOAD_URL=${ARGUMENT}
            [[ -n ${DOWNLOAD_URL} ]] \
                && tcarlib_checkFiles -m '^(https|http|ftp|file)://' ${DOWNLOAD_URL}
            ;;

        download-dir )
            DOWNLOAD_DIR=$(tcarlib_getConfigValue)
            [[ -z ${DOWNLOAD_DIR} ]] && DOWNLOAD_DIR=${HOME}/Downloads
            ;;

        download-chunk-size )
            DOWNLOAD_CHUNK_SIZE=$(tcarlib_getConfigValue)
            [[ -z ${DOWNLOAD_CHUNK_SIZE} ]] \
                && DOWNLOAD_CHUNK_SIZE=$(( (1024**2)*1 ))
            tcarlib_checkFiles -m '^[[:digit:]]+$' ${DOWNLOAD_CHUNK_SIZE}
            ;;

        download-proxy )
            DOWNLOAD_PROXY=$(tcarlib_getConfigValue)
            ;;

        download-proxyuser )
            DOWNLOAD_PROXYUSER=$(tcarlib_getConfigValue)
            ;;

        download-command )

            local DOWNLOAD_CHUNK_OFFSET=$(download_printBytesTotal ${DOWNLOAD_FILE})
            local DOWNLOAD_CHUNK_END=$(( DOWNLOAD_CHUNK_OFFSET + DOWNLOAD_CHUNK_SIZE - 1 ))

            DOWNLOAD_COMMAND='/usr/bin/curl -f'
            DOWNLOAD_COMMAND="${DOWNLOAD_COMMAND} -r ${DOWNLOAD_CHUNK_OFFSET}-${DOWNLOAD_CHUNK_END}"
            if [[ -n ${DOWNLOAD_PROXY} ]];then
                DOWNLOAD_COMMAND="${DOWNLOAD_COMMAND} -x ${DOWNLOAD_PROXY}"
                if [[ -n ${DOWNLOAD_PROXYUSER} ]];then
                    DOWNLOAD_COMMAND="${DOWNLOAD_COMMAND} -U ${DOWNLOAD_PROXYUSER}"
                fi
            fi
            DOWNLOAD_COMMAND="${DOWNLOAD_COMMAND} ${DOWNLOAD_URL}"
            ;;

        * )
            tcarlib_printMessage "`gettext "the option provided isn't supported"`" --as-error-line
            ;;

    esac

}
