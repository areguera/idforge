#!/bin/bash
######################################################################
#
#   idforge-modules-hello - Print a greeting and exit successfully.
#   Copyright © 2015 CentOS Artwork SIG
#
#   idforge-modules-hello is free software; you can redistribute it
#   and/or modify it under the terms of the GNU General Public License
#   as published by the Free Software Foundation; either version 2 of
#   the License, or (at your option) any later version.
#
#   idforge-modules-hello is distributed in the hope that it will be
#   useful, but WITHOUT ANY WARRANTY; without even the implied
#   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#   See the GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with idforge-modules-hello; if not, write to the Free
#   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <alain.reguera@gmail.com>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

function hello_printDescription {

    idforge_printMessage "`gettext "Print a greeting and exit successfully."`" --as-stdout-line

}
