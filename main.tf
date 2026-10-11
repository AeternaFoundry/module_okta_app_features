resource "okta_app_features" "app_features" {
  for_each = var.app_features

  app_id      = each.value.app_id
  name        = each.value.name
  description = each.value.description
  status      = each.value.status

  dynamic "capabilities" {
    for_each = each.value.capabilities != null ? each.value.capabilities : []
    content {
      dynamic "create" {
        for_each = capabilities.value.create != null ? capabilities.value.create : []
        content {
          dynamic "lifecycle_create" {
            for_each = create.value.lifecycle_create != null ? create.value.lifecycle_create : []
            content {
              status = lifecycle_create.value.status
            }
          }
        }
      }
      dynamic "import_rules" {
        for_each = capabilities.value.import_rules != null ? capabilities.value.import_rules : []
        content {
          dynamic "user_create_and_match" {
            for_each = import_rules.value.user_create_and_match != null ? import_rules.value.user_create_and_match : []
            content {
              allow_partial_match       = user_create_and_match.value.allow_partial_match
              auto_activate_new_users   = user_create_and_match.value.auto_activate_new_users
              autoconfirm_exact_match   = user_create_and_match.value.autoconfirm_exact_match
              autoconfirm_new_users     = user_create_and_match.value.autoconfirm_new_users
              autoconfirm_partial_match = user_create_and_match.value.autoconfirm_partial_match
              exact_match_criteria      = user_create_and_match.value.exact_match_criteria
            }
          }
        }
      }
      dynamic "import_settings" {
        for_each = capabilities.value.import_settings != null ? capabilities.value.import_settings : []
        content {
          dynamic "schedule" {
            for_each = import_settings.value.schedule != null ? import_settings.value.schedule : []
            content {
              dynamic "full_import" {
                for_each = schedule.value.full_import != null ? schedule.value.full_import : []
                content {
                  expression = full_import.value.expression
                  timezone   = full_import.value.timezone
                }
              }
              dynamic "incremental_import" {
                for_each = schedule.value.incremental_import != null ? schedule.value.incremental_import : []
                content {
                  expression = incremental_import.value.expression
                  timezone   = incremental_import.value.timezone
                }
              }
              status = schedule.value.status
            }
          }
          dynamic "username" {
            for_each = import_settings.value.username != null ? import_settings.value.username : []
            content {
              username_expression = username.value.username_expression
              username_format     = username.value.username_format
            }
          }
        }
      }
      dynamic "update" {
        for_each = capabilities.value.update != null ? capabilities.value.update : []
        content {
          dynamic "lifecycle_deactivate" {
            for_each = update.value.lifecycle_deactivate != null ? update.value.lifecycle_deactivate : []
            content {
              status = lifecycle_deactivate.value.status
            }
          }
          dynamic "password" {
            for_each = update.value.password != null ? update.value.password : []
            content {
              change = password.value.change
              seed   = password.value.seed
              status = password.value.status
            }
          }
          dynamic "profile" {
            for_each = update.value.profile != null ? update.value.profile : []
            content {
              status = profile.value.status
            }
          }
        }
      }
    }
  }
}

