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

function cryptic {

    # Encrypt everything for the e-mail addresses provided as
    # recipients in the configuration file only.
    local GPG_OPTIONS=''
    local GPG_ENCRYPT_UIDS=$(echo ${SMTP_MAIL_RCPT} | tr ',' ' ')
    for GPG_ENCRYPT_UID in ${GPG_ENCRYPT_UIDS};do
        gpg --list-key ${GPG_ENCRYPT_UID} &> /dev/null
        if [[ $? -ne 0 ]];then
            tcarlib_printMessage "`eval_gettext "There isn't a public key for \\\"\\\$GPG_ENCRYPT_UID\\\" in your GPG keys ring."`" --as-error-line
        fi
        GPG_OPTIONS="-r ${GPG_ENCRYPT_UID} ${GPG_OPTIONS}"
    done

    # Encrypt attachment, too.
    if [[ -n ${SMTP_MAIL_ATTACHMENT} ]];then
        local ATTACHMENT=${SCRIPT_TEMPDIR}/$(basename ${SMTP_MAIL_ATTACHMENT}).gpg
        [[ -f ${ATTACHMENT} ]] && rm ${ATTACHMENT}
        gpg ${GPG_OPTIONS} -o ${ATTACHMENT} -e ${SMTP_MAIL_ATTACHMENT}
        SMTP_MAIL_ATTACHMENT="-a ${ATTACHMENT}"
    fi

    # Encrypt mail body before send it out.
    cat ${REPORT_FILE} \
        | gpg -a ${GPG_OPTIONS} -e \
        | env MAILRC=/dev/null ${MAILXARGS} \
              mailx -n -s "${SMTP_MAIL_SUBJECT}" \
                    ${SMTP_MAIL_ATTACHMENT} \
                    ${SMTP_MAIL_RCPT}

}
