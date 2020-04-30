# Deployment of a Policy Definition and Assignments

## Pre-requisites
* Azure CLI
* WSL or Bash
* Homebrew (MacOS only)
* Azure Service Principal
* Terraform
* Docker

### MacOS Setup
```
brew install docker docker-machine
brew cask install virtualbox
docker-machine create --driver virtualbox default
docker-machine env default
eval "$(docker-machine env default)"
docker run hello-world
docker-machine stop default
```

### Setting up Terraform Access to Azure

To enable Terraform to provision resources into Azure, you need to create two entities in Azure Active Directory (AAD) - AAD Application and AAD Service Principal. [Azure CLI 2.0](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) allows you to quickly provision both by following the instructions below. 

First, login to administer your azure subscription by issuing the following command

```
az login
```

NOTE: If you're using the China, German or Government Azure Clouds, you need to first configure the Azure CLI to work with that Cloud. You can do this by running:

```
az cloud set --name AzureChinaCloud|AzureGermanCloud|AzureUSGovernment
```

If you have multiple Azure Subscriptions, their details are returned by the az login command. 
Set the Subscription that you want to use for this session.

```
az account set --subscription="${SUBSCRIPTION_ID}"
```

Query the account to get the Subscription Id and Tenant Id values.

```
az account show --query "{subscriptionId:id, tenantId:tenantId}"
```

Next, create separate credentials for Terraform.

```
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"
```

This outputs your client_id (appId), client_secret (password), sp_name, and tenant. Take note of all these variables. Use the returned `appId` value for the `service_principal_client_id` variable in `terraform.tfvars`. Use the password value for the `service_principal_client_secret` variable in `terraform.tfvars`.

NOTE: instead of inserting these values into a `terraform.tfvars` file, you can set corresponding environment variables as described in detail on [docs.microsoft.com](https://docs.microsoft.com/en-us/azure/virtual-machines/terraform-install-configure).