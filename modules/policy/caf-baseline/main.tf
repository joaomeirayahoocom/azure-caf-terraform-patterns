# CAF Baseline Policy Initiative
resource "azurerm_policy_set_definition" "caf_baseline" {
  name                = "caf-baseline-initiative"
  policy_type         = "Custom"
  display_name        = "CAF Baseline Governance"
  description         = "Cloud Adoption Framework baseline policies for governance"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = "CAF Baseline"
    version  = "1.0.0"
  })

  # Require resource tags
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
    parameter_values = jsonencode({
      tagName = { value = "Environment" }
    })
    reference_id = "RequireEnvironmentTag"
  }

  # Require owner tag
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
    parameter_values = jsonencode({
      tagName = { value = "Owner" }
    })
    reference_id = "RequireOwnerTag"
  }

  # Require cost center tag
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/871b6d14-10aa-478d-b590-94f262ecfa99"
    parameter_values = jsonencode({
      tagName = { value = "CostCenter" }
    })
    reference_id = "RequireCostCenterTag"
  }

  # Audit VMs without managed disks
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d"
    reference_id         = "AuditManagedDisks"
  }

  # Audit resources without resource locks
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0015ea4d-51ff-4ce3-8d8c-f3f8f0179a56"
    reference_id         = "AuditResourceLocks"
  }
}

# Assign CAF Baseline Initiative
resource "azurerm_management_group_policy_assignment" "caf_baseline" {
  name                 = "caf-baseline"
  display_name         = "CAF Baseline Governance"
  description          = "Enforces Cloud Adoption Framework baseline policies"
  policy_definition_id = azurerm_policy_set_definition.caf_baseline.id
  management_group_id  = var.management_group_id
  enforce              = var.enforcement_mode == "Default" ? true : false

  non_compliance_message {
    content = "This resource is not compliant with CAF baseline governance policies."
  }
}