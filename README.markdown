mysql.sh
========

A MySQL API for bash based on PHP
[Original MySQL API](http://php.net/manual/en/book.mysql.php). Not
much here yet but more coming soon.

Functions
---------

### mysql_connect

**Description**

    mysql_connect -s $server -u $username -p $password -P $port -S

**Parameters**

*-s server*

    The MySQL server.

*-u username*

    The username.

*-p password*

    The password.

*-P port*

    The server port. If blank this defaults to 3306.

*-S*

    Disables mysql client's secure authentication. Secure
    authentication is enabled by default.

**Return Values**

Returns a string containing MySQL command line connection parameters
on success or **1** on failure.

**Examples**

Example #1: mysql_connect() example

    . /path/to/mysql.sh
    link=$(mysql_connect -s localhost -P 3306 -u mysql_user -p mysql_password)
    if [ "$?" -eq "1" ]; then
        printf "Error\n"
        exit
    else
    echo $link
    # mysql --secure-auth --batch --host=localhost --port=3306 --user=mysql_user --password=mysql_password
    fi

### mysql_query

**Description**

    mysql_query -l $link -q $query -v $array

**Parameters**

*-l link*

    link

*-q query*

    query

*-v array variable*

    array variable

**Return Values**

Returns

**Examples**

Example #1: mysql_query() example

    . /path/to/mysql.sh
