data "azurerm_subscription" "current" {}

output "subscription_id" {
  value = "${data.azurerm_subscription.current.id}"
}

data "azurerm_policy_definition" "definition" {
  display_name = "POL-Enforce resource tags"
}

output "policy_definition_id" {
  value = "${data.azurerm_policy_definition.definition.id}"
}

resource "azurerm_policy_assignment" "policy" {
  name                 = "POL-Enforce resource group tags"
  scope                = data.azurerm_subscription.current.id
  policy_definition_id = data.azurerm_policy_definition.definition.id
  display_name         = "POL-Enforce resource tags"