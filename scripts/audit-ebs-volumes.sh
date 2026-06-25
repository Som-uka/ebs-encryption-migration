#!/usr/bin/env bash
#
# audit-ebs-volumes.sh
# Inventories EBS volumes by encryption status, type, and attachment state.
# Read-only.
#
# Usage: ./audit-ebs-volumes.sh <region>
set -euo pipefail
REGION="${1:-us-east-1}"

echo "==> Volume summary by type and encryption:"
aws ec2 describe-volumes --region "$REGION" \
  --query 'Volumes[*].{ID:VolumeId,Type:VolumeType,Encrypted:Encrypted,State:State,Size:Size}' \
  --output table

echo "==> Unencrypted volumes (remediation targets):"
aws ec2 describe-volumes --region "$REGION" \
  --filters Name=encrypted,Values=false \
  --query 'Volumes[*].{ID:VolumeId,Size:Size,Type:VolumeType}' --output table

echo "==> gp2 volumes (gp3 upgrade candidates):"
aws ec2 describe-volumes --region "$REGION" \
  --filters Name=volume-type,Values=gp2 \
  --query 'Volumes[*].{ID:VolumeId,Size:Size}' --output table
