#!/bin/bash

# Define the compute zone
COMPUTE_ZONE="us-central1-a"  # Replace this with your desired zone

# Define patterns for VM names. Add or remove patterns as needed.
declare -a PATTERNS=("frontend" "backend")

# Get VMs in RUNNING state within the specified zone
vms=$(gcloud compute instances list --filter="status:RUNNING" --format="value(name)" --zone=$COMPUTE_ZONE)

# Loop through VMs
for vm in $vms; do
    for pattern in "${PATTERNS[@]}"; do
        if [[ $vm == *"$pattern"* ]]; then
            echo "Removing label from VM: $vm"
            gcloud compute instances remove-labels $vm --labels=appserver --zone=$COMPUTE_ZONE
            # Break out of the inner loop once a match is found for a VM
            break
        fi
    done
done

echo "Label removal complete!"
