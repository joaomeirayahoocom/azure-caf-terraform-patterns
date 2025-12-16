locals {
  # Region abbreviations (CAF recommended)
  region_abbreviations = {
    "eastus"        = "eus"
    "eastus2"       = "eus2"
    "westus"        = "wus"
    "westus2"       = "wus2"
    "westus3"       = "wus3"
    "centralus"     = "cus"
    "northeurope"   = "neu"
    "westeurope"    = "weu"
    "uksouth"       = "uks"
    "ukwest"        = "ukw"
    "southeastasia" = "sea"
    "eastasia"      = "ea"
    "australiaeast" = "aue"
    "japaneast"     = "jpe"
    "brazilsouth"   = "brs"
    "canadacentral" = "cac"
  }

  region_short = lookup(local.region_abbreviations, var.region, substr(var.region, 0, 4))

  # Environment abbreviations
  env_abbreviations = {
    "dev"  = "dev"
    "prod" = "prd"
  }

  env_short = lookup(local.env_abbreviations, var.environment, var.environment)

  # Base naming pattern: {org}-{workload}-{env}-{region}
  base_name = "${var.org_prefix}-${var.workload}-${local.env_short}-${local.region_short}"

  # Unique suffix for globally unique resources
  unique_suffix = substr(md5("${var.org_prefix}${var.workload}${var.environment}"), 0, 6)
}