#!/bin/bash
mkdir temp_dir
home=$(pwd)
counter=1
for var in "$@"
do
	mkdir temp_dir/$counter
	tar -xf $var -C temp_dir/$counter
        ./bin/process_client_logs.sh temp_dir/$counter
	counter=$((counter + 1))	
done

./bin/create_username_dist.sh $home/temp_dir
./bin/create_hours_dist.sh $home/temp_dir
./bin/create_country_dist.sh $home/temp_dir
./bin/assemble_report.sh $home/temp_dir
mv temp_dir/failed_login_summary.html $home
rm -r temp_dir
