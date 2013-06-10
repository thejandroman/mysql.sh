#!/bin/bash

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
requiredFunctions=(return_error.sh regexCheck.sh)

functions="../functions"
mysqlSh="../mysql.sh"

cd $scriptDir
cd $functions
allFunctions=$(ls .)

echo "#!/bin/bash" > $mysqlSh
cat <<EOF >> $mysqlSh

#    Copyright (C) 2012,2013  Alejandro Figueroa
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
EOF
for fnctn in $allFunctions; do
        echo >> $mysqlSh
        cat $fnctn >> $mysqlSh
done
