#!/bin/bash
home=$(pwd)
cd $1
cat  country_dist.html hours_dist.html username_dist.html  >> report_temp.txt
mv report_temp.txt $home/html_components
cd $home
cp bin/wrap_contents.sh $home/html_components
cd $home/html_components
./wrap_contents.sh report_temp.txt summary_plots failed_login_summary.html
rm report_temp.txt
rm wrap_contents.sh
mv failed_login_summary.html $1

