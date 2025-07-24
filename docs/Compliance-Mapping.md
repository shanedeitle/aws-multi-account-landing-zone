
# Compliance Mapping – AWS Multi-Account Secure Landing Zone

## Overview
This document maps the implemented controls in the **AWS Multi-Account Landing Zone** to the **CIS AWS Foundations Benchmark** and **NIST SP 800-53 Rev. 5**.  
This mapping demonstrates how the landing zone enforces compliance with industry best practices for cloud governance and security.

---

## 1. CIS AWS Foundations Benchmark Mapping

| CIS Control ID | Control Description                              | Implementation in Landing Zone         |
|----------------|--------------------------------------------------|---------------------------------------|
| 1.1           | Avoid the use of the root account                | SCP restricting root account actions.  |
| 1.2           | Ensure multi-factor authentication (MFA) is enabled for all IAM users | IAM policy enforces MFA for all IAM users with console access. |
| 2.1           | Ensure CloudTrail is enabled in all regions      | Organization-wide CloudTrail with SCP enforcement. |
| 2.2           | Ensure CloudTrail log files are encrypted        | Logs encrypted using KMS in the Log Archive Account. |
| 2.3           | Ensure CloudTrail logs are stored in a centralized S3 bucket | Centralized Log Archive Account with strict access policies. |
| 3.1           | Ensure no security groups allow unrestricted SSH access | Config rules monitor for open security groups. |
| 3.2           | Ensure VPC flow logging is enabled               | VPC flow logs enabled across all workload accounts. |
| 4.1           | Restrict use of unapproved regions               | SCP denies resource creation in non-approved regions. |

---

## 2. NIST SP 800-53 Rev. 5 Mapping

| NIST Control ID | Control Description                            | Implementation in Landing Zone         |
|-----------------|------------------------------------------------|---------------------------------------|
| AC-2           | Account Management                              | AWS Organizations manages accounts with OU-level SCPs. |
| AC-6           | Least Privilege                                 | IAM roles and SCPs enforce least-privilege access. |
| AU-2           | Audit Events                                    | CloudTrail configured for organization-wide logging. |
| AU-6           | Audit Review, Analysis, and Reporting           | Logs aggregated in Log Archive Account for centralized review. |
| CA-7           | Continuous Monitoring                           | AWS Config and Security Hub provide continuous compliance monitoring. |
| CM-6           | Configuration Settings                          | Config rules enforce secure configurations (CIS benchmark). |
| IR-4           | Incident Handling                               | GuardDuty alerts aggregated in Security Account for response workflows. |
| SC-13          | Cryptographic Protection                        | KMS-encrypted S3 buckets and EBS volumes for data at rest. |
| SI-4           | Information System Monitoring                   | GuardDuty and Security Hub detect and alert on suspicious activity. |

---

## References
- [CIS AWS Foundations Benchmark](https://www.cisecurity.org/benchmark/amazon_web_services)
- [NIST SP 800-53 Rev. 5](https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final)
- [AWS Security Hub Compliance Standards](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards.html)
