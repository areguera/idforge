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

# Look workplace configuration files up in the directory structure and
# stop looking at the first match.
function idforge_checkWorkdirLookup {

    local WORKDIR_CONF_FILES=''

    # Create a list of all possible directories based on the argument
    # provided in the command line.
    until [[ ${WORKDIR_CONF_DIR} == '/' ]];do
        pushd ${WORKDIR_CONF_DIR} > /dev/null
        WORKDIR_CONF_FILES="${WORKDIR_CONF_FILES} ${PWD}/.${IDFORGE}.conf"
        WORKDIR_CONF_DIR=$(dirname ${PWD})
        popd > /dev/null
    done

    # Look for configuration files in each directory found. Stop
    # looking when one directory matches the workplace set in the
    # configuration file.
    for WORKDIR_CONF_FILE in ${WORKDIR_CONF_FILES};do
        if [[ -f ${WORKDIR_CONF_FILE} ]];then
            . ${WORKDIR_CONF_FILE}
        fi
        WORKDIR_CONF_DIR=$(dirname ${WORKDIR_CONF_FILE})
        if [[ ${WORKDIR_CONF_DIR} == ${IDFORGE_WORKDIR} ]];then
            break
        fi
    done

    # Output the information so it can be read on higher environments.
    echo ${IDFORGE_WORKDIR}

}
