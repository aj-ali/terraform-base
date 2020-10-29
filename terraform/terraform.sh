#!/bin/bash

if [ "$1" = "" -o "$2" = "" -o "$3" = "" -o "$4" = "" ]; then echo "Not enough Variables, give action and environment, local/remote and path"; exit 1; fi
JQ=`which jq`
if [ "$JQ" = "" ]; then echo "JQ Not Installed"; exit 1; fi
AWS=`which aws`
if [ "$AWS" = "" ]; then echo "AWS CLI not installed"; exit 1; fi

#Define Environment
deploy=$2

#GEt secrets for Database
aws secretsmanager get-secret-value --secret-id ${deploy}/repairsense/mysql --query SecretString --output text | jq -r 'to_entries|map("\(.key)=\(.value|tostring)")|.[]' > /tmp/secrets.env
eval $(cat /tmp/secrets.env | sed 's/^/export TF_VAR_/')
rm /tmp/secrets.env



if [ "$3" = "remote" ]
 then
  #Get AWS Credentials
  aws secretsmanager get-secret-value --secret-id ${deploy}/environment/secrets --query SecretString --output text | jq -r 'to_entries|map("\(.key)=\(.value|tostring)")|.[]' > /tmp/secrets.env
  eval $(cat /tmp/secrets.env | sed 's/^/export /')
  rm /tmp/secrets.env

  AUTO="-auto-approve"
fi

#Run Terraform
if [ "$3" = "local" ]
then
  AUTO=
fi

cd $2/$4

if [ "$1" = "plan" ]
then
  terraform --version
  terraform init -input=false
  terraform validate
  terraform plan -lock=false -input=false -var-file="terraform.tfvars"
else
  terraform --version
  terraform init -input=false
  terraform $1 $AUTO -input=false -var-file="terraform.tfvars"
fi
cd ../..
