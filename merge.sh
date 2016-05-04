#!/bin/bash
#Author : MP Nadar
#Date: 07th April 2016
#Purpose : Merging user files and creating csv


mkdir -p /tmp/merge
cd /tmp/$(date +%F)

echo "User,Hostname,Date & Time,Action" >  /tmp/merge/$(date +%F)_merge.csv
echo "Name,Logged-in Time,Logged-out Time,Total Hours,Total Activity,Total Inactivity" > /tmp/merge/$(date +%F)_sum.csv

for i in $(ls * )

do
   

    userName=$( echo $i | cut -d _ -f 1 )
    hostName=$( echo $i | cut -d _ -f 2 )
    todayDate=$( echo $i | cut -d _ -f 3 )

    while read line
    do 
 
      day=$(echo $line | cut -d" " -f1)
      mon=$(echo $line | cut -d" " -f2)
      dat=$(echo $line | cut -d" " -f3) 
      tim=$(echo $line | cut -d" " -f4)
      yr=$(echo  $line | cut -d" " -f6)
      action=$(echo $line | cut -d" " -f7)
      
      echo $userName,$hostName,${day}_${mon}_${dat}_${tim}_${yr},$action  >> /tmp/merge/$(date +%F)_merge.csv

    done < $i


    /bin/bash /home/administrator/loginHours.sh $i $userName $hostName >> /tmp/merge/$(date +%F)_sum.csv
    echo ",,," >> /tmp/merge/$(date +%F)_merge.csv
 
done
