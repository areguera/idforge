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

function scripts_setValidationLine {

    until [[ -z "${COMMAND}" ]];do

        # Concatenate one new command-line to shell script.
        cat >> ${QATEST_UNIT}.sh <<FILE
test_setCommand "${COMMAND}"
FILE

        # Execute the command-line to reproduce the directory
        # structure it produces as output. This command execution
        # should not be validated. Its only purpose is making related
        # files temporarily available, so it can be possible to build
        # the files they need to be affected by integrity checks.
        if [[ ${QATEST_FLAG_FILETYPES} == 'true' || ${QATEST_FLAG_DIGESTS} == 'true' ]];then
            eval ${QATEST_FLAG_COMMAND} ${COMMAND} > /dev/null
        fi

        # Read standard input to get the next command-line.
        read -p "${QATEST_FLAG_COMMAND} " COMMAND

    done

}
