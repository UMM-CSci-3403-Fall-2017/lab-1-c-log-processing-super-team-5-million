#!/bin/bash
mktemp temp_log_files
home=$(pwd)
for var in "$@"
do
	tar -xf $var -C /$home/temp_log_files
done
