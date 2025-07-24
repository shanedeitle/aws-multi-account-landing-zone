# SCP Change Management Runbook
*Runbook for managing changes to Service Control Policies (SCPs) in the AWS Multi-Account Landing Zone*

---

## Purpose
This runbook defines the **governance process for modifying Service Control Policies (SCPs)** in the AWS multi-account landing zone. It ensures that **changes are reviewed, approved, and tested** to maintain organizational security and compliance.

---

## Scope
- Applies to all **SCPs** in the AWS Organization.
- Covers:
  - **Adding new SCPs**.
  - **Modifying existing SCPs**.
  - **Detaching or removing SCPs**.
- Excludes:
  - Changes to **IAM Policies** (handled separately).
  - Account-specific resource policies (outside SCP governance).

---

## Roles & Responsibilities
- **Requestor:** Submits the change request with business justification.
- **Cloud Governance Board (CGB):** Reviews and approves/rejects SCP changes.
- **Security Team:** Assesses security implications and performs risk analysis.
- **Cloud Platform Team:** Implements and validates changes in AWS Organizations.
- **Compliance Officer:** Ensures alignment with regulatory frameworks (e.g., CIS, NIST, PCI DSS).

---

## Workflow

### 1. **Request Submission**
- Submit change request via **ServiceNow/JIRA** with:
  - Business justification.
  - SCP name(s) impacted.
  - Proposed changes (with example JSON if applicable).
  - Accounts/OUs affected.
  - Risk assessment (initial).

### 2. **Review & Risk Assessment**
- Security Team reviews:
  - Security implications.
  - Compliance impact.
- Compliance Officer checks:
  - Alignment with regulatory and internal requirements.
- Cloud Governance Board evaluates overall impact.

### 3. **Approval**
- Cloud Governance Board (CGB) votes:
  - **Approve** (with or without conditions).
  - **Reject** (provide rationale).
- Critical changes require **CISO approval**.

### 4. **Testing (Pre-Deployment)**
- Apply the change in a **Sandbox OU**:
  - Validate that the SCP behaves as intended.
  - Confirm no disruption to critical services.
- Document test results.

### 5. **Deployment**
- Schedule deployment during a **maintenance window** (if needed).
- Apply changes using:
  - **AWS Console** → Organizations → Policies.
  - **Terraform** (preferred for version-controlled IaC).
- Verify successful attachment to the target OU(s) or root.

### 6. **Validation**
- Confirm:
  - SCP is enforced across intended accounts.
  - No unexpected access disruptions.
  - Logging and monitoring capture the change (CloudTrail events).
- Notify stakeholders that the change is complete.

### 7. **Post-Change Review**
- Document:
  - Date and time of change.
  - Approvals obtained.
  - Test results and lessons learned.
- Update **SCP Inventory** in the governance repository.
- Conduct **post-implementation review** for critical changes.

---

## Emergency Changes
- In case of a critical security incident (e.g., ongoing compromise):
  - **Bypass standard approval** with **Security Lead/CISO authorization**.
  - Apply SCP changes immediately.
  - Document and retroactively review within 24 hours.

---

## Automation Opportunities
- **Terraform for Version Control**:
  - All SCPs managed via IaC for auditable change tracking.
- **Change Notifications**:
  - Use **SNS/Slack notifications** for any SCP updates.
- **Pre-Change Simulation**:
  - Leverage **IAM Access Analyzer** to simulate SCP effects before deployment.

---

## References
- [AWS Service Control Policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps.html)
- [AWS Organizations Documentation](https://docs.aws.amazon.com/organizations/)
- [NIST 800-128: Guide for Security-Focused Configuration Management](https://csrc.nist.gov/publications/detail/sp/800-128/final)
