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

function cryptic {

    local GPG=/usr/bin/gpg

    local GPG_OPTIONS=''

    cryptic_setGpgOptions
    
    cryptic_setGpgAttachment

    cat ${RENDER_FROM_FILE} \
        | ${GPG} -a ${GPG_OPTIONS} -e \
        | env MAILRC=/dev/null ${MAILXARGS} \
              ${MAILX} -n -s "${EMAIL_SUBJECT}" \
                    ${EMAIL_ATTACHMENT} \
                    ${EMAIL_RCPT}

}
