# ops

**1.) mongo**


Use this script to update {'status','login.failed_attempts', and 'last_password_change_timestamp'} against a given emailid:

Example: 
sh mongo_update.sh <email_id_here>

Also, this script require an input text file with mongodb ip and creds. with below sample format: 

127.0.0.1:username:password


**2.) aws-cli**

***Prequesites: 
jq parser must be installed on the linux box from where you're running the script. 
apt-get install jq***


***a.)*** Script ebs_available.sh . 

Example: 

/bin/bash ebs_available.sh

