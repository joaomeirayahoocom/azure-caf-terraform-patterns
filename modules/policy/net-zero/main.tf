# Net Zero Policy Initiative
resource "azurerm_policy_set_definition" "net_zero" {
  name                = "net-zero-initiative"
  policy_type         = "Custom"
  display_name        = "Net Zero Sustainability Policies"
  description         = "Policies to support carbon reduction and sustainability goals"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = "Net Zero"
    version  = "1.0.0"
  })

  parameters = jsonencode({
    allowedLocations = {
      type = "Array"
      metadata = {
        displayName = "Allowed locations"
        description = "Regions with lower carbon intensity"
      }
    }
  })

  # Restrict to low-carbon regions
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
    parameter_values = jsonencode({
      listOfAllowedLocations = { value = "[parameters('allowedLocations')]" }
    })
    reference_id = "AllowedLocations"
  }

  # Audit unattached managed disks (waste reduction)
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c0b1e8db-9d88-47c6-ad7a-3b8e9d5c0e4e"
    reference_id         = "AuditUnattachedDisks"
  }

  # Audit storage accounts without lifecycle management
  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/d8e6b0f3-5a4e-4c9a-b6d7-8f2e1a3c4b5d"
    reference_id         = "AuditStorageLifecycle"
  }
}

# Custom policy: Require carbon tracking tag
resource "azurerm_policy_definition" "require_carbon_tag" {
  name                = "require-carbon-tracking-tag"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Require CarbonTracking tag on resources"
  description         = "Ensures all resources have CarbonTracking tag for sustainability reporting"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = "Net Zero"
    version  = "1.0.0"
  })

  policy_rule = jsonencode({
    if = {
      field  = "tags['CarbonTracking']"
      exists = "false"
    }
    then = {
      effect = "audit"
    }
  })
}

# Custom policy: Audit oversized VMs
resource "azurerm_policy_definition" "audit_oversized_vms" {
  name                = "audit-oversized-vms"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Audit oversized virtual machines"
  description         = "Identifies VMs larger than Standard_D4s_v3 for right-sizing review"
  management_group_id = var.management_group_id

  metadata = jsonencode({
    category = "Net Zero"
    version  = "1.0.0"
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Compute/virtualMachines"
        },
        {
          field = "Microsoft.Compute/virtualMachines/hardwareProfile.vmSize"
          notIn = [
            "Standard_B1s",
            "Standard_B1ms",
            "Standard_B2s",
            "Standard_B2ms",
            "Standard_D2s_v3",
            "Standard_D2s_v4",
            "Standard_D2s_v5",
            "Standard_D4s_v3",
            "Standard_D4s_v4",
            "Standard_D4s_v5"
          ]
        }
      ]
    }
    then = {
      effect = "audit"
    }
  })
}

# Assign Net Zero Initiative
resource "azurerm_management_group_policy_assignment" "net_zero" {
  name                 = "net-zero"
  display_name         = "Net Zero Sustainability Policies"
  description          = "Enforces sustainability and carbon reduction policies"
  policy_definition_id = azurerm_policy_set_definition.net_zero.id
  management_group_id  = var.management_group_id
  enforce              = var.enforcement_mode == "Default" ? true : false

  parameters = jsonencode({
    allowedLocations = { value = var.allowed_regions }
  })

  non_compliance_message {
    content = "This resource does not comply with Net Zero sustainability policies."
  }
}

# Assign carbon tracking tag policy
resource "azurerm_management_group_policy_assignment" "carbon_tag" {
  name                 = "require-carbon-tag"
  display_name         = "Require CarbonTracking Tag"
  description          = "Audits resources missing CarbonTracking tag"
  policy_definition_id = azurerm_policy_definition.require_carbon_tag.id
  management_group_id  = var.management_group_id
  enforce              = false
}

# Assign oversized VM audit policy
resource "azurerm_management_group_policy_assignment" "oversized_vms" {
  name                 = "audit-oversized-vms"
  display_name         = "Audit Oversized VMs"
  description          = "Identifies VMs for right-sizing review"
  policy_definition_id = azurerm_policy_definition.audit_oversized_vms.id
  management_group_id  = var.management_group_id
  enforce              = false
}