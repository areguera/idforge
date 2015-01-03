#!/bin/bash
######################################################################
#
#   ahs - AHS automation tools
#   Copyright © 2015 Alain Reguera Delgado
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

function download_checkExitStatus {

    case ${1} in

        0  )
            download_printReportChunks
            download_checkProtocol
            DOWNLOAD_CHUNKS_TOTAL=$(( DOWNLOAD_CHUNKS_TOTAL + 1 ))
            continue
            ;;

        18 )
            # Partial file. Only a part of the file was transferred.
            break
            ;;

        22 )
            # HTTP page not retrieved. The requested url was not found
            # or returned another error with the  HTTP error code
            # being 400 or above.
            break
            ;;

        33 )
            # HTTP range error. The range "command" didn’t work.
            break
            ;;

        * )
            exit ${1}
            ;;
    esac

}
