###########################################################
##Use this script to List out the available ebs volume ids#
###########################################################

#!/bin/bash


export TERM=xterm
source ~/.profile
UseR=`id -nu`
#-- Log Path
Log_PATH=Logrotate.log

Logger()
{
        Colorscheme=$2
        if [ ! $Colorscheme ]
        then
                Colorscheme=9
        fi
        tput setf $Colorscheme
        Logdate=`date +%Y%m%d:%H:%M:%S`
                echo $Logdate :: $1 | tee -a $Log_PATH
        tput sgr0
}


##################
##Initialization##
##################

count=`aws ec2 describe-volumes --filters "Name=status, Values=available"  --query 'Volumes[].VolumeId' --output text | wc -l`


echo "========= printing available volume id's as below ===="

for i in `aws ec2 describe-volumes --filters "Name=status, Values=available"  --query 'Volumes[].VolumeId' --output text`
	do 
		echo $i
        	Logger "[ Info ] :: Volume id found ==> $i ..!!" 4
		echo "************ Creating snapshot for volume $i below: ****************"
		outputvar=$(echo `aws ec2 create-snapshot --volume-id $i --description 'ebs snapshot form aws-cli' --tag-specifications 'ResourceType=snapshot,Tags=[{Key=purpose,Value=prod},{Key=costcenter,Value=123}]' 2>&1`)
		if [ $? -eq "0" ]
			then
				sleep 1 
				Logger "[ Info ] :: Snapshot created ..!! with below details: ${outputvar}" 3
				echo "------------------------------------------"
				Logger "[ Info ] :: Deleting Volume with id == $i ..!!" 6
				outputvar=$(echo `aws ec2 delete-volume --volume-id $i 2>&1`)
                                sleep 1
				Logger "[ Alert ] :: Volume deleted ..!!  ${outputvar}" 6
				
			else
				sleep 1
				Logger "[ Info ] :: Error creating snapshot ..!! ${outputvar}" 3
		fi
				echo " ------------------------------" >> $Log_PATH

	done



