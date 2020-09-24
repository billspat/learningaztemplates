# Learning Azure Template deployments

The goal of this project is to build VMS in Azure for R/Rstudio using custom script extension

We started with the LAMP-app quick start template, which uses the Azure Linux CustomScript extension to deploy a LAMP application on Ubuntu. It creates an Ubuntu VM, does a silent install of MySQL, Apache and PHP, then creates a simple PHP script.  Go to /phpinfo.php to see the deployed page. 

The following are the original "deploy to azure" buttons for the lamp-app, using the original github links

```
[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Flamp-app%2Fazuredeploy.json)  
```


```
[![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Flamp-app%2Fazuredeploy.json)
```


Other quick-starts worth looking into
---

Linux VM with an Java app installed:

https://github.com/Azure/azure-quickstart-templates/tree/master/101-Linux-Java-ZuluOpenJDK


Linux with whole desktop installed: 

https://github.com/Azure/azure-quickstart-templates/tree/master/101-ubuntu-mate-desktop-vscode

Container instance: 

https://github.com/Azure/azure-quickstart-templates/tree/master/101-aci-linuxcontainer-public-ip

No script added but can pull a docker container, which may be even better than a script for some applications


**network security group:**   create one group that may be shared among other resources

https://github.com/Azure/azure-quickstart-templates/tree/master/101-security-group-create

