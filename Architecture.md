# AWS Multi-Account Landing Zone Architecture

This project implements a **secure, scalable AWS multi-account landing zone** using **Infrastructure as Code** (Terraform) and AWS native services.

---

## Design Principles
- **Separation of duties**: Different accounts for Security, Logging, Sandbox, and Workloads.
- **Guardrails, not gates**: Enforce security through Service Control Policies (SCPs) while allowing developers flexibility within approved boundaries.
- **Centralized governance**: All accounts are managed under AWS Organizations with strict SCP inheritance.
- **Defense in depth**: Combine IAM controls, logging, threat detection, and encryption.

---

## Organizational Structure
- **Root**: Global SCPs and management guardrails.
- **Security OU**: Dedicated for security tooling (GuardDuty, Security Hub admin, SIEM integration).
- **Log Archive OU**: Stores immutable CloudTrail and Config logs.
- **Sandbox OU**: Isolated environment for development/testing.
- **Workloads OU**: Production and non-production environments for business applications.

---

## Service Control Policies (SCPs)
- **Deny Public S3**: Prevents public S3 buckets/policies.
- **Require CloudTrail**: Ensures logging cannot be disabled or deleted.
- **Enforce KMS for S3**: Requires server-side encryption using AWS KMS.
- **Restrict Regions**: Limits resource creation to approved AWS regions.

---

## Logging & Monitoring
- **CloudTrail**: Organization-wide, multi-region trails stored in the Log Archive account.
- **AWS Config**: Tracks configuration changes across all accounts.
- **GuardDuty & Security Hub**: Centralized threat detection and compliance findings in the Security account.

---

## Disaster Recovery & Incident Response
- **Runbooks**: Standardized workflows for incident response, disaster recovery, SCP changes, and account onboarding.
- **Multi-Region Strategy**: S3 replication and Route 53 failover support rapid recovery.
- **Forensics**: Immutable logs and EBS/RDS snapshot retention for investigations.

---

## Future Enhancements
- **Automation**:
  - Lambda-based GuardDuty onboarding for new accounts.
  - Automated SCP simulation and drift detection.
- **CI/CD Integration**:
  - Use CodePipeline or GitHub Actions for Terraform deployments.
- **SIEM Integration**:
  - Forward CloudTrail/GuardDuty data to Splunk, Elastic, or OpenSearch for advanced analytics.

---

## References
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [AWS Landing Zone Concepts](https://docs.aws.amazon.com/whitepapers/latest/landing-zone-on-aws/landing-zone-on-aws.html)
- [NIST 800-53 Security Controls](https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final)
