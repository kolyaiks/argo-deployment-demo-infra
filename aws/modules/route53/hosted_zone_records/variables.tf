variable "hosted_zone_name" {
  description = "Enter the hosted zone."
  default     = "test.com"
}

variable "healthchecks_map" {
  description = "Enter the healthchecks map."
  default = {
    "prod_primary_env_dev" = {
      "child_health_threshold"          = 0
      "child_healthchecks"              = []
      "disabled"                        = false
      "enable_sni"                      = true
      "failure_threshold"               = 3
      "fqdn"                            = ""
      "id"                              = "32f4c876-afba-49a4-ad8c-e7c8183f8e39"
      "insufficient_data_health_status" = ""
      "invert_healthcheck"              = false
      "ip_address"                      = "18.216.156.185"
      "measure_latency"                 = false
      "port"                            = 443
      "regions"                         = []
      "request_interval"                = 30
      "resource_path"                   = "/healthcheck"
      "search_string"                   = ""
      "tags" = {
        "Name" = "prod_primary_env_dev"
      }
      "type" = "HTTPS"
    }
    "prod_secondary_env_dev" = {
      "child_health_threshold"          = 0
      "child_healthchecks"              = []
      "disabled"                        = false
      "enable_sni"                      = true
      "failure_threshold"               = 3
      "fqdn"                            = ""
      "id"                              = "05352dba-aa3b-44aa-8a91-cfcef73c4c1f"
      "insufficient_data_health_status" = ""
      "invert_healthcheck"              = false
      "ip_address"                      = "3.12.193.41"
      "measure_latency"                 = false
      "port"                            = 443
      "regions"                         = []
      "request_interval"                = 30
      "resource_path"                   = "/healthcheck"
      "search_string"                   = ""
      "tags" = {
        "Name" = "prod_secondary_env_dev"
      }
      "type" = "HTTPS"
    }
  }
}