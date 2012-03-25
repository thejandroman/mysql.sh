#!/bin/bash

. ../mysql.sh

server='localhost'
user='root'
pass=''
port=3306

link=$(mysql_connect -s $server -u $user -p $pass -P $port)
if [ "$?" -eq "1" ]; then
    printf "Error\n"
    exit
else
    echo $link
fi

results=()
mysql_query -l '$link' -q 'SELECT string FROM mysqlshTest.unitTest1 WHERE id in\
(2,3)' -v $results
