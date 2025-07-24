
# AWS Multi-Account Landing Zone

This repository contains a **secure, scalable AWS multi-account landing zone** built with **Terraform** and supported by **operational runbooks** and **governance policies**.  

It demonstrates expertise in **cloud security architecture**, **infrastructure as code (IaC)**, and **enterprise-grade AWS governance**.

---

## Repository Highlights

- **Infrastructure as Code (IaC):**  
  - Terraform configurations for AWS Organizations, Service Control Policies (SCPs), and organization-wide CloudTrail.

- **Service Control Policies (SCPs):**  
  - Guardrails to enforce encryption, prevent public access, protect CloudTrail, and restrict regions.

- **Operational Runbooks:**  
  - Standardized workflows for incident response, disaster recovery, SCP change management, and account onboarding.

- **Security Architecture:**  
  - Multi-account design aligned with AWS best practices and the Well-Architected Framework.

- **Documentation:**  
  - Architecture overview, security reporting guidelines, and detailed operational guides.

---

## Folder Structure
```
.
├── iac/                      # Terraform for AWS Organizations, SCPs, and CloudTrail
├── runbooks/                 # Operational runbooks for IR, DR, SCP changes, etc.
├── policies/                 # SCP and IAM policy JSON documents
├── diagrams/                 # Architecture and workflow diagrams
├── SECURITY.md               # Security reporting guidelines
├── ARCHITECTURE.md           # Architectural design and rationale
└── README.md                 # This file
```

---

## Key Features

- **AWS Organizations & OUs**:  
  - Root, Security, Log Archive, Sandbox, and Workloads OUs.

- **Service Control Policies (SCPs)**:  
  - **Deny Public S3**: Prevents public bucket policies.  
  - **Require CloudTrail**: Prevents disabling/deleting CloudTrail.  
  - **Enforce KMS for S3**: Requires server-side encryption for S3.  
  - **Restrict Regions**: Limits AWS resource creation to approved regions.

- **Centralized Logging**:  
  - Multi-region CloudTrail logs stored in a dedicated Log Archive account.

- **Threat Detection & Compliance**:  
  - GuardDuty & Security Hub centralized in the Security account.  
  - AWS Config for resource compliance tracking.

- **Disaster Recovery & Incident Response**:  
  - Runbooks for DR, IR, and SCP change management.  
  - Multi-region failover and immutable log storage.

---

## Getting Started

### Prerequisites
- AWS CLI configured with **AdministratorAccess** on the **Management Account**.
- Terraform **v1.5.0 or later** installed.
- S3 bucket for CloudTrail logs (adjust `variables.tf` if needed).

### Deploying the Landing Zone
1. Navigate to the IaC folder:
   ```bash
   cd iac
   ```
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Review and apply the configuration:
   ```bash
   terraform plan
   terraform apply
   ```

---

## Documentation

- [**Architecture**](./ARCHITECTURE.md) – Rationale behind the landing zone design.
- [**Security Policy**](./SECURITY.md) – How to report security issues.
- [**Infrastructure as Code**](./iac/README_iac.md) – Terraform configurations for AWS Organizations and guardrails.
- [**Runbooks**](./runbooks/) – Standard operating procedures for incidents, DR, and account management.
- [**Policies**](./policies/) – JSON SCPs and IAM role definitions.

---

## Diagrams
- **Multi-Account Architecture** – Organizational structure of AWS accounts.  
- **Logging & Data Flow** – Centralized CloudTrail and GuardDuty logging.  
- **SCP Organization Chart** – Visual mapping of SCP attachments across OUs.  
- **Disaster Recovery Workflow** – Steps for handling AWS region/service outages.

*(Diagrams located in the `/diagrams` folder.)*

---

## Why This Project Matters
This repository reflects **real-world enterprise AWS security architecture** with:
- **Multi-account strategy** for isolation and governance.
- **Defense in depth** using SCPs, IAM controls, and centralized security services.
- **Operational maturity** with documented runbooks and response workflows.
- **Infrastructure as Code** for versioned, auditable, and repeatable deployments.

This is the kind of setup used by **Fortune 500 companies** and organizations in **regulated industries** (finance, healthcare, etc.).

---

## References
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [AWS Organizations Documentation](https://docs.aws.amazon.com/organizations/)
- [AWS Security Incident Response Guide](https://docs.aws.amazon.com/whitepapers/latest/aws-security-incident-response-guide/aws-security-incident-response-guide.pdf)
- [CIS AWS Foundations Benchmark](https://www.cisecurity.org/benchmark/amazon_web_services)

---

**Author:** Shane Deitle  
**LinkedIn:** [https://www.linkedin.com/in/deitle/](https://www.linkedin.com/in/deitle/)  
**GitHub:** [https://github.com/shanedeitle/](https://github.com/shanedeitle/)
