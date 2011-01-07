#! /bin/bash

####
## backup.sh
## run this to iterate over scripts in the policies directory
## each policy file echos back the files that it created whne it's done
## files are then fed to the upload.rb script which puts them in the right place(s) on S3
####

SCRIPT=$(readlink -f $0)
echo $SCRIPT
SCRIPTPATH=`dirname "$SCRIPT"`

UPLOAD_SCRIPT="$SCRIPTPATH/upload.rb"

DATESTAMP=`date +%Y_%m%d`

# AWS Shit:
#export S3_BUCKET_NAME="<<<bucketname>>>"
#export AMAZON_ACCESS_KEY_ID="<<<accesskeyid>>>"
#export AMAZON_SECRET_ACCESS_KEY="<<<secretaccesskey>>>"

for policy in `ls "$SCRIPTPATH/policies"`
do
	# run policy as:
	# $policy DATESTAMP BUCKET_NAME ACCESS_KEY_ID SECRET_ACCESS_KEY
	
	# parse out the policy name from the filename ( ie: "mysql.sh" => "mysql" )
	POLICY_NAME=`echo $policy | cut -d'.' -f1`
	
	# execute the policy and receive list of files ready for backup.
	FILES=`"$SCRIPTPATH/policies/$policy"`
	
	# iterate over the files and upload each to S3
	for file in $FILES
	do
		# call the upload script like:
		# upload.rb DATESTAMP POLICY FILE
		"$UPLOAD_SCRIPT" $DATESTAMP $POLICY_NAME $file
		if [[ -e $file ]]; then
		  rm $file
		fi
	done
done
