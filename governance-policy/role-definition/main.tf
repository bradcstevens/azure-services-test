data "azurerm_subscription" "primary" {}

resource "azurerm_role_definition" "example" {
  name        = "Test-Contributor"
  scope       = "${data.azurerm_subscription.primary.id}"
  description = "Custom Contributor that lets you manage everything except managing Compute, Network resources and access to resources."

  permissions {
    actions     = ["*"]
    not_actions = [
          "Microsoft.Compute/*/Delete",
          "Microsoft.Compute/*/Write",
          "Microsoft.Network/virtualNetworks/*/Delete",
          "Microsoft.Network/virtualNetworks/*/Write",
          "Microsoft.Network/routeFilters/*/Delete",
          "Microsoft.Network/routeFilters/*/Write",
          "Microsoft.Network/networkWatchers/*/Delete",
          "Microsoft.Network/networkWatchers/*/Write",
          "Microsoft.Network/dnszones/*/Delete",
          "Microsoft.Network/dnszones/*/Write",
          "Microsoft.Network/expressRouteCircuits/*/Delete",
          "Microsoft.Network/expressRouteCircuits/*/Write",
          "Microsoft.Network/connections/*/Delete",
          "Microsoft.Network/connections/*/Write",
          "Microsoft.Network/virtualnetworkgateways/*/Delete",
          "Microsoft.Network/virtualnetworkgateways/*/Write",
          "Microsoft.Network/localnetworkgateways/*/Delete",
          "Microsoft.Network/localnetworkgateways/*/Write",
          "Microsoft.Network/virtualWans/*/Delete",
          "Microsoft.Network/virtualWans/*/Write",
          "Microsoft.Network/expressRouteCrossConnections/*/Delete",
          "Microsoft.Network/expressRouteCrossConnections/*/Write",
          "Microsoft.Network/vpnGateways/*/Delete",
          "Microsoft.Network/vpnGateways/*/Write",
          "Microsoft.Network/expressRoutePorts/*/Delete",
          "Microsoft.Network/expressRoutePorts/*/Write",
          "Microsoft.Network/expressRouteGateways/*/Delete",
          "Microsoft.Network/expressRouteGateways/*/Write",
          "Microsoft.Network/p2sVpnGateways/*/Delete",
          "Microsoft.Network/p2sVpnGateways/*/Write",
          "Microsoft.Network/bastionHosts/*/Delete",
          "Microsoft.Network/bastionHosts/*/Write",
          "Microsoft.Network/privateDnsZones/*/Delete",
          "Microsoft.Network/privateDnsZones/*/Write",
          "Microsoft.Network/serviceEndpointPolicies/*/Delete",
          "Microsoft.Network/serviceEndpointPolicies/*/Write",
          "Microsoft.Network/networkSecurityGroups/*/Delete",
          "Microsoft.Network/networkSecurityGroups/*/Write",
          "Microsoft.Network/routeTables/*/Delete",
          "Microsoft.Network/routeTables/*/Write",
          "Microsoft.Sql/*/Delete",
          "Microsoft.Sql/*/Write",
          "Microsoft.SqlVirtualMachine/*/Delete",
          "Microsoft.SqlVirtualMachine/*/Write",
          "Microsoft.DBforMySQL/*/Delete",
          "Microsoft.DBforMySQL/*/Write",
          "Microsoft.DocumentDB/*/Delete",
          "Microsoft.DocumentDB/*/Write",
          "Microsoft.SqlVirtualMachine/*/Delete",
          "Microsoft.SqlVirtualMachine/*/Write",
          "Microsoft.Authorization/*/Delete",
          "Microsoft.Authorization/*/Write",
          "Microsoft.Subscription/*",
          "Microsoft.Management/managementGroups/*",
          "Microsoft.Authorization/*/Action",
          "Microsoft.Blueprint/blueprintAssignments/write",
          "Microsoft.Blueprint/blueprintAssignments/delete"
    ]
  }

  assignable_scopes = [
    "${data.azurerm_subscription.primary.id}"
  ]
}