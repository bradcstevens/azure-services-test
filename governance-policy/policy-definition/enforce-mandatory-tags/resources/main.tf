resource "azurerm_policy_definition" "policy_definition" {
  name         = "POL-Enforce resource tags"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "POL-Enforce resource tags"

  metadata = <<METADATA
    {
    "category": "Under Review"
    }
  METADATA

  policy_rule = <<POLICY_RULE
    {
        "if": {
            "allOf": [{
                    "not": {
                        "field": "tags",
                        "containsKey": "owner"
                    }
                },
                {
                    "not": {
                        "field": "tags",
                        "containsKey": "department"
                    }
                },
                {
                    "not": {
                        "field": "tags",
                        "containsKey": "environment"
                    }
                },
                {
                    "not": {
                        "field": "tags",
                        "containsKey": "application"
                    }
                }
            ]
        },
        "then": {
            "effect": "deny"
        }
    }
  POLICY_RULE
}