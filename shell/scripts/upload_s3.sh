#!/bin/bash 
#Date: 21/7/2017
#Author: Mohan
#Purpose: To upload files to AWS S3 via Curl
#Uploads file at the top level folder by default

# set -x
# https://tldp.org/LDP/abs/html/options.html
# https://gist.github.com/tuxfight3r/7ccbd5abc4ded37ecdbc8fa46966b7e8
# https://gist.github.com/chrismdp/6c6b6c825b07f680e710

#S3 parameters
# S3KEY="XXXXXXXXXXX"
# S3SECRET="XXXXXXXXXXXXXXXX"
# S3BUCKET="storage-backup"
# S3STORAGETYPE="STANDARD" #REDUCED_REDUNDANCY or STANDARD etc.
# AWSREGION="s3-eu-west-1"

. $HOME/.aws/s3.ini

function putS3
{

  file_path=$1
  aws_path=$2
  bucket="${S3BUCKET}"
  date=$(date -R)
  acl="x-amz-acl:private"
  content_type="application/x-compressed-tar"
  storage_type="x-amz-storage-class:${S3STORAGETYPE}"
  string="PUT\n\n$content_type\n$date\n$acl\n$storage_type\n/$bucket$aws_path${file_path##/*/}"
  signature=$(echo -en "${string}" | openssl sha1 -hmac "${S3SECRET}" -binary | base64)
  # host="${bucket}.s3.amazonaws.com"
  host="$bucket.${AWSREGION}.amazonaws.com"
  curl -v -s --retry 3 --retry-delay 10 -X PUT -T "$file_path" \
       -H "Host: ${host}" \
       -H "Date: $date" \
       -H "Content-Type: $content_type" \
       -H "$storage_type" \
       -H "$acl" \
       -H "Authorization: AWS ${S3KEY}:$signature" \
       "https://${host}$aws_path${file_path##/*/}"
      #  -H "Host: $bucket.${AWSREGION}.amazonaws.com" \
      #  https://${bucket}.s3.amazonaws.com/
      #  "$aws_path${file_path##/*/}"
}

function usage
{
  echo "Usage: $0 <absolutepath_to_file> <s3_folder_path>"
  echo "$0 '/tmp/storage_backup/storage-backup_07192017_112945.tar.gz' '/'"
}

#validate positional parameters are present
if [ $# -ne 2 ]; then
  usage
  echo "Exiting .."
  exit 2
fi

putS3 $1 $2
