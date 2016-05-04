
filename=$1

LOGGED_IN=$( sed -n '1p' $filename | awk '{ print $4 }' )
LOGGED_OU=$( sed -n '$p' $filename | awk '{ print $4 }' )

StartDate=$(date -u -d "$LOGGED_IN" +"%s")
FinalDate=$(date -u -d "$LOGGED_OU" +"%s")
TotalLoginHours=$( date -u -d "0 $FinalDate sec - $StartDate sec" +"%H:%M:%S" )

Numberoflines=$( cat $filename | wc -l )
TotalActiveHours=0

for l in $( seq 1 $Numberoflines )
do 
 
    #echo $l

    if [ $(($l%2)) -eq 0 ];
    then
       line=$l
       prevLine=$(( $l - 1 ))
       
       secondTime=$( sed -n "${line}p" $filename | awk '{ print $4 }' )
       firstTime=$( sed -n "${prevLine}p"  $filename | awk '{ print $4 }' )
       
       StartDate=$(date -u -d "$firstTime" +"%s")
       FinalDate=$(date -u -d "$secondTime" +"%s")
   
       ActiveHours=$( date -u -d "0 $FinalDate sec - $StartDate sec" +"%H:%M:%S" )

       TotalActiveHours=$(( $(date -u -d "$ActiveHours" +"%s") + $TotalActiveHours ))


    fi
  
done


TotalActiveHours=$( date -u -d "0 $TotalActiveHours sec" +"%H:%M:%S" )

       StartDate=$(date -u -d "$TotalLoginHours" +"%s")
       FinalDate=$(date -u -d "$TotalActiveHours" +"%s")

TotalInactiveHours=$( date -u -d "0 $StartDate sec - $FinalDate sec" +"%H:%M:%S" )

userName=$2
hostName=$3

#echo "Total Login Hours: $TotalLoginHours"
#echo "Total Active Hours: $TotalActiveHours"
#echo "Total Inactive Hours: $TotalInactiveHours"
#echo "User Name: $2"
#echo "Hostname: $3"
echo "$userName,$LOGGED_IN,$LOGGED_OU,$TotalLoginHours,$TotalActiveHours,$TotalInactiveHours" 





