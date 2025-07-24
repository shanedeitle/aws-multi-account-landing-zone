
# AWS Account Onboarding Runbook

## Overview
This runbook provides step-by-step instructions for onboarding new AWS accounts into the **multi-account secure landing zone**. It ensures consistency, compliance, and security alignment across all environments.

---

## 1. Prerequisites
- AWS Organizations Administrator Access in the **Management Account**.
- Service Control Policies (SCPs) predefined and stored in the **/policies** repository.
- AWS IAM Identity Center (SSO) configured with corporate IdP.
- Centralized logging and monitoring enabled (CloudTrail, Config, GuardDuty, Security Hub).

---

## 2. Create a New Account
1. Log in to the **Management Account**.
2. Navigate to **AWS Organizations** → **Accounts** → **Add an AWS Account**.
3. Provide:
   - **Account Name:** (e.g., `Dev-ProjectX`)
   - **Email Address:** (unique, corporate-managed email)
   - **IAM Role Name:** `OrganizationAccountAccessRole`
4. Assign the account to the appropriate **Organizational Unit (OU)** (e.g., Dev, Test, Prod).

---

## 3. Apply Service Control Policies (SCPs)
1. In **AWS Organizations**, go to **Policies** → **Service Control Policies**.
2. Attach the appropriate SCPs to the new account OU:
   - **Baseline Guardrails** (CloudTrail, MFA, restricted regions).
   - **Environment-Specific Policies** (e.g., deny public S3 in Prod).
3. Verify policies by running `aws organizations list-policies-for-target`.

---

## 4. Configure IAM Identity Center (SSO)
1. Add the new account to the IAM Identity Center application.
2. Assign roles to users/groups (e.g., Admin, ReadOnly, DevOps).
3. Verify access by logging in through the SSO portal.

---

## 5. Enable Logging & Monitoring
1. Configure **CloudTrail** to deliver logs to the centralized **Log Archive Account**.
2. Enable **AWS Config** with organization-wide rules.
3. Verify that **GuardDuty** and **Security Hub** findings are aggregated to the **Security Account**.

---

## 6. Account Tagging
1. Apply mandatory tags:
   - `Owner`: Team or Business Unit
   - `Environment`: Dev/Test/Prod
   - `Project`: Project Name
2. Use tagging policies to enforce compliance.

---

## 7. Validation
- Run AWS Config compliance reports.
- Validate SCP enforcement with sample actions.
- Confirm access via IAM Identity Center.

---

## 8. Documentation
- Update the **Account Inventory** in `/docs/Account-Inventory.md`.
- Record the account owner and access levels.

---

## References
- [AWS Organizations Documentation](https://docs.aws.amazon.com/organizations/)
- [AWS Control Tower Documentation](https://docs.aws.amazon.com/controltower/)
- [CIS AWS Foundations Benchmark](https://www.cisecurity.org/benchmark/amazon_web_services)
