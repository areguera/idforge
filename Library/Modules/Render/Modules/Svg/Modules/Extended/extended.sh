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

function extended {

    HEIGHTS="$(echo ${SVG_FLOW_OPTIONS} | cut -d: -f1 | tr ',' ' ')"
    FGCOLORS="$(echo ${SVG_FLOW_OPTIONS} | cut -d: -f2 | tr ',' ' ')"
    BGCOLORS="$(echo ${SVG_FLOW_OPTIONS} | cut -d: -f3 | tr ',' ' ')"

    # Process extended rendition based on configuration options.
    for BGCOLOR in ${BGCOLORS};do
        idforge_checkFiles -m '^[[:alnum:]]{6}-(1|0(\.[[:digit:]]+)?)$' ${BGCOLOR}
        svg_setInkscapeBgColors
        svg_setInkscapeBgOpacity
        for FGCOLOR in ${FGCOLORS};do
            idforge_checkFiles -m '^[[:alnum:]]{6}-(1|0(\.[[:digit:]]+)?)$' ${BGCOLOR}
            # Create a new instance from the each instance already
            # created.  This is necessary to prevent the first cycle
            # of transformations from affecting subsequent cycles
            # transformations.  The reason behind this is that a
            # pattern is used to perform instance transformations and,
            # if the first cycle of transformations changes that
            # pattern, further transformations won't find the pattern
            # they need to do their job.
            INKSCAPE_INPUT=$(idforge_printTemporalFile ${RENDER_FROM_INSTANCE})
            install -Tp ${RENDER_FROM_INSTANCE} ${INKSCAPE_INPUT}
            svg_setInkscapeFgColors
            svg_setInkscapeFgOpacity
            for HEIGHT in ${HEIGHTS};do
                idforge_checkFiles -m '^[[:digit:]]+$' ${HEIGHT}
                svg_setInkscapeHeight
                local INKSCAPE_OUTPUT=$(dirname ${RENDER_FILE})/${BGCOLOR}/${FGCOLOR}/${HEIGHT}/$(basename ${RENDER_FILE})
                svg_setInkscapeCommand
            done
        done
    done

}
