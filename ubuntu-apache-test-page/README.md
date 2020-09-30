# Ubuntu Apache2 Web server with your test page



This template was stolen from the MS Quickstart templates - creates an Ubuntu VM running Apache2 with the test page content you define as a parameter. This can be useful for quick validation/demo/prototyping.

## Deploying using the Portal

These are the original instructions from MS.  See below for modified instructions using CLI etc. 

#### To deploy a static test page:

1. Push Deploy to Azure button.
2. Choose admin credentials for the new Web server.
3. Choose DNS name for the new Web server.
4. Enter page name, title and static HTML body markup.
5. Enter resource group name and location for it.
6. Start template deployment.


#### To deploy a PHP test page:

1. Push Deploy to Azure button.
2. Choose admin credentials for the new Web server.
3. Choose DNS name for the new Web server.
4. Enter page name, title and PHP body markup.
5. Set INSTALLPHP to "true".
6. Enter resource group name and location for it.
7. Start template deployment.


#### Static page, using CLI

1. copy the file `azuredeploy.params.json.example` to a new file `azuredeploy.params.json`   Files *.params.json are in the 
   gitignore, but should never be added or checked into git
2. Edit the new `azuredeploy.params.json` file and replace the values with your own.  For example, replace `GEN-UNIQUE` with a
   unique string.   The server in this template disables password log-ins and requires an SSH key.  You can get one from the 
   Azure portal "cloudshell."  Find the Azure instructions for how to use the Cloud shell, then find out how to use it create an SSSH public /private key pair, and copy the contents of the public key into the `...params.json` file. 
3. The "artifacts location" is simply the URL for raw.github... of this repository and folder.  If you copy that to a new repo or folder please update the params.  The _artifact lcoation  param was set to a default value in the template itself (to this repo now)
4. use the CLI command to deploy: 

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

Once your test Web server is created use domain name and page name you entered to access the Web page with your markup. 
Full URL to the test page will be: http://\<DNS name entered\>.\<resource group location\>.cloudapp.azure.com/\<page name or none for index page\>
(example: http://mytestserver.westeurope.cloudapp.azure.com)





