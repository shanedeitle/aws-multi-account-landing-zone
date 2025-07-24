#########################
# Organizational Units
#########################
variable "ou_security_name" {
  description = "Name for the Security OU"
  type        = string
  default     = "Security"
}

variable "ou_log_archive_name" {
  description = "Name for the Log Archive OU"
  type        = string
  default     = "LogArchive"
}

variable "ou_sandbox_name" {
  description = "Name for the Sandbox OU"
  type        = string
  default     = "Sandbox"
}

variable "ou_workloads_name" {
  description = "Name for the Workloads OU"
  type        = string
  default     = "Workloads"
}

#########################
# CloudTrail
#########################
variable "cloudtrail_bucket_name" {
  description = "S3 bucket name for organization-wide CloudTrail logs"
  type        = string
  default     = "org-cloudtrail-logs"
}

#########################
# Service Control Policies
#########################
variable "scp_deny_disable_cloudtrail_file" {
  description = "Path to the DenyDisableCloudTrail SCP JSON file"
  type        = string
  default     = "${path.module}/policies/DenyDisableCloudTrail.json"
}

variable "scp_deny_public_s3_file" {
  description = "Path to the DenyPublicS3 SCP JSON file"
  type        = string
  default     = "${path.module}/policies/DenyPublicS3.json"
}
