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

function lss {

    # Define the HEX indexed. The HEX indexed is built from source
    # indexed (PALETTE_GPL) and provides the color information in the
    # format understood by `ppmtolss16', the program used to produce
    # images in LSS16 format.  The HEX indexed stores just one line
    # with the color information as described in isolinux
    # documentation (i.e #RRGGBB=0 #RRGGBB=1 ... [all values in the
    # same line])
    local PALETTE_HEX_COLORS=$(indexed_convertGplToHex)

    # Create LSS16 image to verify everything went right with its
    # construction (e.g., see the log files created with it).
    lss_setImage

    # Create script used to build the final LSS16 image when the
    # distribution's installer is in action.
    lss_setShell

}
