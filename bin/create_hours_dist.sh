#!/bin/bash
home=$(pwd)
cd $1
#looks through all directories and populates hours.txt with only the hours
grep -rh --include="failed_login_data.txt" .| awk '{print $3}' | cat > hours.txt
#sorts hours.txt
sort hours.txt | uniq -c | cat > count_hours.txt
#makes create_hours_dist.txt and populates it with properly formated .dataAddRow arguments
awk '{print "data.addRow([\x27"$2"\x27,"$1"]);"}' count_hours.txt | cat > create_hours_dist.txt
#removing temporary files and moving create_hours_dist.txt to proper directory
mv create_hours_dist.txt $home/html_components
rm count_hours.txt hours.txt
cd $home
#uses necessary txt and html files to make hours_dist.html
cp bin/wrap_contents.sh $home/html_components
cd html_components
./wrap_contents.sh create_hours_dist.txt hours_dist hours_dist.html
#moving hours_dist.html to proper place and remvoving unecessary temp files
mv hours_dist.html $1
rm wrap_contents.sh create_hours_dist.txt
