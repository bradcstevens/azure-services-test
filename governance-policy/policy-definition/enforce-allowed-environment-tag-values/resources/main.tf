resource "azurerm_policy_definition" "policy_definition" {
  name         = "POL-Enforce resource environment tag values"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "POL-Enforce resource environment tag values"

    metadata = <<METADATA
    {
        "category": "Under Review"
    }
    METADATA

    policy_rule = <<POLICY_RULE
    {
        "if": {
            "allOf": [{ 
                    "field": "type",
                    "equals": "Microsoft.Resources"
                },
                {
                    "not": {
                        "field": "tags.environment",
                        "match": "UAT"
                    }
                },
                {
                    "not": {
                        "field": "tags.environment",
                        "match": "STG"
                    }
                },
                {
                    "not": {
                        "field": "tags.environment",
                        "match": "PRD"
                    }
                },
                {
                    "not": {
                        "field": "tags.environment",
                        "match": "DEV"
                    }
                },
                {
                    "not": {
                        "field": "tags.environment",
                        "match": "QAS"
                    }
                },
                {
                    "not": {
                        "field": "tags.environment",
                        "match": "POC"
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