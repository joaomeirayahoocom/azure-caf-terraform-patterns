resource "azurerm_management_group_policy_assignment" "this" {
  name                 = var.name
  display_name         = var.display_name
  description          = var.description
  policy_definition_id = var.policy_definition_id
  management_group_id  = var.scope
  enforce              = var.enforcement_mode == "Default" ? true : false
  parameters           = var.parameters

  non_compliance_message {
    content = var.non_compliance_message
  }
}