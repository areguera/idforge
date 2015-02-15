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

function svg_setInkscape {

    # Define whether we are exporting the entire document area or an
    # specific object id.
    svg_setInkscapeExportId

    local INKSCAPE_INPUT=''
    local INKSCAPE_OPTIONS=''

    # Retrieve values from configuration options.
    local SVG_FLOW=''           ; svg_setConfigOption 'svg-flow'
    local SVG_FLOW_OPTIONS=''   ; svg_setConfigOption 'svg-flow-options'

    # Process rendition flow as provided in the configuration file.
    idforge_setModuleEnvironment -m ${SVG_FLOW} -t 'child'

}
