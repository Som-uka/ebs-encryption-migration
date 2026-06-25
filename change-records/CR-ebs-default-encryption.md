# CR: Enable EBS Encryption by Default

| Field | Details |
|---|---|
| Change ID | CR-EBS-001 |
| Environment | Production |
| Risk Level | Low |
| Status | Complete |

## Description
Enabled account/region-level EBS encryption by default so every new volume is encrypted at rest without per-volume action.

## Steps Performed
```bash
aws ec2 enable-ebs-encryption-by-default --region us-east-1
aws ec2 get-ebs-encryption-by-default --region us-east-1
```

## Post-Change Validation
- Confirmed setting returns true
- A subsequently created test volume came up encrypted automatically

## Rollback Plan
`aws ec2 disable-ebs-encryption-by-default` (does not affect already-created volumes).

## Outcome
Success. New volumes encrypted by default going forward.
