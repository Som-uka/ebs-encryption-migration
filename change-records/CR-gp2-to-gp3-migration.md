# CR: gp2 to gp3 Migration

| Field | Details |
|---|---|
| Change ID | CR-EBS-002 |
| Environment | Production |
| Risk Level | Low |
| Status | Complete |

## Description
Converted gp2 volumes to gp3 live, with no instance restart. gp3 is ~20% cheaper and provides a fixed performance baseline independent of size.

## Steps Performed
```bash
aws ec2 modify-volume --volume-id <id> --volume-type gp3
aws ec2 describe-volumes-modifications --volume-ids <id> \
  --query 'VolumesModifications[*].{State:ModificationState,Progress:Progress}'
```

## Post-Change Validation
- Each volume confirmed gp3, modification `completed`
- Instances remained running throughout

## Rollback Plan
modify-volume back to gp2 (6-hour cooldown between modifications).

## Outcome
Success. Storage cost reduced, zero downtime.
