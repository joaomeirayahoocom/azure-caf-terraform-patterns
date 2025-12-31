# Cloud Adoption Framework Alignment

This repository aligns with Microsoft's Cloud Adoption Framework (CAF) enterprise-scale landing zone architecture.

## Design Area Coverage

| CAF Design Area | Module | Status |
|-----------------|--------|--------|
| Resource organization | `management-groups` | ✅ |
| Azure billing | `subscription-vending` | ✅ |
| Governance | `policy/caf-baseline` | ✅ |
| Sustainability | `policy/net-zero` | ✅ |
| Network topology | `networking/hub-spoke`, `networking/spoke` | ✅ |
| Private DNS | `networking/private-dns` | ✅ |
| Compute | `compute/app-service` | ✅ |
| Identity and access | `identity` | ✅ |
| Security | `security` | ✅ |
| FinOps | `finops/budgets`, `finops/resource-lifecycle` | ✅ |
| Management | `monitoring`, `monitoring/diagnostic-settings` | ✅ |
| Platform automation | GitHub Actions | ✅ |

## Management Group Hierarchy
```
Contoso (root)
├── Platform
│   ├── Identity
│   ├── Management
│   └── Connectivity
├── Landing Zones
│   ├── Prod
│   └── Dev
└── Decommissioned
```

## Naming Convention

Follows CAF recommended naming: `{prefix}-{workload}-{env}-{region}-{instance}`

Example: `rg-webapp-prd-eus2-001`

## Network Architecture

### Hub-Spoke Topology
```
                    ┌─────────────────┐
                    │    Internet     │
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │   Azure Firewall │
                    └────────┬────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
┌───────▼───────┐   ┌───────▼───────┐   ┌───────▼───────┐
│   Hub VNet    │   │  Spoke: Prod  │   │  Spoke: Dev   │
│  10.0.0.0/16  │◄──►  10.1.0.0/16  │   │  10.2.0.0/16  │
└───────────────┘   └───────────────┘   └───────────────┘
```

### Default Hub Subnets

| Subnet | CIDR | Purpose |
|--------|------|---------|
| AzureFirewallSubnet | 10.0.0.0/26 | Azure Firewall |
| AzureBastionSubnet | 10.0.0.64/26 | Bastion Host |
| GatewaySubnet | 10.0.0.128/27 | VPN/ExpressRoute Gateway |

### Private DNS Zones

Pre-configured zones for Azure PaaS services:

- privatelink.blob.core.windows.net
- privatelink.file.core.windows.net
- privatelink.queue.core.windows.net
- privatelink.table.core.windows.net
- privatelink.vaultcore.azure.net
- privatelink.database.windows.net
- privatelink.azurecr.io
- privatelink.azurewebsites.net

## Identity & Security

### Managed Identity Module

| Feature | Support |
|---------|---------|
| User-assigned identity | ✅ |
| Role assignments | ✅ |
| Multiple scopes | ✅ |

### Key Vault Module

| Feature | Support |
|---------|---------|
| RBAC authorization | ✅ |
| Private endpoint | ✅ |
| Network ACLs | ✅ |
| Purge protection | ✅ |
| Diagnostic settings | ✅ |

## Compute - App Service

### Features

| Feature | Support |
|---------|---------|
| Linux Web App | ✅ |
| Windows Web App | ✅ |
| VNet Integration | ✅ |
| Private Endpoint | ✅ |
| System-assigned Identity | ✅ |
| .NET, Node.js, Python | ✅ |

## FinOps & Cost Management

### Budgets Module

| Feature | Support |
|---------|---------|
| Subscription budgets | ✅ |
| Resource group budgets | ✅ |
| Multiple alert thresholds | ✅ |
| Email notifications | ✅ |
| Monthly/Quarterly/Annual | ✅ |

### Resource Lifecycle Module

| Feature | Support |
|---------|---------|
| Automation account | ✅ |
| Non-prod VM auto-shutdown | ✅ |
| Scheduled runbooks | ✅ |
| Tag-based targeting | ✅ |
| Managed identity auth | ✅ |

## Monitoring

### Log Analytics Module

| Feature | Support |
|---------|---------|
| Log Analytics workspace | ✅ |
| Application Insights | ✅ |
| Container Insights solution | ✅ |
| VM Insights solution | ✅ |
| Configurable retention | ✅ |
| Daily quota cap | ✅ |

### Diagnostic Settings Module

| Feature | Support |
|---------|---------|
| Log categories | ✅ |
| Metric categories | ✅ |
| All logs option | ✅ |
| Log Analytics destination | ✅ |

### Example Usage
```hcl
module "monitoring" {
  source = "./modules/monitoring"

  resource_group_name         = "rg-monitoring-prd-eus2-001"
  location                    = "eastus2"
  log_analytics_name          = "log-platform-prd-eus2-001"
  retention_in_days           = 90
  enable_application_insights = true
  application_insights_name   = "appi-webapp-prd-eus2-001"

  tags = {
    Environment    = "prod"
    CarbonTracking = "enabled"
  }
}

module "diag_keyvault" {
  source = "./modules/monitoring/diagnostic-settings"

  name                       = "diag-keyvault"
  target_resource_id         = module.keyvault.key_vault_id
  log_analytics_workspace_id = module.monitoring.log_analytics_workspace_id
  enable_all_logs            = true
}
```

## Policy Framework

### CAF Baseline Policies

| Policy | Effect | Purpose |
|--------|--------|---------|
| Require Environment tag | Audit | Resource classification |
| Require Owner tag | Audit | Accountability |
| Require CostCenter tag | Audit | Cost allocation |
| Audit managed disks | Audit | Best practice compliance |
| Audit resource locks | Audit | Protection verification |

### Net Zero Policies

| Policy | Effect | Purpose |
|--------|--------|---------|
| Allowed locations | Deny | Restrict to low-carbon regions |
| Audit unattached disks | Audit | Eliminate waste |
| Require CarbonTracking tag | Audit | Sustainability reporting |
| Audit oversized VMs | Audit | Right-sizing opportunities |

## Net Zero Principles

This implementation extends CAF with sustainability:

| Principle | Implementation |
|-----------|----------------|
| Right-size first | Audit oversized VMs policy |
| Eliminate waste | Unattached disk detection, auto-shutdown |
| Region selection | Restrict to low-carbon regions |
| Measure and report | CarbonTracking tag requirement |
| Cost optimization | Budgets with alerts |

## Allowed Low-Carbon Regions

Default regions selected for lower carbon intensity:

- eastus2
- westus2
- northeurope
- swedencentral

## References

- [CAF Enterprise-Scale](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/architecture)
- [CAF Naming Convention](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
- [Hub-Spoke Topology](https://learn.microsoft.com/azure/architecture/reference-architectures/hybrid-networking/hub-spoke)
- [App Service Best Practices](https://learn.microsoft.com/azure/app-service/overview-best-practices)
- [Key Vault Best Practices](https://learn.microsoft.com/azure/key-vault/general/best-practices)
- [Azure Cost Management](https://learn.microsoft.com/azure/cost-management-billing/costs/overview-cost-management)
- [Azure Monitor Overview](https://learn.microsoft.com/azure/azure-monitor/overview)
- [Azure Sustainability](https://azure.microsoft.com/explore/global-infrastructure/sustainability)