#!/bin/bash

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
requiredFunctions=(return_error.sh regexCheck.sh)

functions="../functions"
mysqlSh="../mysql.sh"

cd $scriptDir
cd $functions
allFunctions=$(ls .)

echo "#!/bin/bash" > $mysqlSh
for fnctn in $allFunctions; do
        echo >> $mysqlSh
        cat $fnctn >> $mysqlSh
done
