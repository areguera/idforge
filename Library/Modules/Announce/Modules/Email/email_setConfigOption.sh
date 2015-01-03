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

function email_setConfigOption {

    local OPTION="${1}"

    case ${OPTION} in

        smtp-mail-host )
            SMTP_MAIL_HOST=$(tcarlib_getConfigValue)
            [[ -z ${SMTP_MAIL_HOST} ]] && SMTP_MAIL_HOST='localhost'
            tcarlib_printMessage "SMTP_MAIL_HOST: ${SMTP_MAIL_HOST}" --as-debbuger-line
            MAILXARGS="smtp=${SMTP_MAIL_HOST}"
            ;;

        smtp-mail-auth )
            SMTP_MAIL_AUTH=$(tcarlib_getConfigValue)
            [[ -n ${SMTP_MAIL_AUTH} ]] && MAILXARGS="smtp-auth=${SMTP_MAIL_AUTH} ${MAILXARGS}"
            tcarlib_printMessage "SMTP_MAIL_AUTH: ${SMTP_MAIL_AUTH}" --as-debbuger-line
            ;;

        smtp-mail-auth-user )
            SMTP_MAIL_AUTH_USER=$(tcarlib_getConfigValue "${ARGUMENT}" "${SECTION}" "smtp-mail-auth-user")
            [[ -n ${SMTP_MAIL_AUTH_USER} ]] && MAILXARGS="smtp-auth-user=${SMTP_MAIL_AUTH_USER} ${MAILXARGS}"
            tcarlib_printMessage "SMTP_MAIL_AUTH_USER: ${SMTP_MAIL_AUTH_USER}" --as-debbuger-line
            ;;

        smtp-mail-auth-pass )
            SMTP_MAIL_AUTH_PASS=$(tcarlib_getConfigValue)
            [[ -n ${SMTP_MAIL_AUTH_PASS} ]] && MAILXARGS="smtp-auth-password=${SMTP_MAIL_AUTH_PASS} ${MAILXARGS}"
            tcarlib_printMessage "SMTP_MAIL_PASS: *****" --as-debbuger-line
            ;;

        smtp-mail-from )
            SMTP_MAIL_FROM=$(tcarlib_getConfigValue)
            [[ -n ${SMTP_MAIL_FROM} ]] && MAILXARGS="from=${SMTP_MAIL_FROM} ${MAILXARGS}"
            tcarlib_printMessage "SMTP_MAIL_FROM: ${SMTP_MAIL_FROM}" --as-debbuger-line
            ;;

        smtp-mail-rcpt )
            SMTP_MAIL_RCPT=$(tcarlib_getConfigValue)
            tcarlib_printMessage "SMTP_MAIL_RCPT: ${SMTP_MAIL_RCPT}" --as-debbuger-line
            tcarlib_checkFiles -m '^([[:alnum:]+-]+@([[:alnum:].-]+)+,?)+$' ${SMTP_MAIL_RCPT}
            ;;

        smtp-mail-subject )
            SMTP_MAIL_SUBJECT=$(tcarlib_getConfigValue "${ARGUMENT}" "${SECTION}" "smtp-mail-subject")
            [[ -z ${SMTP_MAIL_SUBJECT} ]] && SMTP_MAIL_SUBJECT="[${REPORT_HOST}] ${REPORT_TITLE}"
            tcarlib_printMessage "SMTP_MAIL_SUBJECT: ${SMTP_MAIL_SUBJECT}" --as-debbuger-line
            ;;

        smtp-mail-attachment )
            SMTP_MAIL_ATTACHMENT=$(tcarlib_getConfigValue)
            tcarlib_printMessage "SMTP_MAIL_ATTACHMENT: ${SMTP_MAIL_ATTACHMENT}" --as-debbuger-line
            if [[ -n ${SMTP_MAIL_ATTACHMENT} ]];then
                tcarlib_checkFiles -ef ${SMTP_MAIL_ATTACHMENT}
                local ATTACHMENT_LIMIT='500000'
                if [[ $(tcarlib_getFileSize ${SMTP_MAIL_ATTACHMENT}) -gt ${ATTACHMENT_LIMIT} ]];then
                    tcarlib_printMessage "`eval_gettext "The attachment cannot be higher than \\\$ATTACHMENT_LIMIT bytes."`" --as-error-line
                fi
            fi
            ;;

        smtp-mail-security )
            SMTP_MAIL_SECURITY=$(tcarlib_getConfigValue)
            [[ -z ${SMTP_MAIL_SECURITY} ]] && SMTP_MAIL_SECURITY='plain'
            ;;

        * )
            tcarlib_printMessage "${OPTION}: `gettext "isn't a supported option"`" --as-error-line
            ;;
    esac

}
