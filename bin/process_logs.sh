#!/bin/bash
mkdir temp_dir
home=$(pwd)
counter=1
for var in "$@"
do
	mkdir temp_dir/$counter
	tar -xf $var -C temp_dir/$counter
	counter=$((counter + 1))	
done

./bin/process_client_logs.sh temp_dir
mv temp_dir/failed_login_data.txt $home
