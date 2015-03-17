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

# This function takes a portable object template (.pot) and creates a
# language-specific portable object (.po) for it.
function po_convertPotToPo {

    idforge_setParentDir ${PO}

    if [[ -f ${PO} ]];then

        # Merge the POT file with current PO file.
        msgmerge --output-file="${PO}" "${PO}" "${POT}"

    else

        # Very the LANG environment variable you'll use as reference
        # to create the PO file. Be sure that both language and
        # charset are provided, at least (e.g., If the charset value
        # isn't in the LANG environment variable, the PO file is
        # created for ASCII charset which may or may not be
        # appropriate for your needs). Whenever you run
        # idforge-locale(1) command, provide the LANG environment
        # variable in the command-line with the appropriate charset in
        # it (e.g., es.UTF-8, es_ES.UTF-8).
        idforge_checkFiles -m '^[[:lower:]]{2}(_[[:upper:]]{2})?.[[:alnum:]-]+$' ${LANG}

        # Initialize the POT file.
        msginit -i ${POT} -o ${PO} --locale=${LANG} --width=70 --no-translator

    fi

}
