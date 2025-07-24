# New Account Onboarding Runbook
*Runbook for adding new AWS accounts to the AWS Multi-Account Landing Zone*

---

## Purpose
This runbook provides a **standardized process** for creating and onboarding new AWS accounts into the multi-account landing zone. It ensures **governance, security controls, and compliance** are applied consistently across all accounts.

---

## Roles & Responsibilities
- **Cloud Platform Team:** Provisions the account using AWS Organizations.
- **Security Team:** Ensures Service Control Policies (SCPs), GuardDuty, and Security Hub are enabled.
- **Account Owner:** Provides business justification and ongoing operational ownership.
- **Finance/Billing:** Adds account to the consolidated billing structure and cost reporting.

---

## Workflow

### 1. **Account Request & Approval**
- Request submitted via **ServiceNow/JIRA** with:
  - Business justification.
  - Environment (Dev, Test, Prod, Sandbox).
  - Owner contact information.
- Approval by:
  - **Cloud Governance Board** or **Security Lead**.

---

### 2. **Account Creation**
- Log in to the **AWS Management Account**.
- Create the account via **AWS Organizations**:
  - Navigate to **Organizations → Accounts → Add Account**.
  - Use **Create Account** for new accounts or **Invite Account** for existing ones.
- Assign the account to the appropriate **Organizational Unit (OU)**:
  - `Security`, `LogArchive`, `Sandbox`, `Workloads` (Dev/Test/Prod).

---

### 3. **Apply Service Control Policies (SCPs)**
- In **AWS Organizations**:
  - Attach baseline SCPs:
    - **DenyDisableCloudTrail**
    - **DenyPublicS3**
    - **EnforceKMSForS3**
    - **RestrictRegions**
- Apply OU-specific SCPs as needed (e.g., stricter policies for Prod vs Sandbox).

---

### 4. **Enable Baseline Security Services**
- **GuardDuty**:
  - Delegate management to the Security account.
  - Ensure GuardDuty is **enabled across all regions**.
- **Security Hub**:
  - Enable Security Hub in all regions.
  - Enable **CIS AWS Foundations** and **PCI DSS** standards (if applicable).
- **AWS Config**:
  - Enable recording for all supported resources.
  - Centralize delivery to the **Log Archive account**.

---

### 5. **CloudTrail & Logging**
- Ensure the **organization-wide CloudTrail** is active.
- Validate logs are delivered to the **centralized S3 bucket** in the Log Archive account.
- Enable **S3 bucket access logging** and **CloudWatch log forwarding** if applicable.

---

### 6. **Identity & Access Setup**
- Integrate the account with **AWS IAM Identity Center (SSO)**:
  - Assign groups based on **least privilege**.
  - Enforce **MFA for all users**.
- Review IAM roles and enforce **naming conventions**.

---

### 7. **Tagging & Cost Management**
- Apply mandatory tags:
  - `Owner`, `Environment`, `CostCenter`, `Project`.
- Configure account inclusion in **AWS Cost Explorer** and budget alerts.

---

### 8. **Validation & Handover**
- Validate:
  - SCPs are applied.
  - GuardDuty & Security Hub findings are visible in the Security account.
  - Logging to the centralized bucket is functioning.
- Document account details in the **Account Inventory**.
- Notify the **requestor and stakeholders** that the account is ready.

---

## Automation Opportunities
- **Terraform**: Automate account creation, OU placement, and SCP application.
- **Lambda**: Automatically enforce tagging and enable GuardDuty/Security Hub.
- **AWS Control Tower**: Streamline account vending with preconfigured guardrails.

---

## References
- [AWS Organizations Documentation](https://docs.aws.amazon.com/organizations/)
- [AWS Control Tower](https://docs.aws.amazon.com/controltower/)
- [AWS GuardDuty Documentation](https://docs.aws.amazon.com/guardduty/)
- [AWS Security Hub Documentation](https://docs.aws.amazon.com/securityhub/)
