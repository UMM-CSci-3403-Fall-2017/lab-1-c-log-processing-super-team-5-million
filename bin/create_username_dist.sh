#!/bin/bash
home=$(pwd)
cd $1
grep -rh --include="failed_login_data.txt" .| awk '{print $4}' | cat > usernames.txt
sort usernames.txt | uniq -c | cat > counts.txt
awk '{print "data.addRow([\x27"$2"\x27, "$1"]);"}' counts.txt | cat > create_username_dist.txt
mv create_username_dist.txt $home/html_components
cd $home
cp bin/wrap_contents.sh $home/html_components
cd html_components
./wrap_contents.sh create_username_dist.txt username_dist username_dist.html
cp username_dist.html ~
mv username_dist.html $1
rm wrap_contents.sh
rm create_username_dist.txt
