library(AzureRMR)

#az<-create_azure_login()
az<-get_azure_login()

sub<-az$get_subscription("aa32e19c-49b5-478c-af56-fc710b1a8a1c")

rg <- sub$get_resource_group("scriptvmcreation")

#deploy <- rg$deploy_template("will3298testvm", template="azuredeploy.json", parameters="azuredeploy.params.json")

# Make sure to set working directory to where the template is stored
# Comments are not allowed to be in the template JSONs
deploy <- rg$deploy_template('will3298testvm', template='azuredeploy.json', parameters=list('adminUsername'="will3298", 'webUsername'="will3298", 'dnsNameForPublicIP'="ads-rstudio-test-will3298", 'ubuntuOSVersion'="20_04-lts", 'adminPasswordOrKey'="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC76QPtwDggS/MH1g5v15Y6ErlUM6dzy4j4rYI/27TqqM3PCZIWDTuZW6mCMzjHhWelOWaC8zMxv9+9Y9TnJTJngcpcT9o+7AA023l+vTmX7TpCEXzja9wo7os2SK8JvZN2/pJmig3q2QztO1FbURf9xVRCUu1haA2h3UaX6olyGUSaT2JLHl8+AM5sH8HnzWpB/cuAor5xiwfXixkuFNyrmbkvVwFXYIsCQZKy+APwqv93eIG+L/YAHIHkbiv5PnYBRTHLMpE79VXDm33+Pa/kWW8xhAsqn0sZFNP+6IbIzHB8fyLso/29dVRESK7NJQ9k+g1rt9uLD6QN3yf/4luX96+sxJ4UpUC/WfuaQayntk9MdWHyw0k6stqXipREWrLxeNBbxaooQcBe1F/cCY+zww564RmG20RlpiwAQAmLQ54mdY+c6g40K+KJjgCQWqDkTjINWuXq8bMzPHJa+0PY7LdNnQ4Z76YZKkWzjM67quUg1QpMFMKO5hWGswd26lU= cjwil@DESKTOP-SGM8N65", '_artifactsLocation'="https://raw.githubusercontent.com/billspat/learningaztemplates/master/rstudiovm/", '_customScriptFile'="installrstudio_ubuntu20.sh", 'userPassword'="rstudio1", 'storageAccount'="scriptvmstorage", 'storageContainer'="scripts", 'storageKey'="viuXxtQLJnLz91IaCh/1G/xZKGSZEuEEsNK6OKbMx8/Su+A6boGE+a2dEk/H1jOuBpVm1F73uatHsRaIDj5DkQ==", 'namePrefix'="will3298test", 'cpuSize'="CPU-16GB"))
# Breaks if ubuntu version 20, that is a a script issue not an r issue
# got this to work 100% with onedrive script and 18.04-LTS ubuntu version
