#!/usr/bin/env bash

# az cli commands to deploy the template.  Saving as a script to be able to recall the command

# usage 
# 1. enable python env with azure cli 
#    for example `conda activate azure`
# 2. get the resource group name you want use
#    you can search using az group list | grep <something>
# 3. run with bash
#    bash azdeploy.sh <resource_group_name>

usage="azdeploy <rgname> <paramfile>"
if [ -z "$1" ]
  then
    echo $usage
else
  RG=$1
fi

if [ -z "$2" ]
  then
    echo $usage
else
  TFILE=$2
fi

az deployment group create \
  --name TestUbuntuDeployment \
  --resource-group ${RG} \
  --template-file azuredeploy.json \
  --parameters @${TFILE}
