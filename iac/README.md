
# AWS Multi-Account Landing Zone – Infrastructure as Code

This folder contains **Terraform configurations** for deploying a **multi-account AWS landing zone** with **strong security guardrails**.  

It leverages **AWS Organizations**, **Service Control Policies (SCPs)**, and **CloudTrail** to enforce security and compliance across your AWS Organization.

---

## Features
- **AWS Organizations**:  
  - Creates an Organization with **4 Organizational Units (OUs)**:  
    - `Security`  
    - `Log Archive`  
    - `Sandbox`  
    - `Workloads`  

- **Service Control Policies (SCPs)**:  
  - **DenyDisableCloudTrail** → Prevents disabling or deleting CloudTrail.  
  - **DenyPublicS3** → Blocks creation of public S3 buckets or policies.  
  - **EnforceKMSForS3** → Requires S3 buckets and objects to use **KMS encryption**.  
  - **RestrictRegions** → Restricts AWS resource creation to approved regions.  

- **Organization-wide CloudTrail**:  
  - Enables a **multi-region, organization-wide CloudTrail**.  
  - Logs stored in an **S3 bucket** (encrypted).  

---

## Folder Structure
```
/iac
  ├── main.tf                 # Primary Terraform configuration
  ├── variables.tf            # Configurable variables (OU names, bucket names, policy paths)
  ├── policies/               # Service Control Policy JSON documents
  │    ├── DenyDisableCloudTrail.json
  │    ├── DenyPublicS3.json
  │    ├── EnforceKMSForS3.json
  │    └── RestrictRegions.json
```

---

## Prerequisites
- AWS CLI configured with **AdministratorAccess** on the **Management Account**.  
- Terraform >= **1.5.0** installed.  
- An existing **S3 bucket** for CloudTrail logs (or adjust `cloudtrail_bucket_name` in `variables.tf`).

---

## Usage
1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Review the execution plan**:
   ```bash
   terraform plan
   ```

3. **Apply the configuration**:
   ```bash
   terraform apply
   ```

---

## Configurable Variables

Edit `variables.tf` to adjust the following values:

### Organizational Unit Names
```hcl
variable "ou_security_name" {
  description = "Name for the Security OU"
  default     = "Security"
}
variable "ou_log_archive_name" {
  description = "Name for the Log Archive OU"
  default     = "LogArchive"
}
variable "ou_sandbox_name" {
  description = "Name for the Sandbox OU"
  default     = "Sandbox"
}
variable "ou_workloads_name" {
  description = "Name for the Workloads OU"
  default     = "Workloads"
}
```

### CloudTrail Bucket Name
```hcl
variable "cloudtrail_bucket_name" {
  description = "S3 bucket name for organization-wide CloudTrail logs"
  default     = "org-cloudtrail-logs"
}
```

### Service Control Policy File Paths
```hcl
variable "scp_deny_disable_cloudtrail_file" {
  description = "Path to the DenyDisableCloudTrail SCP JSON file"
  default     = "${path.module}/policies/DenyDisableCloudTrail.json"
}
variable "scp_deny_public_s3_file" {
  description = "Path to the DenyPublicS3 SCP JSON file"
  default     = "${path.module}/policies/DenyPublicS3.json"
}
```

---

## Outputs

After running `terraform apply`, the following values will be displayed:

- **Organization ID** – The AWS Organization ID.
- **OU IDs** – A map of the created Organizational Units and their AWS-assigned IDs:
  - Security OU
  - Log Archive OU
  - Sandbox OU
  - Workloads OU

---

## Next Steps

- **Add More SCPs**  
  Expand the `/policies` folder with additional Service Control Policies (e.g., deny root account usage, enforce IAM MFA).

- **Automate Account Creation**  
  Use `aws_organizations_account` resources to automatically provision new accounts within each OU.

- **Integrate GuardDuty & Security Hub**  
  Delegate admin access to the Security account for centralized detection and compliance management.

- **Centralize Logging**  
  Forward CloudTrail and AWS Config logs to an SIEM or log management platform.

---

## References

- [AWS Organizations Documentation](https://docs.aws.amazon.com/organizations/)
- [AWS Service Control Policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html)
- [CIS AWS Foundations Benchmark](https://www.cisecurity.org/benchmark/amazon_web_services)
