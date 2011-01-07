#! /bin/bash

####
## backup.sh
## run this to iterate over scripts in the policies directory
## each policy file echos back the files that it created whne it's done
## files are then fed to the upload.rb script which puts them in the right place(s) on S3
####

## User configuration:
STORAGE_CONNECTOR_NAME="aws_s3.rb"


#######################################################################################################

SCRIPT=$(readlink -f $0)
echo $SCRIPT
SCRIPTPATH=`dirname "$SCRIPT"`

STORAGE_CONNECTOR="${SCRIPTPATH}/connectors/${STORAGE_CONNECTOR_NAME}"
DATESTAMP=`date +%Y_%m%d`

# processes lines of input on STDIN and sends it to the upload script
function store_files () {
	while [[ $? -eq 0 ]]
	do
		read FILE
	
		# if the read returned non-zero and it also read no data, then break out of while loop. we're done.
		if [[ $? -ne 0 && -z $FILE ]]; then
			break
		fi
	
		# StorageConnectors must adhere to the following commandline usage:
		# ./connector.py <datestamp> <policy_name> <file_path>
		#
		# The connector will then store that file and return 0 (success)
		# a non-zero return value signals and error.
		# TODO: catch errors from the StorageConnector
		
		echo "$STORAGE_CONNECTOR" $DATESTAMP $POLICY_NAME $FILE
	done
}

# AWS Shit:
#export S3_BUCKET_NAME="<<<bucketname>>>"
#export AMAZON_ACCESS_KEY_ID="<<<accesskeyid>>>"
#export AMAZON_SECRET_ACCESS_KEY="<<<secretaccesskey>>>"

POLICIES=`ls "$SCRIPTPATH/policies"`

# check to make sure there is at least one policy loaded
if [[ -z $POLICIES ]]; then
	echo "No policies were found. Cannot continue the backup."
	echo "Sample policies are located in the policies-available directory"
	echo "Symlink polices from policies-available to policies to enable them."
	echo ""
	exit 1
fi

for policy in $POLICIES
do
	# parse out the policy name from the filename ( ie: "mysql.sh" => "mysql" )
	POLICY_NAME=`echo $policy | cut -d'.' -f1`
	
	# execute the policy and receive list of files ready for backup.
	${SCRIPTPATH}/policies/${policy} | store_files
done
