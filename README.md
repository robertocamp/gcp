# gcp
## playbooks
### demo1
1. The setup module gathers the OS distribution and version.
2. The OS distribution and version are printed to the console.
3. The service_facts module gathers facts about all services.
4. The playbook checks if the google-osconfig-agent service is among the services and sets the fact google_osconfig_agent_exists.
5. The fact google_osconfig_agent_exists is printed to the console.
6. If google_osconfig_agent_exists is false, the playbook updates the apt cache and installs google-osconfig-agent.
7. The playbook attempts to get the status of the google-osconfig-agent service and registers the output to the systemctl_output fact. If the service doesn't exist or is not running, the task will fail, but the ignore_errors: yes directive ensures that the playbook will continue.
8. If systemctl_output.stdout is defined, which means the previous command did not fail, the playbook prints the status of the google-osconfig-agent service to the console.