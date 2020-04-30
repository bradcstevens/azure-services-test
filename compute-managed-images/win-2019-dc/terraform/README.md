# Create a Virtual Machine from Azure Managed Image

This template allows you to create 1 Virtual Machine sourced from an Azure Managed Image. This template also deploys a Resource Group, Virtual Network, Network Security Group, Public IP Address, Network Interface, and Storage Account. 

## Pre-requisites
* Azure CLI
* Azure Service Principal
* WSL or Bash Shell
* Docker

## Steps to deploy

### 1. Setup Terraform to Access Azure
To enable Terraform to provision resources into Azure, create an Azure AD service principal. The service principal grants your Terraform scripts to provision resources in your Azure subscription.

If you have multiple Azure subscriptions, first query your account with az account list to get a list of subscription ID and tenant ID values:

```
az account list --query "[].{name:name, subscriptionId:id, tenantId:tenantId}"
```

To use a selected subscription, set the subscription for this session with az account set. Set the SUBSCRIPTION_ID environment variable to hold the value of the returned id field from the subscription you want to use:

```
az account set --subscription="${SUBSCRIPTION_ID}"
```

Now you can create a service principal for use with Terraform. Use az ad sp create-for-rbac, and set the scope to your subscription as follows:

```
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"
```

### 2. Define and source local environment variables for Terraform to authenticate to ARM via Service Principal. 

#### Example:

```
user@workstation:~$ cat << EOF >> .env
ARM_CLIENT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
ARM_CLIENT_SECRET=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
ARM_SUBSCRIPTION_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
ARM_TENANT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
ARM_OBJECT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
EOF
```

### 3. Source the environment file

```
user@workstation:~$ source .env
```

### 4. Define the variables for the solution in the `terraform.tfvars` file. 

#### Example:

```
tag_owner                           = "brad.stevens@cdw.com"
tag_environment                     = "Development"
managed_image_name                  = "win-2019-dc"
managed_image_resource_group        = "msp-managed-images-rg01"
resource_group_name                 = "msp-win2019dc-rg01"
location                            = "westus"
virtual_network_name                = "vnet01"
address_space                       = "192.168.1.0/24"
subnet_name                         = "sn001"
subnet_prefix                       = "192.168.1.0/29"
vm_name                             = "win2019dc01"
vm_size                             = "Standard_DS1_v2"
hostname                            = "win2019dc01"
admin_username                      = "azureuser"
admin_password                      = "Password999!"
```

### 5. Run deploy.ci.sh 

```
user@workstation:~$ bash deploy.ci.sh
```

## Terraform Files

The `main.tf` file contains the actual resources that will be deployed. It also contains the Azure Resource Group definition and any defined variables. 

Azure requires that an application is added to Azure Active Directory to generate the `client_id`, `client_secret`, and `tenant_id` needed by Terraform (`subscription_id` can be recovered from your Azure account details). Please go [here](https://www.terraform.io/docs/providers/azurerm/) for full instructions on how to create this to populate your `provider.tf` file.

If a `terraform.tfvars` or any `.auto.tfvars` files are present in the current directory, Terraform automatically loads them to populate variables. Do not save usernames and passwords to version control other than to serve as placeholders. Create a local secret variables file and use the `-var-file` flag or the `.auto.tfvars` extension to load it.

If you are committing this template to source control, please insure that you add this file to your .gitignore file.

The `variables.tf` file contains all of the input parameters that the user can specify when deploying this Terraform template.

