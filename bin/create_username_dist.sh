#!/bin/bash
#Keeps track of home directory
home=$(pwd)
cd $1
#Grabs the 4th column from all instances of failed_login_data.txt in a ll lower directories searched recursivly with grep
grep -rh --include="failed_login_data.txt" .| awk '{print $4}' | cat > usernames.txt
#Sorts the 4th column (usernames) grabbed from the above line and passes them to uniq giving counts and passing the output to a file
sort usernames.txt | uniq -c | cat > counts.txt
#Takes all the counts from the above line and adds them to javascript data.addRow comands in the proper way to create the html files later
awk '{print "data.addRow([\x27"$2"\x27, "$1"]);"}' counts.txt | cat > create_username_dist.txt
#Moves create_username_dist.txt into html_componenets so that it can be ran with wrap_contents.sh
mv create_username_dist.txt $home/html_components
cd $home
#Copies wrap_contents into html_components so it can be ran there where the files are located
cp bin/wrap_contents.sh $home/html_components
cd html_components
#Runs wrap_contents.sh creating the desird html output
./wrap_contents.sh create_username_dist.txt username_dist username_dist.html
#Moves username_dist out of html_components and into the desired directory
mv username_dist.html $1
#Removes the temp files
rm wrap_contents.sh
rm create_username_dist.txt
