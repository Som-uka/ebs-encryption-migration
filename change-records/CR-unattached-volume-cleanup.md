# CR: Unattached Volume Cleanup

| Field | Details |
|---|---|
| Change ID | CR-EBS-003 |
| Environment | Production |
| Risk Level | Low |
| Status | Complete |

## Description
Snapshotted and deleted unattached EBS volumes that were accruing storage cost with no consumer.

## Steps Performed
```bash
aws ec2 describe-volumes --filters Name=status,Values=available \
  --query 'Volumes[*].{ID:VolumeId,Size:Size}' --output table
aws ec2 create-snapshot --volume-id <id> --description "pre-deletion safety snapshot"
aws ec2 delete-volume --volume-id <id>
```

## Post-Change Validation
- Snapshots `completed` before deletion
- Volumes confirmed removed

## Rollback Plan
Recreate from snapshot: `aws ec2 create-volume --snapshot-id <snap>`.

## Outcome
Success. Idle storage charges removed; snapshots retained as recovery points.
