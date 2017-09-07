#!/bin/bash
cd $1
grep -rh .| awk '/Failed password for invalid user/{print $1, $2,substr($3,1,2), $11, $13}' > temp.txt

grep -rh .| awk '/Failed password for [^invalid]/{print $1, $2,substr($3,1,2), $9, $11}' > temp2.txt

cat temp.txt temp2.txt > failed_login_data.txt

rm temp.txt temp2.txt

cp failed_login_data.txt ~
