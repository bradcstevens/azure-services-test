# Azure-Services 

## Prerequisites 

The following are prerequisites for putting code into the repository:
* No Credentials should be stored in any ARM temaplate or Script
+ No specific information related to the deployment should be hard-coded.  For example:
  * Subscription ID 
  * Tenant ID
  * The Resource Group name
  * Virtual machine names 
  * Subnets 
  * Region 

It is ok to store default parameters as part of the provisioning, as long as that is considered the CDW recommended standard.

It is recommended that you store the information separately and pass it as parameters to either the ARM Template or script

The README file needs to document all the parameters that need passing. It should be at the beginning of the Readme file for easy access.

## Overview

This repo contains all currently available Azure Services templates contributed by the engineering community. These notes are taken from the Microsoft Samples repo, so the examples stipulated here are recommendations for now.

The following information is relevant to get started with contributing to this repository (Still in development).

+ [**Contribution guide**](/1-CONTRIBUTION-GUIDE/README.md#contribution-guide). Describes the minimal guidelines for contributing.
+ [**Best practices**](/1-CONTRIBUTION-GUIDE/best-practices.md#best-practices). Best practices for improving the quality of your template design.
+ [**Git tutorial**](/1-CONTRIBUTION-GUIDE/git-tutorial.md#git-tutorial). Step by step to get you started with Git.
+ [**Useful Tools**](/1-CONTRIBUTION-GUIDE/useful-tools.md#useful-tools). Useful resources and tools for Azure development.

## Deploying Services

Services should be deployed in a folder for each service, with the folder name being the name of the service you are working on.  Within that folder, should be subdirectories for Provisioning, Deprovisioning and update/configure if necessary.

You can deploy these services directly through the Azure Portal or by using the scripts supplied in the root of the repo.

To deploy a sample using the Azure Portal, click the **Deploy to Azure** button found in the README.md of each sample. **[Note:  Under Development]**


To deploy the sample via the command line using [Azure PowerShell](https://docs.microsoft.com/en-us/powershell/azure/overview), use the following steps:

### PowerShell Deployment

### Installation Requirements

PowerShell deployment requires the Az.Resources module version 1.7.1 or greater. This module is available from the [PowerShell Gallery](https://www.powershellgallery.com/packages/Az.Resources/1.7.1) and can also be installed directly from the Windows PowerShell:

```
    Install-Module -Name Az.Resources -RequiredVersion 1.7.1
```

### Connect to Azure

From PowerShell run the following command:
```
    Connect-AzAccount
```

### Set your default subscription (if applicable):

1. Get the list of current subscriptions:

```
    Get-AzSubscription
```
2. Locate the applicable subscription from the table generated in step 1.  Using the Name column as the <subscription-name> parameter, set the default subscription:

```
Set-AzContext <subscription-name>
```

### Create resource from a template

From a PowerShell window, execute the deploy.ps1 script with the following parameters:

+ ServiceName    -  The name of the Azure service being deployed
+ ResourceGroup  -  The name of the resource group for deployment

```
.\deploy.ps1  <ServiceName> <ResourceGroup>
```


_Example:_

  .\deploy.ps1 msp-sample-vnet msp-sample

  Will deploy the template located at .\msp-sample-vnet\azuredeploy.json into the *msp-sample* resource group.

## Contribution Guide

To make sure your template is added to Azure Service Repo index, please follow these guidelines. Any templates that are out of compliance will be rejected and not added to the repo.

## Files, folders and naming conventions


1. Every deployment template and its associated files must be contained in its own **folder**. Name this folder something that describes what your template does. Usually this naming pattern looks like **appName-osName** or **level-platformCapability** (e.g. vm-user-image).  It is recommended that you call the folder the same as the service you are responsible for.

+ **Required** - You should have a create, update, configure and delete script.  Each should be in subfolders. Folders should be named as follows:

       /PROVISION
       /DEPROVISION
       /CONFIGURE
       /CHANGE


+ **Protip** - Try to keep the name of your template folder short so that it fits inside the Github folder name column width.

2. Github uses ASCII for ordering files and folder. For consistent ordering **create all files and folders in lowercase**. The only **exception** to this guideline is the **README.md**, that should be in the format **UPPERCASE.lowercase**.

3. Include a **README.md** file that explains how the template works.

+ Guidelines on the README.md file below.

4. The deployment template file must be named **azuredeploy.json**.
5. There should be a parameters file named **azuredeploy.parameters.json**.

+ Use defaultValues in the azuredeploy.json template whenever there is a value that will work for all users.  The parameters file, should contain only [GEN*](#parameters-file-placeholders) values for generating values for a test deployment.  Do NOT use values that require changes by the user for a successful deployment (e.g. changeme).

1. The template folder must contain a **metadata.json** file to allow the template to be indexed (still investigating this capabability)

+ Guidelines on the metadata.json file below.

1. The custom scripts that are needed for successful template execution must be placed in a folder called **scripts**.
2. Linked templates must be placed in a folder called **nested**.
3. Images used in the README.md must be placed in a folder called **images**.
4. Any resources that need to be setup outside the template should be named prefixed with existing (e.g. existingVNET, existingDiagnosticsStorageAccount and provision using a [prereqs](#template-pre-requisites) template.

![alt text](/1-CONTRIBUTION-GUIDE/images/namingConvention.png "Files, folders and naming conventions")

## README.md

The README.md describes your deployment. A good description helps other community members to understand your deployment. The README.md uses [Github Flavored Markdown](https://guides.github.com/features/mastering-markdown/) for formatting text. If you want to add images to your README.md file, store the images in the **images** folder. Reference the images in the README.md with a relative path (e.g. `![alt text](images/namingConvention.png "Files, folders and naming conventions")`). This ensures the link will reference the target repository if the source repository is forked. A good README.md contains the following sections

+ Deploy to Azure button
+ Visualize button
+ Description of what the template will deploy
+ Tags, that can be used for search. Specify the tags comma separated and enclosed between two back-ticks (e.g Tags: `cluster, ha, sql`)
+ *Optional: Prerequisites
+ *Optional: Description on how to use the application
+ *Optional: Notes

Do **not include** the **parameters or the variables** of the deployment script. We render this on Azure.com from the template. Specifying these in the README.md will result in **duplicate entries** on Azure.com.

You can download a [**sample README.md**](/1-CONTRIBUTION-GUIDE/sample-README.md) for use in your deployment scenario. The **sample README.md** also contains the code for the **Deploy to Azure** and **Visualize** buttons, that you can use as a reference.

## metadata.json

A valid metadata.json must adhere to the following structure

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/...",
  "itemDisplayName": "60 char limit",
  "description": "1000 char limit",
  "summary": "200 char limit",
  "githubUsername": "<e.g. bmoore-msft>",
  "dateUpdated": "<e.g. 2015-12-20>",
  "type": "QuickStart"
}
```

### schema

+ Proper metadata schema

### itemDisplayName

+ Title of the sample

### description

+ Cannot contain HTML This is used for the template description on the Azure.com index template details page

### summary

+ This is shown for template description on the main Azure.com template index page

### githubUsername

+ This is the username of the original template author. Do not change this
+ This is used to display template author and Github profile pic in the Azure.com index

### dateUpdated

+ Must be in yyyy-mm-dd format.
+ The date must not be in the future to the date of the pull request

### type

+ Type of template; in this case, QuickStart

## Azure DevOps CI

We have automated template validation through Azure DevOps CI. These builds can be accessed by clicking the 'Details' link at the bottom of the pull-request dialog. This process will ensure that your template conforms to all the rules mentioned above and will also deploy your template to our test subscription.

### Parameters File Placeholders

To ensure your template passes, special placeholder values are required when deploying a template, depending on how the parameter is used.  For static values you can see the actual value used in the [.config.json](../test/ci-gen-setup/.config.json) file in this repo.

+ **GEN-UNIQUE[-N]** - use this for a new globally unique resource name. The value will always be alpha numeric value with a length of `[N]`, where `[N]` can be any number from 3 to 32 inclusive.  The default length when N is not specified is 18.
+ **GEN-SSH-PUB-KEY** - use this if you need an SSH public key
+ **GEN-PASSWORD** - use this  if you need an azure-compatible password for a VM
+ **GEN-GUID** - use this to generate a GUID

Quickstart CI engine provides few pre-created azure components which can be used by templates for automated validation. This includes a key vault with sample SSL certificate stored, specialized and generalized Windows Server VHD's, a custom domain and SSL cert data for Azure App Service templates and more.

**Virtual Network Related placeholders:**

+ **GEN-VNET-NAME** - the name of the virtual network
+ **GEN-VNET-RESOURCEGROUP-NAME** - the name of the resource group for the virtual network
+ **GEN-VNET-SUBNET1-NAME** - the name of subnet-1

**Key Vault Related placeholders:**

+ **GEN-KEYVAULT-NAME** - the name of the keyvault
+ **GEN-KEYVAULT-RESOURCEGROUP-NAME** - the name of the resource group for the keyvault
+ **GEN-KEYVAULT-FQDN-URI** - the FQDN URI of the keyvault
+ **GEN-KEYVAULT-RESOURCE-ID** - the resource ID of the keyvault
+ **GEN-KEYVAULT-PASSWORD-REFERENCE** - the reference parameter used to retrieve a KeyVault Secret (use "reference" for the property name, not "value")
+ **GEN-KEYVAULT-SSL-SECRET-NAME** - the name of the secret where the sample SSL cert is stored in the keyvault
+ **GEN-KEYVAULT-SSL-SECRET-URI** - the URI of the sample SSL cert stored in the test keyvault
+ **GEN-KEYVAULT-ENCRYPTION-KEY** - the name of the sample encryption key stored in keyvault, used for disk encryption
+ **GEN-KEYVAULT-ENCRYPTION-KEY-URI** - the URI of the sample encryption key
+ **GEN-KEYVAULT-ENCRYPTION-KEY-VERSION** - the secret version of the sample encryption key
+ **GEN-SF-CERT-URL** - the URL of the sample service fabric certificate stored in keyvault
+ **GEN-SF-CERT-THUMBPRINT** - the thumbprint of the sample service fabric certificate stored in keyvault

**Existing VHD related placeholders:**

+ **GEN-SPECIALIZED-WINVHD-URI** - URI of a specialized Windows VHD stored in an existing storage account
+ **GEN-GENERALIZED-WINVHD-URI** - URI of a generalized Windows VHD stored in an existing storage account
+ **GEN-GENERALIZED-WINVHD-FILENAME** - the filename of the existing VHD
+ **GEN-DATAVHD-URI** - URI of a sample data disk VHD stored in an existing storage account
+ **GEN-VHDSTORAGEACCOUNT-NAME** - Name of storage account in which the VHD's are stored
+ **GEN-VHDRESOURCEGROUP-NAME** - Name of resource group in which the existing storage account having VHD's resides

**Custom Domain & SSL Cert related placeholders:**

+ **GEN-CUSTOM-WEBAPP-NAME** - placeholder for the name of azure app service where you'd want to attach custom domain
+ **GEN-CUSTOM-FQDN-NAME** - sample custom domain which can be added to an App Service
+ **GEN-CUSTOM-DOMAIN-SSLCERT-THUMBPRINT** - SSL cert thumbprint for the custom domain used in the custom FQDN
+ **GEN-CUSTOM-DOMAIN-SSLCERT-PASSWORD** - Password of the sample SSL cert
+ **GEN-CUSTOM-DOMAIN-SSLCERT-PFXDATA** - PFX data for the sample SSL cert
+ **GEN-SELFSIGNED-CERT-PFXDATA** - PFX data for a sample self signed cert
+ **GEN-SELFSIGNED-CERT-CERDATA** - CER data for a sample self signed cert
+ **GEN-SELFSIGNED-CERT-PASSWORD** - password for a sample self signed cert
+ **GEN-SELFSIGNED-CERT-DNSNAME** - DNS name for a sample self signed cert

**Custom Domain & SSL Cert related placeholders:**

+ **GEN-FRONTDOOR-NAME** - placeholder for the frontdoor name reserved for CI/CD
+ **GEN-FRONTDOOR-CUSTOM-HOSTNAME** - custom hostname with CNAME record mapped for the GEN-FRONTDOOR-NAME value 

Here's an example in an `azuredeploy.parameters.json` file:

```json

{
"$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
"contentVersion": "1.0.0.0",
"parameters": {
 "newStorageAccountName":{
  "value": "GEN-UNIQUE"
 },
 "adminUsername": {
  "value": "GEN-UNIQUE"
 },
 "sshKeyData": {
  "value": "GEN-SSH-PUB-KEY"
 },
 "dnsNameForPublicIP": {
  "value": "GEN-UNIQUE-13"
 }
}
```

### raw.githubusercontent.com Links

If you're making use of **raw.githubusercontent.com** links within your template contribution (within the template file itself or any scripts in your contribution) please ensure the following:

+ Ensure any raw.githubusercontent.com links which refer to content within your pull request points to `https://raw.githubusercontent.com/Azure/azure-quickstart-templates/...` and **NOT** your fork.
+ All raw.githubusercontent.com links are placed in your azuredeploy.json and you pass the link down into your scripts & linked templates via this top-level template. This ensures we re-link correctly from your pull-request repository and branch.
+ Although pull requests with links pointing to `https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/...` may not exist in the Azure repo at the time of your pull-request, at CI run-time, those links will be converted to `https://raw.githubusercontent.com/{your_user_name}/azure-quickstart-templates/{your_branch}/...`. Be sure to check the casing of `https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/...` as this is case-sensitive.

Note: You can find an **example** of relative linking in the [nested template section](/1-CONTRIBUTION-GUIDE/best-practices.md#nested-templates) of best practices document.

### Template Pre-requisites

If your template has some pre-requisite such as existing Virtual Network or storage account, you should also submit pre-requisite template which deploys the pre-requisite components. CI automated validation engine automatically validates and deploy the pre-reqsuite template first and then deploys the main template. Following guidelines would help you in understanding how to leverage this capability.

+ Create a folder named  `prereqs` in root of your template folder, Store  pre-requisite template file, parameters file and  artifacts inside this folder.
+ Store pre-requisite template file with name  `prereq.azuredeploy.json` and parameters files with name  `prereq.azuredeploy.parameters.json`
+ `prereq.azuredeploy.json` should deploy all required pre-existing resources by your main template and also output the values required by main template to leverage those resources. For example, if your template needs an existing VNET to be available prior to the deployment of main template, you should develop a pre-req template which deploys a VNET and outputs the VNET ID or VNET name of the virtual network created.
+ In order to use the values generated by outputs after deployment of `prereq.azuredeploy.json`, you will need to define parameter values as `GET-PREREQ-OutputName`. For example, if you generated a output with name  `vnetID` in pre-req template, in order use the value of this output in main template, enter the value of corresponding parameter in main template parameters file as `GET-PREREQ-vnetID`
+ Check out this [sample template](https://github.com/Azure/azure-quickstart-templates/tree/master/101-subnet-add-vnet-existing) to learn more



This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
