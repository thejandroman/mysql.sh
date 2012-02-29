mysql.sh
========

A MySQL API for bash based on PHP
[Original MySQL API](http://php.net/manual/en/book.mysql.php). Not
much here yet but more coming soon.

Functions
---------

### mysql_connect

**Description**

    mysql_connect $server $username $password $port

**Parameters**

*server*

    The MySQL server.

*username*

    The username.

*password*

    The password

*port*

    The server port. If blank this defaults to 3306.

**Return Values**

Returns a string containing MySQL command line connection parameters
on success or **1** on failure.

**Examples**

Example #1 mysql_connect() example

    . mysql.sh
    link=$(mysql_connect localhost mysql_user mysql_password)
    if [ "$?" -eq "1" ]; then
        printf "Error\n"
        exit
    else
        echo $link
    fi
