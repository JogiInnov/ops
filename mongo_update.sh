#!/bin/bash

emailid="$1"

update()
{
ip="$1"
user="$2"
ps="$3"

conn='mongo '$ip'/core -u '$user' -p '$ps' --authenticationDatabase admin'
cnt=`echo "db.User.find({'email':'$emailid'})" | $conn | grep _id  | wc -l`
echo $cnt
if [ $cnt -eq 1 ]
	then 
		echo "id found ===>> $emailid , executing update.."
		echo "db.User.update({'email':'$emailid'}, {'\$set': {'status': 'Active', 'login.failed_attempts': 0, 'last_password_change_timestamp': new Date().getTime().toString()}})" | $conn
	else
		echo "id == $emailid is NOT present, skipping..!!"
fi

}

if [ $# -ne '1' ]
then
echo "missing emailid as argument...!!"
else
for i in `cat .data_mg`
do
ip=`echo $i | grep -v ^# |  awk -F ":" '{print $1}'`
user=`echo $i | grep -v ^# |  awk -F ":" '{print $2}'`
ps=`echo $i | grep -v ^# |  awk -F ":" '{print $3}'`
	update $ip $user $ps
done
fi
