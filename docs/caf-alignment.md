# Cloud Adoption Framework Alignment

This repository aligns with Microsoft's Cloud Adoption Framework (CAF) enterprise-scale landing zone architecture.

## Design Area Coverage

| CAF Design Area | Module | Status |
|-----------------|--------|--------|
| Resource organization | `management-groups` | ✅ |
| Azure billing | `subscription-vending` | ✅ |
| Governance | `policy/caf-baseline` | ✅ |
| Sustainability | `policy/net-zero` | ✅ |
| Identity and access | `identity` | 🔲 Planned |
| Network topology | `networking/hub-spoke` | 🔲 Planned |
| Security | `security` | 🔲 Planned |
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
- [Azure Sustainability](https://azure.microsoft.com/explore/global-infrastructure/sustainability)