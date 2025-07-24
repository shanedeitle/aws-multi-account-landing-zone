# Security Operations Daily Checklist
*Daily tasks for monitoring and maintaining security in the AWS Multi-Account Landing Zone*

---

## Purpose
This checklist ensures that the Security team performs **daily operational tasks** to maintain the security and compliance posture of the AWS multi-account landing zone.  

It supports **early detection of threats**, **compliance enforcement**, and **operational consistency**.

---

## Roles & Responsibilities
- **Security Analyst (Daily Operator):** Executes the checklist tasks and documents findings.
- **SOC Lead:** Reviews escalations and approves remediation steps.
- **Cloud Platform Team:** Assists with cross-account issues and remediations.

---

## Daily Checklist

### 1. **Monitor Security Alerts**
- **AWS GuardDuty**:
  - Review all **High and Medium severity findings**.
  - Validate alerts (eliminate false positives).
  - Escalate confirmed threats to Incident Response.
- **AWS Security Hub**:
  - Check new findings.
  - Prioritize **CIS AWS Foundations Benchmark** and **PCI DSS** compliance alerts.
- **SIEM (if integrated)**:
  - Review dashboards for anomalous activity.

---

### 2. **Review IAM Activity**
- Use **IAM Access Analyzer** to detect new cross-account access.
- Check **CloudTrail** for:
  - Root account usage (must be reported immediately).
  - Unauthorized IAM policy changes.
  - Creation of new access keys or elevated privilege roles.
- Validate **IAM Identity Center (SSO)** access logs:
  - Look for unexpected logins or failed attempts.

---

### 3. **Audit Resource Changes**
- Review **AWS Config** for:
  - Non-compliant resource changes.
  - Critical configuration drifts (e.g., unencrypted S3 buckets, open security groups).
- Validate changes against **approved change tickets**.

---

### 4. **Check Logging & Monitoring Health**
- Verify:
  - **CloudTrail** is running across all accounts and regions.
  - Logs are delivered to the **Log Archive account**.
  - **CloudWatch Alarms** are active (no disabled alarms).
- Ensure **VPC Flow Logs** are capturing network activity in all production accounts.

---

### 5. **Tagging & Cost Anomalies**
- Confirm all new resources have **mandatory tags**:
  - `Owner`, `Environment`, `CostCenter`, `Project`.
- Review **Cost Explorer** for unusual spikes in daily spend (potential compromise or misconfiguration).

---

### 6. **Incident Escalation**
- For any high-severity findings:
  - Open a **ServiceNow/JIRA incident**.
  - Notify the **SOC Lead** and **Incident Commander**.
- Document all findings and actions taken in the **daily log**.

---

### 7. **End-of-Day Reporting**
- Summarize:
  - Alerts reviewed.
  - Incidents escalated.
  - Any anomalies observed.
- Submit the **daily security report** to the SOC Lead.

---

## Automation Opportunities
- **GuardDuty → Security Hub → SIEM Integration**:
  - Auto-forward findings for centralized correlation.
- **CloudWatch Event Rules**:
  - Auto-trigger notifications for root usage or critical IAM changes.
- **Daily Report Automation**:
  - Generate daily reports using **AWS Athena/QuickSight** dashboards.

---

## References
- [AWS GuardDuty Documentation](https://docs.aws.amazon.com/guardduty/)
- [AWS Security Hub Documentation](https://docs.aws.amazon.com/securityhub/)
- [AWS Well-Architected – Security Pillar](https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/welcome.html)
