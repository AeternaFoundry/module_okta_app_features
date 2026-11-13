variable "app_features" {
  description = <<EOT
Map of app_features, attributes below
Required:
    - app_id
    - name
Optional:
    - description
    - status
    - capabilities (block):
        - create (optional, block):
            - lifecycle_create (optional, block):
                - status (optional)
        - import_rules (optional, block):
            - user_create_and_match (optional, block):
                - allow_partial_match (optional)
                - auto_activate_new_users (optional)
                - autoconfirm_exact_match (optional)
                - autoconfirm_new_users (optional)
                - autoconfirm_partial_match (optional)
                - exact_match_criteria (optional)
        - import_settings (optional, block):
            - schedule (optional, block):
                - full_import (optional, block):
                    - expression (optional)
                    - timezone (optional)
                - incremental_import (optional, block):
                    - expression (optional)
                    - timezone (optional)
                - status (optional)
            - username (optional, block):
                - username_expression (optional)
                - username_format (optional)
        - update (optional, block):
            - lifecycle_deactivate (optional, block):
                - status (optional)
            - password (optional, block):
                - change (optional)
                - seed (optional)
                - status (optional)
            - profile (optional, block):
                - status (optional)
EOT

  type = map(object({
    app_id      = string
    name        = string
    description = optional(string)
    status      = optional(string)
    capabilities = optional(list(object({
      create = optional(list(object({
        lifecycle_create = optional(list(object({
          status = optional(string)
        })))
      })))
      import_rules = optional(list(object({
        user_create_and_match = optional(list(object({
          allow_partial_match       = optional(bool)
          auto_activate_new_users   = optional(bool)
          autoconfirm_exact_match   = optional(bool)
          autoconfirm_new_users     = optional(bool)
          autoconfirm_partial_match = optional(bool)
          exact_match_criteria      = optional(string)
        })))
      })))
      import_settings = optional(list(object({
        schedule = optional(list(object({
          full_import = optional(list(object({
            expression = optional(string)
            timezone   = optional(string)
          })))
          incremental_import = optional(list(object({
            expression = optional(string)
            timezone   = optional(string)
          })))
          status = optional(string)
        })))
        username = optional(list(object({
          username_expression = optional(string)
          username_format     = optional(string)
        })))
      })))
      update = optional(list(object({
        lifecycle_deactivate = optional(list(object({
          status = optional(string)
        })))
        password = optional(list(object({
          change = optional(string)
          seed   = optional(string)
          status = optional(string)
        })))
        profile = optional(list(object({
          status = optional(string)
        })))
      })))
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.app_features : (
        contains(["USER_PROVISIONING", "INBOUND_PROVISIONING"], v.name)
      )
    ])
    error_message = "must be one of: \"USER_PROVISIONING\", \"INBOUND_PROVISIONING\""
  }
  validation {
    condition = alltrue([
      for k, v in var.app_features : (
        v.status == null || (contains(["DISABLED", "ENABLED"], v.status))
      )
    ])
    error_message = "must be one of: \"DISABLED\", \"ENABLED\""
  }
  validation {
    condition = alltrue([
      for k, v in var.app_features : (
        v.capabilities == null || alltrue([for item in v.capabilities : (item.create == null || alltrue([for item in item.create : (item.lifecycle_create == null || alltrue([for item in item.lifecycle_create : (item.status == null || (contains(["DISABLED", "ENABLED"], item.status)))]))]))])
      )
    ])
    error_message = "must be one of: \"DISABLED\", \"ENABLED\""
  }
  validation {
    condition = alltrue([
      for k, v in var.app_features : (
        v.capabilities == null || alltrue([for item in v.capabilities : (item.update == null || alltrue([for item in item.update : (item.lifecycle_deactivate == null || alltrue([for item in item.lifecycle_deactivate : (item.status == null || (contains(["DISABLED", "ENABLED"], item.status)))]))]))])
      )
    ])
    error_message = "must be one of: \"DISABLED\", \"ENABLED\""
  }
  validation {
    condition = alltrue([
      for k, v in var.app_features : (
        v.capabilities == null || alltrue([for item in v.capabilities : (item.update == null || alltrue([for item in item.update : (item.password == null || alltrue([for item in item.password : (item.change == null || (contains(["CHANGE", "KEEP_EXISTING"], item.change)))]))]))])
      )
    ])
    error_message = "must be one of: \"CHANGE\", \"KEEP_EXISTING\""
  }
  validation {
    condition = alltrue([
      for k, v in var.app_features : (
        v.capabilities == null || alltrue([for item in v.capabilities : (item.update == null || alltrue([for item in item.update : (item.password == null || alltrue([for item in item.password : (item.seed == null || (contains(["OKTA", "RANDOM"], item.seed)))]))]))])
      )
    ])
    error_message = "must be one of: \"OKTA\", \"RANDOM\""
  }
  validation {
    condition = alltrue([
      for k, v in var.app_features : (
        v.capabilities == null || alltrue([for item in v.capabilities : (item.update == null || alltrue([for item in item.update : (item.password == null || alltrue([for item in item.password : (item.status == null || (contains(["DISABLED", "ENABLED"], item.status)))]))]))])
      )
    ])
    error_message = "must be one of: \"DISABLED\", \"ENABLED\""
  }
  validation {
    condition = alltrue([
      for k, v in var.app_features : (
        v.capabilities == null || alltrue([for item in v.capabilities : (item.update == null || alltrue([for item in item.update : (item.profile == null || alltrue([for item in item.profile : (item.status == null || (contains(["DISABLED", "ENABLED"], item.status)))]))]))])
      )
    ])
    error_message = "must be one of: \"DISABLED\", \"ENABLED\""
  }
  validation {
    condition = alltrue([
      for k, v in var.app_features : (
        v.capabilities == null || alltrue([for item in v.capabilities : (item.import_settings == null || alltrue([for item in item.import_settings : (item.schedule == null || alltrue([for item in item.schedule : (item.status == null || (contains(["DISABLED", "ENABLED"], item.status)))]))]))])
      )
    ])
    error_message = "must be one of: \"DISABLED\", \"ENABLED\""
  }
}

