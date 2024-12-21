variable "version" {
  default = "v1.0.0"
}

output "deployed_version" {
  value = var.version
}
