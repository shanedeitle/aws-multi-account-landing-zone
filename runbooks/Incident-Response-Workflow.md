# Incident Response Workflow
*Runbook for Security Incidents in the AWS Multi-Account Landing Zone*

---

## Purpose
This runbook outlines the **step-by-step process** for detecting, investigating, and remediating security incidents across the AWS Organization. It ensures a **coordinated response** and helps preserve evidence for forensic analysis.

---

## Incident Categories
Incidents are classified as:
- **Critical** – Data breach, ransomware, root account compromise, or persistent threat actor activity.
- **High** – Unauthorized IAM role usage, GuardDuty high-severity findings, or exfiltration attempts.
- **Medium** – Misconfigurations, failed login attempts, or suspicious API activity.
- **Low** – Minor policy violations, informational GuardDuty findings.

---

## Roles & Responsibilities
- **Incident Commander (IC):** Leads the response effort. Usually the SOC Manager or senior security engineer.
- **Security Analyst:** Investigates alerts, collects evidence, and recommends actions.
- **Account Owners:** Provide context and approve account-level remediations.
- **Forensics Team:** Performs deep analysis and evidence preservation for critical incidents.
- **Communications Lead:** Manages internal/external reporting and compliance notifications.

---

## Workflow

### 1. **Detection & Notification**
- Alerts triggered by:
  - **Amazon GuardDuty** (threat findings).
  - **AWS Security Hub** (aggregated findings).
  - **CloudTrail & AWS Config** anomalies.
  - **SIEM / SOC** monitoring.
- Notifications sent via **SNS topics** to Security team & Incident Commander.

---

### 2. **Triage & Classification**
- Determine **severity** (Critical, High, Medium, Low).
- Validate the finding to eliminate false positives.
- Assign an **Incident Ticket** in the tracking system (e.g., JIRA, ServiceNow).

---

### 3. **Containment**
- **Short-term:**  
  - Disable compromised IAM keys or sessions.
  - Isolate affected EC2 instances (security group lockdown or quarantine VPC).
- **Long-term:**  
  - Apply SCPs to prevent policy violations.
  - Block suspicious IPs at the WAF or firewall level.

---

### 4. **Investigation**
- Collect logs:
  - **CloudTrail** (API activity).
  - **VPC Flow Logs** (network traffic).
  - **AWS Config** (resource change history).
- Capture affected instance snapshots (AMI + EBS).
- Correlate data across **GuardDuty**, **Security Hub**, and **SIEM**.
- Document all findings in the incident ticket.

---

### 5. **Eradication & Remediation**
- Remove compromised resources or backdoors.
- Patch vulnerabilities.
- Rotate IAM credentials or enforce MFA.
- Restore systems from known-good snapshots.

---

### 6. **Recovery**
- Return resources to production.
- Validate service integrity.
- Monitor for recurring indicators of compromise.

---

### 7. **Post-Incident Review**
- Conduct a **post-mortem**:
  - Root cause analysis.
  - Lessons learned.
  - Policy/procedure updates.
- Update **SCPs**, **IAM policies**, or **CloudWatch alarms** to prevent recurrence.

---

## Evidence Handling
- All evidence (logs, snapshots, exports) must be:
  - Collected in the **Log Archive Account**.
  - Stored in an **S3 bucket with KMS encryption**.
  - Tagged with `IncidentID` for tracking.
  - Access-controlled (Security & Forensics teams only).

---

## Communication Protocol
- **Critical incidents:** Notify **CISO** and senior leadership immediately.
- **Regulatory incidents:** Compliance team coordinates external notifications (per GDPR, HIPAA, etc.).
- All communications documented in the incident ticket.

---

## Automation Opportunities
- **Lambda Playbooks**: Auto-quarantine compromised EC2s.
- **SSM Documents**: Rapid credential rotation.
- **Security Hub Custom Actions**: One-click incident response workflows.

---

## References
- [AWS Security Incident Response Guide](https://docs.aws.amazon.com/whitepapers/latest/aws-security-incident-response-guide/aws-security-incident-response-guide.pdf)
- [NIST 800-61 Computer Security Incident Handling Guide](https://csrc.nist.gov/publications/detail/sp/800-61/rev-2/final)
