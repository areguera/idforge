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

function email {

    local MAILXARGS=''

    local SMTP_MAIL_HOST='';        email_setConfigOption 'smtp-mail-host'
    local SMTP_MAIL_AUTH='';        email_setConfigOption 'smtp-mail-auth'
    local SMTP_MAIL_USER='';        email_setConfigOption 'smtp-mail-auth-user'
    local SMTP_MAIL_PASS='';        email_setConfigOption 'smtp-mail-auth-pass'
    local SMTP_MAIL_FROM='';        email_setConfigOption 'smtp-mail-from'
    local SMTP_MAIL_RCPT='';        email_setConfigOption 'smtp-mail-rcpt'
    local SMTP_MAIL_SUBJECT='';     email_setConfigOption 'smtp-mail-subject'
    local SMTP_MAIL_ATTACHMENT='';  email_setConfigOption 'smtp-mail-attachment'
    local SMTP_MAIL_SECURITY='';    email_setConfigOption 'smtp-mail-security'

    tcarlib_setModuleEnvironment -m "${SMTP_MAIL_SECURITY}" -t "child"

}
