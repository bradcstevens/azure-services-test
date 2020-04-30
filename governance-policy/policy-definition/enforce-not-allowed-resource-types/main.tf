resource "azurerm_policy_definition" "policy_definition" {
  name         = "POL-Enforce not allowed resource types"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "POL-Enforce not allowed resource types"

    metadata = <<METADATA
    {
        "category": "IAAI Under Review"
    }
    METADATA

    policy_rule = <<POLICY_RULE
    {
        "if": {
            "field": "type",
            "in": "[parameters('listOfResourceTypesNotAllowed')]"
        },
        "then": {
            "effect": "Deny"
        }
    }
  POLICY_RULE

    parameters = <<PARAMETERS
    {
      "listOfResourceTypesNotAllowed": {
            "type": "Array",
            "metadata": {
                "description": "The list of resource types that cannot be deployed.",
                "displayName": "Not allowed resource types",
                "strongType": "resourceTypes"
            }
        }
    }
  PARAMETERS
}