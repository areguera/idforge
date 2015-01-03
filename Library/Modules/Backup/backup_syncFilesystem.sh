#!/bin/bash
######################################################################
#
#   backup - A personal backup tool based on rsync.
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

# This function applies to an environment where there two identical
# hard-drives configured to do software RAID-1 and one external USB
# device for backing up critical information.
function backup_syncFilesystem {

    # Only root can run this script.
    if [[ $(id -u) -ne 0 ]];then
        echo "You need to be root to perform this command."
        return 1
    fi

    # Verify rsync processes in the system. If there is any, don't
    # initiate new ones. This helps to avoid unnecessary rsync loops.
    if [[ ! -z $(ps -C rsync -o pid=) ]];then
        echo 'Rsync is still running. Wait for it to conclude.'
        return
    fi

    local SOURCE_HDD_DIR=/

    local TARGET_USB_MNT=/media/LaCie
    local TARGET_USB_DIR=${TARGET_USB_MNT}/Backups/$(hostname)-fs/

    # Define command string you'll use to do the synchronizing. Here
    # it is very important that you delete files *before* making any
    # transfer.  Otherwise the target hard-drive might end up full,
    # leaving no space to finish the backup.
    local RSYNC="/usr/bin/rsync -auz --delete-before"

    # Verify that external device is mounted in the correct location
    # and initiate backup.
    mount | grep ${TARGET_USB_MNT} > /dev/null
    if [[ $? -eq 0 ]];then
        ${RSYNC} --filter=". ${BACKUP_SCRIPT_CONFIGS}/filelist-2.rsync" ${SOURCE_HDD_DIR} ${TARGET_USB_DIR}
    fi

}
