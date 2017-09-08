#!/bin/bash
cd $1
#Searches through the log files recursivly for failed logins
#If statement filters between valid users and invalid users
#And cats it to failed_login_data.txt
grep -rh .| awk '/Failed password for/{
if ($9 == "invalid")
    print $1, $2,substr($3,1,2), $11, $13;
else
    print $1, $2,substr($3,1,2), $9, $11;
}' | cat > failed_login_data.txt



