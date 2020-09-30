# Learning Azure Template deployments

The objective of this project is to learn and demonstration how to provision  VMS in Azure  for various Research platforms (e.g. R/Rstudio ) using templates and the custom script extension to install features on the VM.  the main goal is to make working with Azure reproducible by provisioning with code ("infrastructure as code") and not with the GUI.    

There are a few folders with various attempts at this. 

  * /colin : not working
    Colin Williams work for a lab, copied over from a different project and sanitized. These worked in the other project but need some fix up here. 

  * /lampvm : not working
    We started with the LAMP-app quick start template, which uses the Azure Linux CustomScript extension to deploy a LAMP application on Ubuntu.  See the `/lampvm` folder It creates an Ubuntu VM, does a silent install of MySQL, Apache and PHP, then creates a simple PHP script.  Go to /phpinfo.php to see the deployed page. 

  * /rstudiovm : working but needs work
    this template and script currently creates a working vm with Rstudio and a special rstudio user.  See the readme in that folder.  this is based on the really close MS Quickstart template for Ubuntu VM running Apache2.   


Learning
---
To get started with Templates, I recommend 
https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-create-first-template

We use the "CLI" over powershell as many researchers on on Mac or Linux and bash is available in the [Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/about)

Before this though you'll have to [install the Azure CLI tool](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) and Python.   


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

