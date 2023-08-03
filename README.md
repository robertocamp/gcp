# gcp
## playbooks
### demo1
A new apt task is added to update the apt cache and install google-osconfig-agent. This task is only executed if google_osconfig_agent_exists is false.

The apt module is used to manage packages. The name parameter is set to the package to install (google-osconfig-agent), update_cache is set to yes to update the apt cache before installing the package, and state is set to present to ensure the package is installed.

This version of the playbook will install google-osconfig-agent on any host where it is not already installed, and then get and display the status of the service. Note that the systemctl status google-osconfig-agent task may still fail if the service is not running, even though it is installed. If this is a concern, you could add another task to ensure the service is running using the service module.