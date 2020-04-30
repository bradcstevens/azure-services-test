# Create a Resource Group

Typically, you deploy Azure resources to a resource group in your Azure subscription. However, you can also create resources at the subscription level. You use subscription level deployments to take actions that make sense at that level, such as creating resource groups, or assigning role-based access control.

To deploy templates at the subscription level, use Azure CLI, PowerShell, or REST API. The Azure portal doesn't support deployment in the subscription level.

## Schema

The schema you use for subscription-level deployments is different than the schema for resource group deployments.

For templates, use:
```
https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#
```
For parameter files, use:
```
https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentParameters.json#
```

## Deployment Commands
The commands for subscription-level deployments are different than the commands for resource group deployments.

For the Azure CLI, use az deployment create. The following example deploys a template to create a resource group:

```
az deployment create \
  --name demoDeployment \
  --location centralus \
  --template-uri https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/emptyRG.json \
  --parameters rgName=demoResourceGroup rgLocation=centralus
```

For the PowerShell deployment command, use New-AzDeployment. The following example deploys a template to create a resource group:

```
New-AzDeployment `
  -Name demoDeployment `
  -Location centralus `
  -TemplateUri https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/emptyRG.json `
  -rgName demoResourceGroup `
  -rgLocation centralus
```

## Reference
https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-to-subscription 