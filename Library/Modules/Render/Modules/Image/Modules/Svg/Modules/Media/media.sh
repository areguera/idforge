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

# Produce artwork for installation media.
function media {

    local MEDIA_TYPE=''     ; media_setConfigOption 'media-type'
    local MEDIA_RELEASE=''  ; media_setConfigOption 'media-release'
    local MEDIA_ARCH=''     ; media_setConfigOption 'media-arch'

    for TYPE in ${MEDIA_TYPE};do

        local MEDIA_NUMBER=$(echo ${TYPE} | cut -d* -f2)
        idforge_checkFiles -m '^[[:digit:]]+$' "${MEDIA_NUMBER}"
        local MEDIA_NUMBER_CURRENT=1

        local TYPE=$(echo ${TYPE} | cut -d* -f1)

        while [[ ${MEDIA_NUMBER_CURRENT} -le ${MEDIA_NUMBER} ]];do
            for RELEASE in ${MEDIA_RELEASE};do
                for ARCH in ${MEDIA_ARCH};do
                    media_setRenditionBase
                done
            done
            MEDIA_NUMBER_CURRENT=$(( ++MEDIA_NUMBER_CURRENT ))
        done

    done 

}
