#!/usr/bin/env bash

# this is a temporary, test script and will probably not make it in the package,. 
# these are azure cli commands to deploy the template, wrapped up in a script becuase  I'm lazy

# usage 
# 1. enable python env with azure cli 
#    for example `conda activate azure`
# 2. get the resource group name you want use
#    you can search using az group list | grep <something>
# 2.5  login if you need to : az login
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
  --name TestColinDeployment \
  --resource-group ${RG} \
  --template-file linuxvm_deploy2.json \
  --parameters @${TFILE}
