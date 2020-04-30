<h1 class="large"><b>Azure FrontDoor</b></h1>

This template deploys two Azure Web App Sites behind Azure Front Door in Active/Passive.

<h2 class="small"><b>Overview and deployed resources</b></h2>

Azure Front Door enables you to define, manage, and monitor the global routing for your web traffic by optimizing for best performance and instant global failover for high availability. With Front Door, you can transform your global (multi-region) consumer and enterprise applications into robust, high-performance personalized modern applications, APIs, and content that reaches a global audience with Azure.

Front Door works at Layer 7 or HTTP/HTTPS layer and uses anycast protocol with split TCP and Microsoft's global network for improving global connectivity. So, per your routing method selection in the configuration, you can ensure that Front Door is routing your client requests to the fastest and most available application backend. An application backend is any Internet-facing service hosted inside or outside of Azure. Front Door provides a range of traffic-routing methods and backend health monitoring options to suit different application needs and automatic failover models. Similar to Traffic Manager, Front Door is resilient to failures, including the failure of an entire Azure region.

The following resources are deployed as part of the solution:<p>
Azure Front Door

    Resource Group 1: Azure Web App and App Service Plan
    Resource Group 2: Azure Web App and App Service Plan
    Resource Group 3: Azure Front Door

<h2><b>Prerequisites</b></h2>
1. Users will need the "Azure" PowerShell module installed to run the deployment commands. Users can install/import that module with the following commands:

    Install-Module -Name Az -AllowClobber -Force | Import-Module -Name Az
    
<h2><b>Deployment steps</b></h2>

<body>
1. Open "AzureFrontDoorDeploy.ps1" and modify the name of the Resource Groups and/or Locations you would like the Web Apps and Front Door deployed to.<br>
2. Run the "AzureFrontDoorDeploy.ps1" script from an administrative PowerShell session.<br>
3. When Resource Groups, Web Apps, and Web App Plans have been deployed, the PowerShell Script will notify you of the name of the two Web Apps.  Go into the parameters.json and replace Backend Names with the names of the Web Apps.<br>
4. Press any key to continue.  The ARM Template will execute and create the Front Door and assign both web apps in a backend pool.
</body>

<h2 class="small"><b>How to connect and manage the solution</b></h2>
<h3 class="smaller"><b>How to connect to the solution</b></h2>
<body>
1. In Azure Portal, go to the Front Door that was deployed.<br>
2. In Front Door Designer, changes can be made to the Front End, Back End, and Routing Rules.

</body>

<h3><b>How to manage the solution</b></h3>
Azure CLI, Azure PowerShell, and the Azure Portal can all be utilized to manage Front Door.
<br></br>
Tags: AzureExpertMSP, Azure, AzureFrontDoor
