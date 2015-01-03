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

# Get system information, create reports and output the result to
# standard output for further processing.
function report {

    # Initialize command-line arguments.
    local ARGUMENT='' ARGUMENTS=''

    # Interpret module-specific options and store related actions.
    report_getOptions "${@}"

    for ARGUMENT in ${ARGUMENTS};do
        report_parseConfiguration
    done

}
