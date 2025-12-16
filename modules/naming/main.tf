locals {
  # Resource type prefixes (CAF standard)
  resource_prefixes = {
    # General
    resource_group     = "rg"
    management_group   = "mg"
    
    # Networking
    virtual_network    = "vnet"
    subnet             = "snet"
    network_security_group = "nsg"
    route_table        = "rt"
    public_ip          = "pip"
    private_endpoint   = "pep"
    private_dns_zone   = "pdns"
    application_gateway = "agw"
    firewall           = "afw"
    firewall_policy    = "afwp"
    bastion_host       = "bas"
    
    # Compute
    virtual_machine    = "vm"
    app_service        = "app"
    app_service_plan   = "asp"
    function_app       = "func"
    
    # Storage
    storage_account    = "st"
    
    # Security
    key_vault          = "kv"
    managed_identity   = "id"
    
    # Monitoring
    log_analytics      = "log"
    application_insights = "appi"
  }

  # Generate standard names
  names = {
    for resource_type, prefix in local.resource_prefixes :
    resource_type => lower("${prefix}-${local.base_name}-${var.instance}")
  }

  # Names requiring global uniqueness (no hyphens, length limits)
  unique_names = {
    storage_account = lower(substr(replace("st${var.org_prefix}${var.workload}${local.env_short}${local.unique_suffix}", "-", ""), 0, 24))
    key_vault       = lower(substr("kv-${var.org_prefix}-${var.workload}-${local.env_short}-${local.unique_suffix}", 0, 24))
    app_service     = lower("app-${local.base_name}-${local.unique_suffix}")
  }
}