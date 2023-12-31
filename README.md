# gcp

## apache
### Check the Apache Configuration for the SSL Certificate Path
- On Debian-based systems, Apache's configuration files are usually located in /etc/apache2/sites-enabled/. 
- Look for directives like SSLCertificateFile and SSLCertificateKeyFile to determine the paths to the certificate and private key.
- SSLCertificateFile      /etc/ssl/certs/mydomain.crt
- SSLCertificateKeyFile   /etc/ssl/private/mydomain.key
### Check the Certificate's Validity
- `openssl x509 -noout -dates -in /etc/ssl/certs/mydomain.crt`
- This will display the `notBefore` and `notAfter` dates, which tell you the certificate's valid period.


### Check the Certificate Chain
- If you're using a chain of certificates (i.e., intermediate certificates), ensure they're correctly set up. 
- You might have a directive like `SSLCertificateChainFile` or `SSLCACertificateFile` for this.
- `openssl crl2pkcs7 -nocrl -certfile /etc/ssl/certs/mychain.crt | openssl pkcs7 -print_certs -text -noout`
- `echo | openssl s_client -showcerts -servername mydomain.com -connect mydomain.com:443 2>/dev/null | openssl x509 -inform pem -noout -text`
### Verify SSL Certificate for a Remote Server
- If you want to verify the SSL certificate of your site remotely (from a different machine), you can use openssl:
### Check the Validity of the New Certificate
- `openssl x509 -noout -dates -in path_to_new_.crt`
- This will give you the `notBefore` and `notAfter dates` for the new certificate, which will let you know its valid duration.

### Verify the Private Key Matches the Certificate
- It's essential to make sure that the private key corresponds to the certificate.
#### Check the modulus of the private key
`openssl rsa -noout -modulus -in path_to_new_acme.key | openssl md5`

#### Check the modulus of the certificate
`openssl x509 -noout -modulus -in path_to_new_cert.crt | openssl md5`
- Both commands should return the same MD5 hash. If they match, this means your certificate and key correspond with each other.

### Verify the Certificate Chain
- You'll want to ensure the entire chain is valid:
- `openssl verify -CAfile path_to_new_DigiCertCA.crt path_to_new_cert.crt`
- If your DigiCertCA.crt file contains more than one certificate (e.g., intermediate + root), ensure they're in the correct order. 
- Typically, the server's certificate comes first, followed by intermediates from leaf to root
- You can view the certificates in the chain with:
- `openssl crl2pkcs7 -nocrl -certfile path_to_new_DigiCertCA.crt | openssl pkcs7 -print_certs -text -noout`
### Check the Certificate Chain Order (if applicable)

### reload apache
- `sudo systemctl reload apache2`

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

### demo4
### demo5
- Determines the version of the Debian OS to use the correct repository.
- Adds the gcsfuse repo.
- Installs the GPG key.
- Updates the package list.
- Installs the gcsfuse package.

### demo6
- Backup existing SSL files: This will copy the existing certificates and keys on the Apache server to a backup location with a timestamp in the filename.
- Copy new SSL certificate and chain: This will copy the certificates and the key from your Ansible control server to the Apache server.
- Check SSL certificate validity: This uses the openssl command to check the validity of the new SSL certificate on the Apache server. The playbook will fail at this step if the check is unsuccessful.
- Reload Apache service: This will reload the Apache service if the certificate check is successful.

## demo7
- "Check if /bin/sh is already symlinked to /bin/bash" which uses the readlink command to determine the target of the /bin/sh symlink. 
- The result is stored in the current_symlink variable.
- The set_fact module is then used to set a fact named symlink_correct if /bin/sh is already pointing to /bin/bash.
- The `when: not symlink_correct` condition has been added to the tasks that need to be skipped if the symlink is already correct. 
- This ensures these tasks are only executed if /bin/sh isn't already symlinked to /bin/bash.
- The copy module is used to copy the bash-test.sh script from your control server to the remote servers.
- the script is make executable using the `0755` permissions mapping
- The bash_update_result registered variable keeps track of whether the update of /bin/sh to point to /bin/bash was successful.
- The command module runs the bash-test.sh script only if the bash_update_result indicates success.

## demo8
- use regular expression matching to match lines in the Apache configuration and remove them
- The $ symbol in regular expressions asserts the position at the end of a line. 
- When used in a regex pattern, it means that the preceding character or group must appear at the end of the line for a match to occur.

- BalancerMember will match lines that contain this exact string.
- `.*` allows for any characters (including none) between BalancerMember and the -fe1[5-9].
- `-fe1[5-9]` will match -fe15, -fe16, -fe17, -fe18, or -fe19.
- `$` asserts that the matched string should be at the end of a line.