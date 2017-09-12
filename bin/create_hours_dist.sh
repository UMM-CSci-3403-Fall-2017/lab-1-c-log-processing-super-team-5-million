#!/bin/bash
home=$(pwd)
cd $1
grep -rh --include="failed_login_data.txt" .| awk '{print $3}' | cat > hours.txt
sort hours.txt | uniq -c | cat > count_hours.txt
awk '{print "data.addRow([\x27"$2"\x27,"$1"]);"}' count_hours.txt | cat > create_hours_dist.txt
mv create_hours_dist.txt $home/html_components
rm count_hours.txt hours.txt
cd $home
cp bin/wrap_contents.sh $home/html_components
cd html_components
./wrap_contents.sh create_hours_dist.txt hours_dist hours_dist.html
mv hours_dist.html $1
rm wrap_contents.sh create_hours_dist.txt
