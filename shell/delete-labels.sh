#!/bin/bash

# Define the compute zone
COMPUTE_ZONE="us-central1-a"  # Replace this with your desired zone

# Get VMs in RUNNING state within the specified zone
vms=$(gcloud compute instances list --filter="status:RUNNING" --format="value(name)" --zone=$COMPUTE_ZONE)

# Loop through VMs and remove the label from those that match the naming convention
for vm in $vms; do
    if [[ $vm == *"-frontend"* ]] || [[ $vm == *"-backend"* ]]; then
        echo "Removing label from VM: $vm"
        gcloud compute instances remove-labels $vm --labels=appserver --zone=$COMPUTE_ZONE
    fi
done

echo "Label removal complete!"
