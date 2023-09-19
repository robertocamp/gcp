#!/bin/bash

# Get VMs in RUNNING state
vms=$(gcloud compute instances list --filter="status:RUNNING" --format="value(name)")

# Loop through VMs and label those that match the naming convention
for vm in $vms; do
    if [[ $vm == *"-frontend"* ]] || [[ $vm == *"-backend"* ]]; then
        echo "Labeling VM: $vm"
        gcloud compute instances add-labels $vm --labels=appserver=true
    fi
done

echo "Labeling complete!"
