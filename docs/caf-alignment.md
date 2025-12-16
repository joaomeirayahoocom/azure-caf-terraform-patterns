# Cloud Adoption Framework Alignment

This repository aligns with Microsoft's Cloud Adoption Framework (CAF) enterprise-scale landing zone architecture.

## Design Area Coverage

| CAF Design Area | Module | Status |
|-----------------|--------|--------|
| Resource organization | `management-groups` | ✅ |
| Azure billing | `subscription-vending` | ✅ |
| Identity and access | `identity` | 🔲 Planned |
| Network topology | `networking/hub-spoke` | 🔲 Planned |
| Security | `security` | 🔲 Planned |
| Management | `monitoring` | 🔲 Planned |
| Governance | `policy/caf-baseline` | 🔲 Planned |
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

## Net Zero Principles

This implementation extends CAF with sustainability:

| Principle | Implementation |
|-----------|----------------|
| Right-size first | Compute module defaults |
| Eliminate waste | Resource lifecycle policies |
| Measure and report | Carbon tracking module |

## References

- [CAF Enterprise-Scale](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/architecture)
- [CAF Naming Convention](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)