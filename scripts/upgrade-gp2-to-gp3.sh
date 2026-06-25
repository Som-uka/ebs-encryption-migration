#!/usr/bin/env bash
#
# upgrade-gp2-to-gp3.sh
# Bulk-upgrades all gp2 volumes to gp3 in a region. Live modification,
# no downtime. Prompts before acting.
#
# Usage: ./upgrade-gp2-to-gp3.sh <region>
set -euo pipefail
REGION="${1:-us-east-1}"

mapfile -t VOLS < <(aws ec2 describe-volumes --region "$REGION" \
  --filters Name=volume-type,Values=gp2 \
  --query 'Volumes[*].VolumeId' --output text | tr '\t' '\n')

echo "Found ${#VOLS[@]} gp2 volumes."
read -r -p "Proceed to convert all to gp3? [y/N] " ans
[[ "$ans" == "y" ]] || { echo "Aborted."; exit 0; }

for v in "${VOLS[@]}"; do
  echo "==> $v -> gp3"
  aws ec2 modify-volume --volume-id "$v" --volume-type gp3 --region "$REGION" >/dev/null
done
echo "==> Done. Monitor with describe-volumes-modifications."
