# Create-Azure-Traffic-Manager

<
This template deploys a **Azure-Traffic-Manager**. The **Azure-Traffic-Manager** is a **Azure Traffic Manager is a DNS-based traffic load balancer that you can use to distribute traffic optimally to services across Azure regions globally.**

##Create-Azure-Traffic-Manager overview and deployed resources

This arm template deploys a Create-Azure-Traffic-Manager infront of two web endpoints/websites into an Azure tenant.

## The following resources are deployed as part of the solution:

### Resource provider 1 (eg., myAppServicePlanEastUS)

Azure app service plan that host the first web endpoint/web application.

### Resource provider 2 (e.g., myAppServicePlanWestUS)

Azure app service plan that host the second web endpoint/web application.

### Resource provider 3 (e.g., webappomi1)

First web application provisioned

### Resource provider 4 (e.g., webappomi2)

Second web application provisioned 

### Resource provider 5 (e.g., trafficmanageromiyale)

Azure traffic manager profile created to load balance and distribute traffic between the two web endpoints/web applications.

## Prerequisites

Azure Account and Subscription
Visual Studio Code
PowerShell module/Az module installation

## Deployment steps

Follow the instructions for PowerShell cmdlets deployment using the deploy scripts in the folder of this repo.  The instructions should succinctly spell out how to execute this script.

## Usage

### Connect

Open the folder that contains the arm template with visual studio code
Run the PowerShell deploy script

#### Management

You can manage or edit the parameter.json file using visual studio code to update values accordingly.

## Notes

Solution notes

#Azure Traffic manager will be provisioned accordingly infront of two App service into the Azure tenant.
