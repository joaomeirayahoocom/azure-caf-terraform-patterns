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
| Management | `monitoring` | 🔲 Planned |
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

### Example Usage
```hcl
module "identity" {
  source = "./modules/identity"

  resource_group_name = "rg-identity-prd-eus2-001"
  location            = "eastus2"
  identity_name       = "id-webapp-prd-eus2-001"

  role_assignments = {
    keyvault_reader = {
      scope                = module.keyvault.key_vault_id
      role_definition_name = "Key Vault Secrets User"
    }
  }

  tags = {
    Environment    = "prod"
    CarbonTracking = "enabled"
  }
}

module "keyvault" {
  source = "./modules/security"

  resource_group_name       = "rg-security-prd-eus2-001"
  location                  = "eastus2"
  key_vault_name            = "kv-webapp-prd-eus2"
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  enable_rbac_authorization = true

  tags = {
    Environment    = "prod"
    CarbonTracking = "enabled"
  }
}
```

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

### SKU Options

| SKU | Use Case |
|-----|----------|
| B1 | Dev/Test |
| S1 | Production (small) |
| P1v3 | Production (performance) |

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
| Eliminate waste | Unattached disk detection |
| Region selection | Restrict to low-carbon regions |
| Measure and report | CarbonTracking tag requirement |

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
- [Azure Sustainability](https://azure.microsoft.com/explore/global-infrastructure/sustainability)