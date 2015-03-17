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

function idforge {

    #=================================================================
    # Internationalization
    #=================================================================

    # Set function environments required by GNU gettext system.
    . gettext.sh

    # Set the script text domain. This information is used by gettext
    # system to retrieve translated strings from machine object (MO)
    # files with this name. The value of this variable is reset in
    # shared function and modules, to retrieve specific localization.
    declare -x TEXTDOMAIN="${IDFORGE}"

    # Set the script text domain directory. This information is used
    # by gettext system to know where the machine object (MO) files
    # are stored in. The value of variable is the same for shared
    # functions and modules, so it is exported to the shell
    # environment for wide use.
    declare -x TEXTDOMAINDIR=${TEXTDOMAINDIR:-/usr/share/locale}

    # Set the script language information using the LC format. This
    # format shows both language and country information (e.g.,
    # `es_ES').
    local -r IDFORGE_LANG_LC=$(echo ${LANG} | cut -d'.' -f1)

    # Set the script language information using the LL format. This
    # format shows only the language information (e.g., `es').
    local -r IDFORGE_LANG_LL=$(echo ${IDFORGE_LANG_LC} | cut -d'_' -f1)

    # Set the script language information using the CC format. This
    # format shows only the country information (e.g., `ES').
    local -r IDFORGE_LANG_CC=$(echo ${IDFORGE_LANG_LC} | cut -d'_' -f2)

    #=================================================================
    # Paths
    #=================================================================

    # Absolute path to design models.
    local IDFORGE_MODELS=${IDFORGE_MODELS:-/usr/share/${IDFORGE}/Models}

    # Base directory where automation script modules are installed in.
    local -r IDFORGE_MODULES=${IDFORGE_LIBRARY}/Modules

    # Base directory where documentation manuals are installed in.
    local -r IDFORGE_MANUALS=${IDFORGE_MANUALS:-/usr/share/man}

    # Directory to store temporal files. CAUTION: Don't make this
    # variable local. If you do so, the trap built-in won't be able to
    # read its value and, as consequence, temporal directories will be
    # created and created but never deleted!
    IDFORGE_TEMPDIR=$(mktemp -p /tmp -d ${IDFORGE}-XXXXXX)

    #=================================================================
    # Flags
    #=================================================================

    # Set filter flag (-f|--filter).  This flag is mainly used to
    # reduce the number of files to process and is interpreted as
    # egrep-posix regular expression.  By default, when this flag is
    # not provided, all paths in the working copy will match, except
    # files inside hidden directories like `.svn' and `.git' that will
    # be omitted.
    local IDFORGE_FLAG_FILTER='[[:alnum:]_/.-]+'

    # Set verbosity flag (-q|--quiet). This flag controls whether
    # idforge.sh script prints messages or not. By default, all
    # messages are suppressed except those directed to standard error.
    local IDFORGE_FLAG_QUIET='false'

    # Set affirmative flag (-y|--yes). This flag controls whether
    # idforge.sh script does or does not pass confirmation request
    # points. By default, it doesn't.
    local IDFORGE_FLAG_YES='false'

    # Set debugger flag (-d|--debug). This flag controls whether
    # idforge.sh script does or does not print debugging information.
    # The idforge.sh script prints debug information to standard
    # output.
    local IDFORGE_FLAG_DEBUG='false'

    #=================================================================
    # Functions
    #=================================================================

    local IDFORGE_FUNCTION=''
    local -r IDFORGE_FUNCTIONS=$(find ${IDFORGE_LIBRARY} -type f -name "${IDFORGE}_*.sh")

    for IDFORGE_FUNCTION in ${IDFORGE_FUNCTIONS};do
        if [[ -x ${IDFORGE_FUNCTION} ]];then
            . ${IDFORGE_FUNCTION}
            export -f $(grep '^function ' ${IDFORGE_FUNCTION} | cut -d' ' -f2)
        else
            echo "${IDFORGE}: ${IDFORGE_FUNCTION} `gettext "is not executable."`"
            exit 1
        fi
    done

    #=================================================================
    # Signals
    #=================================================================

    # Trap signals in order to terminate the script execution
    # correctly (e.g., removing all temporal files before leaving).
    # Trapping the exit signal seems to be enough by now, since it is
    # always present as part of the script execution flow. Each time
    # the idforge.sh script is executed it will inevitably end with an
    # EXIT signal at some point of its execution, even if it is
    # interrupted in the middle of its execution (e.g., by pressing
    # `Ctrl+C').
    trap idforge_removeTemporals 0

    #=================================================================
    # Usage (default action)
    #=================================================================

    [[ $# -eq 0 ]] && idforge_setModuleEnvironment -t 'child' -m 'usage'

    #=================================================================
    # Arguments
    #=================================================================

    local ARGUMENTS=''; idforge_setOptions "${@}"; eval set -- "${ARGUMENTS}"

    [[ $# -eq 0 ]] && return

    #=================================================================
    # Modules
    #=================================================================

    local IDFORGE_MODULE_NAME="${1}"; shift 1
    local IDFORGE_MODULE_ARGUMENTS=''

    for ARGUMENT in ${@};do
        IDFORGE_MODULE_ARGUMENTS="-g ${ARGUMENT} ${IDFORGE_MODULE_ARGUMENTS}"
    done

    idforge_setModuleEnvironment -m "${IDFORGE_MODULE_NAME}" ${IDFORGE_MODULE_ARGUMENTS}

    #=================================================================
    # Exit
    #=================================================================

    local IDFORGE_EXIT=${?}

    idforge_printMessage "IDFORGE_EXIT: ${IDFORGE_EXIT}" --as-debugger-line

    return ${IDFORGE_EXIT}

}
