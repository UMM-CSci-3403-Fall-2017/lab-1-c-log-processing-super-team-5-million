#!/bin/bash
mkdir temp_dir
home=$(pwd)
counter=1
#loops through all of the tar files given and creates a seperate folder for
#the extracted contents of each and runs process_client_logs.sh on each of them
for var in "$@"
do
	mkdir temp_dir/$counter
	tar -xf $var -C temp_dir/$counter
        ./bin/process_client_logs.sh temp_dir/$counter
	counter=$((counter + 1))	
done
#Runs all of the required scripts to stitch together the final report
./bin/create_username_dist.sh $home/temp_dir
./bin/create_hours_dist.sh $home/temp_dir
./bin/create_country_dist.sh $home/temp_dir
./bin/assemble_report.sh $home/temp_dir
mv temp_dir/failed_login_summary.html $home
rm -r temp_dir
