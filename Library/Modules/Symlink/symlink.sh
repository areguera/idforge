#!/bin/bash
######################################################################
#
#   idforge - Manage identity manuals in community.
#   Copyright © 2015 The CentOS Artwork SIG
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

# Provide an interface for ln command.  It mainly exists to creates
# symbolic links based on information set in configuration files that
# have symlink as value to render-type option. In these sections, the
# render-from and link-target options are used to specify the link
# locations. The link-options option might be used to pass additional
# options to ln command.
function symlink {

    idforge_checkFiles -ef ${RENDER_FROM[${COUNT}]}

    local LN=/bin/ln

    # Retrieve link source. This is the file you want to link. This
    # file is generally inside the repository.
    local LN_SOURCE=${RENDER_FROM[${COUNT}]}

    local LN_OPTIONS=''; symlink_setConfigOption 'link-options'

    local LN_TARGET=''; symlink_setConfigOption 'link-target'

    idforge_printMessage "${LN_TARGET}" --as-creating-line

    ${LN} ${LN_OPTIONS} ${LN_SOURCE} ${LN_TARGET}

}
