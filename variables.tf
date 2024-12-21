variable "version" {
  default = "v1.0.0"
}

variable "aws_region" {
  default = "ap-south-1"
}

output "deployed_version" {
  value = var.version
}
