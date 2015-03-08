#!/bin/bash
######################################################################
#
#   idFORGE Framework - Manage identity manuals in community
#   Copyright © 2015 CentOS Artwork SIG
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

function xml_setInstanceExpandedNested {

    local COUNTSRC=0
    local COUNTDST=0

    while [[ ${COUNTDST} -lt ${#DST[@]} ]];do

        # Verify existence of translation markers. If there is no
        # translation marker on replacement, continue with the next
        # one in the list.
        if [[ ! ${DST[${COUNTDST}]} =~ =[[:upper:]_]+= ]];then
            # Increment destination counter.
            COUNTDST=$((++COUNTDST))
            # The current replacement value doesn't have translation
            # marker inside, so skip it and evaluate the next
            # replacement value in the list.
            continue
        fi

        while [[ ${COUNTSRC} -lt ${#SRC[*]} ]];do

            # Update replacements.
            DST[${COUNTDST}]=$(echo ${DST[${COUNTDST}]} \
                | sed -r "s!${SRC[${COUNTSRC}]}!${DST[${COUNTSRC}]}!g")

            # Increment source counter.
            COUNTSRC=$((++COUNTSRC))

        done

        # Reset source counter
        COUNTSRC=0

        # Increment destination counter.
        COUNTDST=$((++COUNTDST))

    done

}
