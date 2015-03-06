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

function email {

    idforge_checkFiles -i 'text' "${RENDER_FROM[*]}"

    local MAILX=/bin/mailx
    local MAILXARGS=''

    local RENDER_FLOW='';            email_setConfigOption 'render-flow'

    local EMAIL_HOST='';             email_setConfigOption 'email-host'
    local EMAIL_AUTH='';             email_setConfigOption 'email-auth'
    local EMAIL_USER='';             email_setConfigOption 'email-auth-user'
    local EMAIL_PASS='';             email_setConfigOption 'email-auth-pass'
    local EMAIL_FROM='';             email_setConfigOption 'email-from'
    local EMAIL_RCPT='';             email_setConfigOption 'email-rcpt'
    local EMAIL_SUBJECT='';          email_setConfigOption 'email-subject'
    local EMAIL_ATTACHMENT='';       email_setConfigOption 'email-attachment'

    idforge_printMessage "${CONFIG_SECTION}" --as-processing-line

    for RENDER_FROM_FILE in ${RENDER_FROM[*]};do
        idforge_setModuleEnvironment -m "${RENDER_FLOW}" -t "child"
    done

}
