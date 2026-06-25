# Volume Inventory (Before Remediation)

| Finding | Count |
|---|---|
| Total EBS volumes | 46 |
| Unencrypted volumes | 46 (100%) |
| gp2 volumes | 44 |
| Unattached volumes | 5 |

## Notes
- Every attached volume was unencrypted at rest, a baseline compliance gap.
- The majority sat on gp2, leaving free cost/performance gains on the table by not moving to gp3.
- Five volumes were unattached and accruing storage cost with no consumer.

## Remediation outcome
- gp2 -> gp3 conversion executed live across the fleet (no downtime).
- Encryption-by-default enabled so all new volumes are encrypted automatically.
- Unattached volumes snapshotted and deleted after confirming no dependency.
