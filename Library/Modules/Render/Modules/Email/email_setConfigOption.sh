#!/bin/bash
######################################################################
#
#   idFORGE Framework - Manage identity manuals in community
#   Copyright © 2015 The CentOS Artwork SIG
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

function email_setConfigOption {

    local CONFIG_OPTION="${1}"

    case ${CONFIG_OPTION} in

        render-flow )
            RENDER_FLOW=$(render_printConfigValues 'plain')
            idforge_printMessage "RENDER_FLOW: ${RENDER_FLOW}" --as-debbuger-line
            ;;

        email-host )
            EMAIL_HOST=$(render_printConfigValues 'localhost')
            email_verifyHost
            idforge_printMessage "EMAIL_HOST: ${EMAIL_HOST}" --as-debbuger-line
            MAILXARGS="smtp=${EMAIL_HOST}"
            ;;

        email-auth )
            EMAIL_AUTH=$(render_printConfigValues)
            [[ -n ${EMAIL_AUTH} ]] && MAILXARGS="smtp-auth=${EMAIL_AUTH} ${MAILXARGS}"
            idforge_printMessage "EMAIL_AUTH: ${EMAIL_AUTH}" --as-debbuger-line
            ;;

        email-auth-user )
            EMAIL_AUTH_USER=$(render_printConfigValues "${ARGUMENT}" "${SECTION}" "email-auth-user")
            [[ -n ${EMAIL_AUTH_USER} ]] && MAILXARGS="smtp-auth-user=${EMAIL_AUTH_USER} ${MAILXARGS}"
            idforge_printMessage "EMAIL_AUTH_USER: ${EMAIL_AUTH_USER}" --as-debbuger-line
            ;;

        email-auth-pass )
            EMAIL_AUTH_PASS=$(render_printConfigValues)
            [[ -n ${EMAIL_AUTH_PASS} ]] && MAILXARGS="smtp-auth-password=${EMAIL_AUTH_PASS} ${MAILXARGS}"
            idforge_printMessage "EMAIL_PASS: *****" --as-debbuger-line
            ;;

        email-from )
            EMAIL_FROM=$(render_printConfigValues "$(id -un)@localhost")
            [[ -n ${EMAIL_FROM} ]] && MAILXARGS="from=${EMAIL_FROM} ${MAILXARGS}"
            idforge_printMessage "EMAIL_FROM: ${EMAIL_FROM}" --as-debbuger-line
            ;;

        email-rcpt )
            EMAIL_RCPT=$(render_printConfigValues "$(id -un)@localhost")
            idforge_printMessage "EMAIL_RCPT: ${EMAIL_RCPT}" --as-debbuger-line
            idforge_checkFiles -m '^([[:alnum:]+-]+@([[:alnum:].-]+)+,?)+$' ${EMAIL_RCPT}
            ;;

        email-subject )
            EMAIL_SUBJECT=$(render_printConfigValues "${CONFIG_SECTION}")
            idforge_printMessage "EMAIL_SUBJECT: ${EMAIL_SUBJECT}" --as-debbuger-line
            ;;

        email-attachment-limit )
            EMAIL_ATTACHMENT_LIMIT=$(render_printConfigValues '30000') # in bytes
            idforge_checkFiles -m '[[:digit:]]+' ${EMAIL_ATTACHMENT_LIMIT}
            ;;

        email-attachment )
            EMAIL_ATTACHMENT="$(render_printConfigValues)"
            email_verifyAttachment
            idforge_printMessage "EMAIL_ATTACHMENT: ${EMAIL_ATTACHMENT}" --as-debbuger-line
            ;;

        * )
            idforge_printMessage "${CONFIG_OPTION}: `gettext "isn't a supported option"`" --as-error-line
            ;;
    esac

}
