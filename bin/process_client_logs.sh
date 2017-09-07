#!/bin/bash
cd $1

grep -rh .| awk '/Failed password for/{
if ($9 == "invalid")
    print $1, $2,substr($3,1,2), $11, $13;
else
    print $1, $2,substr($3,1,2), $9, $11;
}' | cat > failed_login_data.txt


cp failed_login_data.txt ~
