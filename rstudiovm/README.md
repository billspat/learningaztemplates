# Template for an Rstudio Server VM with R packages installs and (hopefully) storage. 

This is an azure VM template that is set to run a shell script on the linux machine to install Rstudio and some other stuff.   It was based on a template that provisions a webserver with a statick web page but most of the original code has been re-written.  If you see reference to a webserver, it's from that old template. 


See azuredeploy.params.json.example for a file to start with to create your own params file.  Please name is *.params.json which would keep it out of this git repository as that pattern is git-ignored and it requires a storage parameter key. 


## Description Parameters and required values : 

  * webUsername: required.  That username to log-into the Rstudio server on the web.   This user does not have 'admin' privs but can install R packages that do not required  
  
  * userPassword : required.  the password you will use to log-in to the Rstudio server.  Do not use your Azure or other important password here.   

  * dnsNameForPublicIP : the web address. This must be unique in your region.  If the name here is "xlab-rstudio" and the resource group is in "centralus" then the web adress of the restudio server will be "xlab-rstudio.centralus.cloudapp.azure.com"

  * cpuSize : optional. the size of the machine, specified by the memory.  Higher memory machines have more cores for parallel work.  One of the following : "CPU-16GB"

  * adminUsername : required.  the ID of the user that can use ssh to connect to the Linux system.  Accessing the system via SSH is not necessary to use the  Rstudio server web application.  This userid has admin or 'root' privs and can install additioal operarting system software. 

  * adminPasswordOrKey : required.  This is an ssh public key used for the admin account to log-in with ssh.   If you have an azure accountm, you can use the azure cloud shell to create or find the ssh key
  
 * storageAccount: required.   Account with container that has data you want to read, or want to write to save your results after you are finished with this machine
 
 * storageContainer: required.  Container that is in the storage account to mount using 'blob fuse'

 * storageKey : key to access the storage account
 
 * _artifactsLocation : optional.  location of the installation script.  Only needed for development to change if you need to update teh script or move to a new location Currently location is this folder in the development repository for this R package. 
 
 * _customScriptFile:  optional. name of the script file.   Again only needed for development to try different script.  Default is installrstudio.sh the script included in this folder.  
  
## using/deploying

See the Azure documentation for how to deploy a template.  Please use your own resource group for experimentation.  


#### Using CLI

1. copy the file `azuredeploy.params.json.example` to a new file `azuredeploy.params.json`   Files *.params.json are in the 
   gitignore, but should never be added or checked into git
2. Edit the new `azuredeploy.params.json` file and replace the values with your own.  For example, replace `GEN-UNIQUE` with a
   unique string.   The server in this template disables password log-ins and requires an SSH key.  You can get one from the 
   Azure portal "cloudshell."  Find the Azure instructions for how to use the Cloud shell, then find out how to use it create an SSSH public /private key pair, and copy the contents of the public key into the `...params.json` file. 
   Note once in cloudshell, the public key contents are usually show with `cat ~/.ssh/id_rsa.pub`
3. The "artifacts location" should be a public-readable URL on the web.  Github is a great place for that, so the value for this parameter is simply the URL for raw.github... of this repository and folder.  If you copy that to a new repo or folder please update the params.  You can find the url on github for any file by clicking the file then looking for the 'raw' button.    The _artifact lcoation  param was set to a default value in the template itself (to this repo now).   This is just the base URL.  The template as written expects installer scripts to be in the 'scripts' folder.   The name of the script inside this folder is another parameter.   To try a new script, you can create a script with a new name (myscript.sh) and change the parameter without changing the template at all.   

You can use the Azure command line (lookup how to install the az  cli , on MacOS I use `brew install azure` )
```bash
RG=< your resource group name>
TFILE=azuredeploy.params.json
DEPLOYGROUP=TestUbuntuDeployment
az deployment group create \
  --name ${DEPLOYGROUP} \
  --resource-group ${RG} \
  --template-file azure_deploy.json \
  --parameters @${TFILE}

```

## After Deployment

Once your test Rstudio server is created use domain name from your template file (or entered via UI. 

Full URL to the test page will be: http://\<DNS name entered\>.\<resource group location\>.cloudapp.azure.com/\<page name or none for index page\>
(example: http://ads-rstudio-test.centralus.cloudapp.azure.com)

You log-in to the RStudio server using the rstudio user id and password you provided. 

You can also ssh into the server from your computer or the Auzre portal cloudshell.   The admin user id is different from the Rstudio user id.     If the amin  username you set in the params file is the same
as your Azure account, and the key the same as your Azure public key, in the cloud shell you could 

```bash
ssh $USER@ttp://<dnsNameForPublicIP>.<location>.cloudapp.azure.com
```
