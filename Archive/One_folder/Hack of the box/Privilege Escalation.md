
## PrivEsc Checklist
  *  After gaining root access, follow a privilege escalation checklist.
    -  You can find privilege escalation checklists online for reference.
- **Enumeration Scripts:**
    
    - Enumeration scripts help identify vulnerabilities and gather useful information.
    - Running common commands can reveal weaknesses and interesting data.
    - Note: Running scripts may trigger security alerts or anti-virus software, so use caution.
    - Example: Use LinPEAS script from PEAS for Linux privilege escalation.
        
        shellCopy code
        
        `[!bash!]$ ./linpeas.sh ...SNIP...`
        
- ## Kernel Exploits:
    
    - Look for kernel exploits, especially in older Linux versions.
    - Example: If you find a kernel version like "3.9.0-73-generic," search for relevant exploits (e.g., DirtyCow) using tools like `searchsploit`.
        
        shellCopy code
        
        `searchsploit Apache searchsploit -x exploits/multiple/webapps/49889.py`

## Vulnerable Software 
- **Check Installed Software**:
    
    - On Linux, use the `dpkg -l` command to list installed software packages.
    - On Windows, navigate to `C:\Program Files` to view installed software.
- **Search for Public Exploits**:
    
    - Look for public exploits that target any installed software.
    - Pay special attention to older versions of software that may have unpatched vulnerabilities.
## User privileges 
- **Check User Privileges:**
    
    - Examine the privileges available to the user with access to the server.
- **Common Privilege Escalation Methods:**
    
    - Sudo
    - SUID
    - Windows Token Privileges
- **Sudo in Linux:**
    
    - Allows a user to execute commands as a different user, often used for running specific commands as root.
    - Use `sudo -l` to check sudo privileges.
    - Example Output:
        
        sqlCopy code
        
        `User user1 may run the following commands on ExampleServer: (ALL : ALL) ALL`
        
    - Execute commands with `sudo` to escalate privileges, e.g., `sudo su -`.
- **Sudo Without Password:**
    
    - Some commands or applications can be run with `sudo` without providing a password.
    - Check privileges with `sudo -l`.
    - Example Output:
        
        javascriptCopy code
        
        `(user : user) NOPASSWD: /bin/echo`
        
    - Execute commands without a password requirement, e.g., `sudo -u user /bin/echo Hello World!`
- **Exploiting Sudo Privileges:**
    
    - Find specific applications that can be run with `sudo`.
    - Search for ways to exploit these applications to gain higher privileges.
    - Tools like GTFOBins provide information on exploiting commands with `sudo`.
- **Windows Token Privileges:**
    
    - On Windows systems, leverage token privileges to perform privileged actions.
    - LOLBAS (Living Off The Land Binaries and Scripts) lists Windows applications for potential privilege escalation.

### Scheduled Tasks
*  In windows there are ways to run specific intervals to carry out a task 
*  In windows its called scheduled tasks and linux its calleed cron jobs
1. Add new scheduled tasks/cron jobs
2. Trick them to execute a malicious software

* The way  fro cehckign if we are allowed to add new tasks in Linux we must access teh Cron jobs directories 
1. `/etc/crontab`
2. `/etc/cron.d`
3. `/var/spool/cron/crontabs/root`

*  If we can write to a direvtoire we can write a bash script with a reverse shell command which sends us a reverse shell wehn excuted 
### Exposed Credentials
- **Objective**: Find files containing exposed credentials, such as passwords, in configuration files, log files, and user history files.
    
- **Common File Types to Check**:
    
    - Configuration PHP files.
    - Log files (limiting to 70 lines).
    - User history files like `bash_history` in Linux or `PSReadLine` in Windows.
- **Enumeration Scripts**:
    
    - Enumeration scripts are used to automate the process of searching for potential passwords in files.
- **Sample Output**:
    
    cssCopy code
    
    `[+] Searching passwords in config PHP files [+] Finding passwords inside logs (limit 70) /var/www/html/config.php: $conn = new mysqli(localhost, 'db_user', 'password123');`
    
- **Exposed Password Example**:
    
    - In the example, the database password 'password123' is exposed in the `config.php` file.
    - This exposed password could be used to log in to local MySQL databases to search for valuable information.
- **Password Reuse**:
    
    - Check if the system user has reused the same password for multiple purposes.
    - For example, the same password used for databases might also grant access to the system.
- **Switching User**:
    
    - If you have access to a user's password, you can attempt to switch to that user.
    - Example:
        
        bashCopy code
        
        `$ su - Password: password123 whoami root`
        
- **SSH Access**:
    
    - If you have user credentials, you can attempt to SSH into the server as that user.

## Private SSH Key:

- If you have read access to the `.ssh` directory of a specific user:
    - You can read their private SSH key (usually found in `/home/user/.ssh/id_rsa` or `/root/.ssh/id_rsa`).
    - Use the private key to log in to the server with the `-i` flag:
        
        bashCopy code
        
        `$ vim id_rsa $ chmod 600 id_rsa $ ssh user@10.10.10.10 -i id_rsa`
        
- Note: It's important to change the file permissions of the key to be restrictive (e.g., `chmod 600`) to ensure security. SSH keys with lax permissions won't work due to server restrictions.

**Placing Your Public SSH Key in User's Directory:**

- If you have write access to a user's `.ssh` directory (e.g., `/home/user/.ssh/`), you can place your public key there.
    
- This technique is often used to gain SSH access after gaining a shell as that user.
    
- Create a new key pair with `ssh-keygen` and the `-f` flag to specify the output file:
    
    bashCopy code
    
    `$ ssh-keygen -f key`
    
    - You'll have two files: `key` (for use with `ssh -i`) and `key.pub` (to be copied to the remote machine).
- Copy your `key.pub` to the remote machine.
    
- On the remote machine, append your public key to `/root/.ssh/authorized_keys`:
    
    bashCopy code
    
    `$ echo "ssh-rsa AAAAB...SNIP...M= user@parrot" >> /root/.ssh/authorized_keys`
    
- Now, you can SSH into the remote server as that user by using your private key:
    
    bashCopy code
    
    `$ ssh root@10.10.10.10 -i key`




[[Challenge]] 
