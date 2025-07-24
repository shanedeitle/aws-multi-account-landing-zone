# Security Policy

## Reporting Security Issues
If you discover a security issue or vulnerability in this project or its associated AWS configurations:

1. **Do NOT create a public GitHub issue.**
2. **Privately contact the repository owner** via LinkedIn or direct email (if provided).
3. Include:
   - A detailed description of the issue.
   - Steps to reproduce (if applicable).
   - Any potential impact.

The repository owner will acknowledge receipt within **3 business days** and coordinate further communication.

---

## Responsible Disclosure
We ask that you:
- **Avoid publicly disclosing** the issue until a resolution or mitigation is confirmed.
- **Act in good faith** to prevent harm to users, systems, or data.
- **Do not attempt to exploit** any vulnerability for unauthorized access or disruption.

---

## Security Best Practices in This Project
This project is designed with:
- **AWS Organizations guardrails** via Service Control Policies (SCPs).
- **Centralized logging** using AWS CloudTrail, AWS Config, and a dedicated Log Archive account.
- **Threat detection** with GuardDuty and Security Hub.
- **IAM least privilege principles** for cross‑account roles.
- **Encryption enforcement** (KMS for S3 buckets, CloudTrail logs, and Config data).

---

## References
- [AWS Security Incident Response Guide](https://docs.aws.amazon.com/whitepapers/latest/aws-security-incident-response-guide/aws-security-incident-response-guide.pdf)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [CIS AWS Foundations Benchmark](https://www.cisecurity.org/benchmark/amazon_web_services)
