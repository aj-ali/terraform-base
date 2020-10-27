#!/bin/bash

if [ "$1" = "" -o "$2" = "" ]; then echo "Not enough Variables, give action and environment"; exit 1; fi
JQ=`which jq`
if [ "$JQ" = "" ]; then echo "JQ Not Installed"; exit 1; fi
AWS=`which aws`
if [ "$AWS" = "" ]; then echo "AWS CLI not installed"; exit 1; fi

#Define Environment
deploy=$3

#GEt secrets for Database
#aws secretsmanager get-secret-value --secret-id ${deploy}/repairsense/mysql --query SecretString --output text | jq -r 'to_entries|map("\(.key)=\(.value|tostring)")|.[]' > /tmp/secrets.env
#eval $(cat /tmp/secrets.env | sed 's/^/export TF_VAR_/')
#rm /tmp/secrets.env

if [ "$3" = "" ]
 then
  #Get AWS Credentials
  aws secretsmanager get-secret-value --secret-id ${deploy}/environment/secrets --query SecretString --output text | jq -r 'to_entries|map("\(.key)=\(.value|tostring)")|.[]' > /tmp/secrets.env
  eval $(cat /tmp/secrets.env | sed 's/^/export /')
  rm /tmp/secrets.env
fi

#Run Terraform
terraform $1 -var-file="terraform.tfvars"
