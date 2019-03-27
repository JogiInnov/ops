###########################################################
##Use this script to List out the available ebs volume ids#
###########################################################

#!/bin/bash

#echo "`aws ec2 describe-volumes  --filters Name=status,Values=available`" > json.txt
count=`cat json.txt  | jq '.[] | length'`
#echo "count is => $count"
i="0"
while [ $i -lt $count ]
do 
	#echo $i
	#echo `cat json.txt | jq '.[]['$i'].VolumeId'` 
	idsArray+=( "$( echo "`cat json.txt | jq '.[]['$i'].VolumeId'`" )" )
	i=`expr $i + 1`
done

echo "=========printing state=available volume id's as below===="
for i in ${idsArray[@]}
do echo $i
done


