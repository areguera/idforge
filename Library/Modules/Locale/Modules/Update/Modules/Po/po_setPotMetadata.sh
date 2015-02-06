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

# This function corrects information set in POT files created by
# xgettext command which make msginit command to report warning
# messages about what it considers unportable or problematic. Since
# the POT file is expected to be corrected before using it as base to
# create the PO file, it is convenient to simulate that correction
# actions here.
function po_setPotMetadata {

    # Get rid of the warning message about unportable codification
    # when processing POT file just created through xgettext command.
    sed -i 's,CHARSET,ISO-8859-1,' ${POT}

}
