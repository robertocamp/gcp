Using the Gcloud CLI , I would like to add some labels to my VMs.   
We have naming convention for our servers like this:  liproj-prod-frontend2 and liproj-prod-backend1

I would like to do this:
I would like to loop through the VMs that are in a RUNNING state, and if "frontend" or "backend" are in the VM name, I would like to add the label "appserver" to those VMs.

Can we develop a shell script that uses Gcloud CLI to do this?