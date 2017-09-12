#!/bin/bash
home=$(pwd)
cd $1
#looks through all directories and populates hours.txt with only the hours
grep -rh --include="failed_login_data.txt" .| awk '{print $5}' | cat > ip_address.txt
sort ip_address.txt | cat > sorted_ip_address.txt
join sorted_ip_address.txt $home/etc/country_IP_map.txt | awk '{print $2}' | cat > temp_country_dist.txt
cp temp_country_dist.txt ~
sort temp_country_dist.txt |uniq -c| awk '{print "data.addRow([\x27"$2"\x27,"$1"]);"}'| cat > country_dist.txt
cp country_dist.txt ~
$home/bin/wrap_contents.sh country_dist.txt $home/html_components/country_dist country_dist.html
cp country_dist.html $home/html_components
