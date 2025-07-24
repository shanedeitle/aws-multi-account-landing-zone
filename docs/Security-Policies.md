
# AWS Landing Zone Security Policies

## Overview
This document summarizes the **Service Control Policies (SCPs)**, **IAM policies**, and **security guardrails** implemented in the AWS multi-account landing zone.  
These policies enforce compliance, improve security posture, and align with the **CIS AWS Foundations Benchmark** and **NIST SP 800-53**.

---

## 1. Service Control Policies (SCPs)
SCPs are attached to **Organizational Units (OUs)** to enforce mandatory guardrails across all accounts.

### **Baseline SCPs**
- **Enforce CloudTrail Logging**
  - Deny disabling CloudTrail in any account.
- **Deny Public S3 Buckets**
  - Prevent the creation of publicly accessible S3 buckets.
- **Restrict Root Account Usage**
  - Deny all actions by the root user except for explicitly allowed break-glass scenarios.
- **Restrict Unapproved Regions**
  - Deny launching resources in non-approved AWS regions.

### **Environment-Specific SCPs**
- **Production OU:**
  - Deny all IAM policy modifications not approved by the Security team.
  - Enforce encryption (KMS) on all new S3 buckets and EBS volumes.
- **Development/Test OUs:**
  - Limit IAM privilege escalation by restricting `iam:PassRole` and `iam:CreatePolicy` actions.

---

## 2. IAM Policies
IAM policies are applied at the **account level** for cross-account roles and access management.

### **Cross-Account Roles**
- **SecurityAuditRole:**
  - Provides read-only access for Security Account to review resource configurations.
- **DevOpsRole:**
  - Grants least-privilege access to deploy and manage resources in workload accounts.

### **MFA Enforcement**
- Mandatory MFA for all IAM users with console access.
- Conditional access policies require MFA for privileged actions.

---

## 3. Logging & Monitoring Policies
- **CloudTrail:**
  - Organization-wide logging with encryption (KMS) enabled.
- **AWS Config:**
  - Enforce CIS benchmark rules (e.g., no unencrypted volumes, IAM key rotation).
- **GuardDuty & Security Hub:**
  - Aggregated findings in the Security Account for incident response.

---

## 4. Tagging Policies
- **Mandatory Tags:** `Owner`, `Environment`, `Project`.
- **Enforced with Tagging Policies:** Prevent creation of untagged resources.

---

## References
- [AWS Organizations SCP Documentation](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html)
- [CIS AWS Foundations Benchmark](https://www.cisecurity.org/benchmark/amazon_web_services)
- [NIST SP 800-53 Rev. 5](https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final)
