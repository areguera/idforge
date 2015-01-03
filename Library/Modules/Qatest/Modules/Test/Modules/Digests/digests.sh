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

function digests {

    local INTEGRITY_DIGEST_REGEX='(sha256sum|sha1sum|md5sum)'

    local INTEGRITY_DIGESTS=$(idforge_printFileList -a 1 -i 1 -t f -p ".+/${QATEST_UNIT_NAME}\.${INTEGRITY_DIGEST_REGEX}$" ${QATEST_UNIT_DIR})

    for INTEGRITY_DIGEST in ${INTEGRITY_DIGESTS};do

        local INTEGRITY_DIGEST_COMMAND=$(echo ${INTEGRITY_DIGEST} | sed -r "s,^.+\.${INTEGRITY_DIGEST_REGEX}$,\1,")

        [[ ! -x /usr/bin/${INTEGRITY_DIGEST_COMMAND} ]] && continue

        /usr/bin/${INTEGRITY_DIGEST_COMMAND} --quiet -c ${INTEGRITY_DIGEST}

        test_setStatus "${?}" "${INTEGRITY_DIGEST}"

    done

}
