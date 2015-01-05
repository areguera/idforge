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

# Standardize the copyright information printed on content produced by
# idforge script.
#
# As far as I understand, the copyright exists to make people create
# more.  The copyright gives creators the legal power over their
# creations and so the freedom to distribute them under the ethical
# terms the creator considers better.  At this moment I don't feel
# very confident about this legal affairs and their legal
# implications, but I need to decide what copyright information
# idforge command-line will print out when someone request information
# about it.  So, in that sake, I am using CentOS Project as copyright
# holder and the GNU Public License, version 2 or any later, for
# software copying.
function status_printCopyright {

    case "${1}" in

        --license )
            idforge_printUrl 'license'
            ;;

        --first-year )

            # The former year when I (as collaborator of the CentOS
            # Project) started to consolidate the CentOS Project
            # Corporate Visual Identity through the CentOS Artwork
            # Repository.
            echo '2009'
            ;;

        --year|--last-year)

            # The last year of active development.
            echo '2015'
            ;;

        --years-range )

            local FIRST_YEAR=$(status_printCopyright --first-year)
            local LAST_YEAR=$(status_printCopyright --last-year)
            echo "${FIRST_YEAR}-${LAST_YEAR}"
            ;;

        --years-list )

            local FIRST_YEAR=$(status_printCopyright --first-year)
            local LAST_YEAR=$(status_printCopyright --last-year)

            # Define full copyright year string based on first and
            # last year.
            local FULL_YEAR=$(\
                while [[ ${FIRST_YEAR} -le ${LAST_YEAR} ]];do
                    echo -n "${FIRST_YEAR}, "
                    FIRST_YEAR=$((${FIRST_YEAR} + 1))
                done)

            # Prepare full copyright year string and print it out.
            echo "${FULL_YEAR}" | sed 's!, *$!!'
            ;;

        --holder )

            # Print automation scripts' default copyright holder. This
            # is the juridic person responsible of protecting the
            # creation work against LICENSE violations. I trust this
            # responsibility to CentOS Artwork SIG, from CentOS
            # Project organization. 
            echo "`gettext "CentOS Artwork SIG"`"
            ;;

        --holder-predicate )

            local HOLDER=$(status_printCopyright --holder)
            echo "${HOLDER}. `gettext "All rights reserved."`"
            ;;

        * )

            local YEAR=$(status_printCopyright --last-year)
            local HOLDER=$(status_printCopyright --holder)
            echo "Copyright © ${YEAR} ${HOLDER}"
            ;;

    esac

}
