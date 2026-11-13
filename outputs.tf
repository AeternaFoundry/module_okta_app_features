output "app_features_id" {
  description = "Map of id values across all app_features, keyed the same as var.app_features"
  value       = { for k, v in okta_app_features.app_features : k => v.id }
}
output "app_features_app_id" {
  description = "Map of app_id values across all app_features, keyed the same as var.app_features"
  value       = { for k, v in okta_app_features.app_features : k => v.app_id }
}
output "app_features_capabilities" {
  description = "Map of capabilities values across all app_features, keyed the same as var.app_features"
  value       = { for k, v in okta_app_features.app_features : k => v.capabilities }
}
output "app_features_description" {
  description = "Map of description values across all app_features, keyed the same as var.app_features"
  value       = { for k, v in okta_app_features.app_features : k => v.description }
}
output "app_features_name" {
  description = "Map of name values across all app_features, keyed the same as var.app_features"
  value       = { for k, v in okta_app_features.app_features : k => v.name }
}
output "app_features_status" {
  description = "Map of status values across all app_features, keyed the same as var.app_features"
  value       = { for k, v in okta_app_features.app_features : k => v.status }
}

