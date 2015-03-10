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

# Retrieves absolute paths from instances and checks their existence.
# In order for design models to point to different artistic motifs,
# design models make use of external files which point to specific
# artistic motif background images. If such external files don't
# exist, try to create the background image required by cropping a
# higher background image immediately available.  If this isn't
# possible either (e.g., no background images is available), then
# create the background image using a plain color as last option.  We
# can't go on without the required background information.
function svg_verifyInstancePaths {

    # Verify existence of file we need to retrieve absolute paths from.
    idforge_checkFiles -ef "${RENDER_FROM_INSTANCE}"

    # Retrieve absolute paths from file.
    local BG_DST_FILE='' BG_DST_FILES=$(svg_printModelPaths "${RENDER_FROM_INSTANCE}")

    # Process absolute paths retrieved from file.
    for BG_DST_FILE in ${BG_DST_FILES};do

        # Remove protocol from file path so we can work with the
        # absolute path only.
        BG_DST_FILE=$(echo "${BG_DST_FILE}" | sed 's,^file://,,')

        # Be sure the background image retrieved from source file
        # instance has regular path format.
        idforge_checkFiles -m '^/[[:alnum:]][[:alnum:]_./-]+' ${BG_DST_FILE}

        # In case the file provided doesn't exist, determine it
        # intelligently (e.g., by cropping it from the closest
        # background image available).
        [[ ! -a ${BG_DST_FILE} ]] && svg_setCroppedImage

        # Verify existence of required background image.
        idforge_checkFiles -ef ${BG_DST_FILE}

    done

}
