resource "azurerm_automation_account" "this" {
  name                = var.automation_account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Basic"
  tags                = var.tags

  identity {
    type = "SystemAssigned"
  }
}

# Role assignment for automation account to manage VMs
resource "azurerm_role_assignment" "vm_contributor" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = azurerm_automation_account.this.identity[0].principal_id
}

data "azurerm_client_config" "current" {}

# Auto-shutdown runbook
resource "azurerm_automation_runbook" "shutdown_vms" {
  count = var.enable_vm_auto_shutdown ? 1 : 0

  name                    = "Shutdown-NonProd-VMs"
  location                = var.location
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.this.name
  log_verbose             = false
  log_progress            = false
  runbook_type            = "PowerShell"
  tags                    = var.tags

  content = <<-EOT
    # Shutdown Non-Production VMs
    $envTagName = "${var.environment_tag_name}"
    $nonProdEnvs = @(${join(", ", formatlist("'%s'", var.non_prod_environments))})

    Connect-AzAccount -Identity

    $vms = Get-AzVM -Status | Where-Object {
        $_.Tags[$envTagName] -in $nonProdEnvs -and 
        $_.PowerState -eq "VM running"
    }

    foreach ($vm in $vms) {
        Write-Output "Stopping VM: $($vm.Name) in RG: $($vm.ResourceGroupName)"
        Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName -Force
    }

    Write-Output "Shutdown complete. Stopped $($vms.Count) VMs."
  EOT
}

# Schedule for auto-shutdown
resource "azurerm_automation_schedule" "daily_shutdown" {
  count = var.enable_vm_auto_shutdown ? 1 : 0

  name                    = "Daily-NonProd-Shutdown"
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.this.name
  frequency               = "Day"
  interval                = 1
  timezone                = var.shutdown_timezone
  start_time              = "${formatdate("YYYY-MM-DD", timeadd(timestamp(), "24h"))}T${var.shutdown_time}:00+00:00"
  description             = "Daily shutdown of non-production VMs"

  lifecycle {
    ignore_changes = [start_time]
  }
}

# Link runbook to schedule
resource "azurerm_automation_job_schedule" "shutdown_job" {
  count = var.enable_vm_auto_shutdown ? 1 : 0

  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.this.name
  schedule_name           = azurerm_automation_schedule.daily_shutdown[0].name
  runbook_name            = azurerm_automation_runbook.shutdown_vms[0].name
}