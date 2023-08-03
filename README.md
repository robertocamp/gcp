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
### demo2 
### demo3
- The copy module is used to ensure the /etc/apt/sources.list.d/google-compute-engine.list file has the correct contents. 
- The dest parameter is the path to the file, the content parameter is the desired contents of the file, and the owner, group, and mode parameters control the ownership and permissions of the file.
- The apt module is used to update the apt cache, so the new configuration is taken into account.
- Remember to replace google-compute-engine-stretch-stable with the appropriate distribution codename for your Debian version if needed. 
- For example, for Debian 10 (Buster) use google-compute-engine-buster-stable, and for Debian 11 (Bullseye) use google-compute-engine-bullseye-stable.
- Also note the use of become: yes at the playbook level to ensure the tasks are run with superuser privileges, as modifying files in /etc/apt/sources.list.d/ and updating the apt cache typically require such privileges.