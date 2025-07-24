#########################
# Provider
#########################
provider "aws" {
  region = "us-east-1"
}

#########################
# AWS Organization
#########################
resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
}

#########################
# Organizational Units
#########################
resource "aws_organizations_organizational_unit" "security" {
  name      = var.ou_security_name
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "log_archive" {
  name      = var.ou_log_archive_name
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "sandbox" {
  name      = var.ou_sandbox_name
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "workloads" {
  name      = var.ou_workloads_name
  parent_id = aws_organizations_organization.org.roots[0].id
}

#########################
# Service Control Policies (SCPs)
#########################

# Deny disabling CloudTrail
resource "aws_organizations_policy" "deny_disable_cloudtrail" {
  name        = "DenyDisableCloudTrail"
  description = "Prevents disabling CloudTrail in any account"
  type        = "SERVICE_CONTROL_POLICY"
  content     = file(var.scp_deny_disable_cloudtrail_file)
}

# Deny public S3 buckets
resource "aws_organizations_policy" "deny_public_s3" {
  name        = "DenyPublicS3"
  description = "Prevents creating public S3 buckets"
  type        = "SERVICE_CONTROL_POLICY"
  content     = file("${path.module}/policies/DenyPublicS3.json")
}

# Enforce KMS encryption for S3
resource "aws_organizations_policy" "enforce_kms_for_s3" {
  name        = "EnforceKMSForS3"
  description = "Requires KMS encryption for S3 buckets and objects"
  type        = "SERVICE_CONTROL_POLICY"
  content     = file("${path.module}/policies/EnforceKMSForS3.json")
}

# Restrict resource creation to approved regions
resource "aws_organizations_policy" "restrict_regions" {
  name        = "RestrictRegions"
  description = "Restricts resource creation to approved AWS regions"
  type        = "SERVICE_CONTROL_POLICY"
  content     = file("${path.module}/policies/RestrictRegions.json")
}

#########################
# Attach SCPs
#########################

# Attach global guardrails at the Root
resource "aws_organizations_policy_attachment" "attach_deny_cloudtrail_root" {
  policy_id = aws_organizations_policy.deny_disable_cloudtrail.id
  target_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_policy_attachment" "attach_restrict_regions_root" {
  policy_id = aws_organizations_policy.restrict_regions.id
  target_id = aws_organizations_organization.org.roots[0].id
}

# Attach logging/security guardrails to Log Archive
resource "aws_organizations_policy_attachment" "attach_deny_public_s3_log_archive" {
  policy_id = aws_organizations_policy.deny_public_s3.id
  target_id = aws_organizations_organizational_unit.log_archive.id
}

resource "aws_organizations_policy_attachment" "attach_enforce_kms_log_archive" {
  policy_id = aws_organizations_policy.enforce_kms_for_s3.id
  target_id = aws_organizations_organizational_unit.log_archive.id
}

#########################
# Organization-wide CloudTrail
#########################
resource "aws_cloudtrail" "org_trail" {
  name                          = "organization-trail"
  s3_bucket_name                = var.cloudtrail_bucket_name
  include_global_service_events = true
  is_multi_region_trail         = true
  is_organization_trail         = true
}

#########################
# Outputs
#########################
output "organization_id" {
  value = aws_organizations_organization.org.id
}

output "ou_ids" {
  value = {
    security    = aws_organizations_organizational_unit.security.id
    log_archive = aws_organizations_organizational_unit.log_archive.id
    sandbox     = aws_organizations_organizational_unit.sandbox.id
    workloads   = aws_organizations_organizational_unit.workloads.id
  }
}
