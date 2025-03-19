## Table of Contents

1. [General Approach](#general-approach)
2. [Linux FTP Service Playbook](#linux-ftp-service-playbook)
    - [Identify Installed FTP Services](#identify-installed-ftp-services-linux)
    - [Secure vsftpd](#secure-vsftpd)
    - [Secure ProFTPD](#secure-proftpd)
    - [Secure Pure-FTPd](#secure-pure-ftpd)
    - [Compile FTP Service from Source](#compile-ftp-service-from-source)
3. [Windows FTP Service Playbook](#windows-ftp-service-playbook)
    - [Identify Installed FTP Services](#identify-installed-ftp-services-windows)
    - [Secure IIS FTP Service](#secure-iis-ftp-service)
    - [Secure Third-Party FTP Services](#secure-third-party-ftp-services)
    - [Reinstall or Repair FTP Service](#reinstall-or-repair-ftp-service)
4. [Common Steps for Both Platforms](#common-steps)
    - [Check for Unauthorized Users](#check-for-unauthorized-users)
    - [Update Passwords](#update-passwords)
    - [Firewall Configuration](#firewall-configuration)
    - [Monitor and Log Activity](#monitor-and-log-activity)
5. [Final Checklist](#final-checklist)


# Identify installed FTP Services 

``` bash
netstat -tulnp | grep ftp
```

if no `netstat` you might be cooked ! lowks....


**check common FTP service binaries:**
```bash
which vsftpd
which proftpd
which pure-ftpd
```

**Check foro FTP service configuration files**

```bash 
ls /etc/vsftpd/
ls /etc/proftpd/
ls /etc/pure-ftpd/
```

**Secure vsftpd**

backup the config

```bash
cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
```


**Edit Configuration**:

``` bash
vi /etc/vsftpd.conf
```

**Ensure the following settings**

```bash 
anonymous_enable=NO
local_enable=YES
write_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES
```

**Restart Service** 

``` bash 
service vsftpd restart
```

**Verify Service Status**

``` bash 
service vsftpd status
```

**Secure ProFTPD**

``` bash 
cp /etc/proftpd/proftpd.conf /etc/proftpd/proftpd.conf.bak
```

**Edit Configuration** 

``` bash 
vi /etc/proftpd/proftpd.conf
```

- ensure the following settings 

``` bash
ServerType standalone
DefaultRoot ~
RequireValidShell off
```

----



**Check for backdoors** 
- look for any suspicious modules or directives 

Identify which FTP server is running `vstpd, ProFTPD, Pure-FTPd`
- Locate the main configuration files

-  Open the configuration files using a text editor like `vi` or `nano`.
---

# vsftpd

to start
```bash
sudo service vsftpd start
```

to stop 

```bash
sudo service vsftpd stop
```



- Identify configuration file 
- the main configuration is usually in `/etc/vsftpd.conf`
- if not then check other common locations such as `/etc/vsftpd`, `/etc/vsftpd/vsftpd.conf`, `/etc/vsftpd.conf`
	- [1](https://askubuntu.com/questions/47260/where-is-vsftpd-conf)[2](https://serverfault.com/questions/263173/etc-vsftpd-conf-file-not-found)
	- if using the sources is allowed

if apt
``` bash
sudo apt-get remove vsftpd
sudo apt-get install vsftpd
```

or if yum
```bash
sudo yum remove vsftpd
sudo yum install vsftpd
```

or if pacman 

```bash
sudo pacman -R vsftpd
sudo pacman -S vsftpd
```

Examine the package contents: If you still can't find the file, you can extract it from the package archive:

``` bash
cd /tmp
ar x /var/cache/apt/archives/vsftpd*.deb data.tar.gz
tar xvf data.tar.gz ./etc/vsftpd.conf
```



sudo apt-get install vsftpd
`
- or find the file `find / -name vsftpd.conf`
- could also if *apt* is *working* 
- open the configuration file `vi /etc/vfstpd.conf`

``` bash
cat /etc/vsftpd.user_list
```

- verify authorized users 

Open the config file 

```bash
vi /etc/vsftpd.conf
```
##### Look for Suspicious Modules or Directives

- **Anonymous Access:**
    
    - Ensure `anonymous_enable=NO`.

- **Userlist Configuration:**
    
    - Check `userlist_enable` and `userlist_file` directives.
        
    - Open the userlist file if specified (e.g., `/etc/vsftpd.user_list`).

``` bash
cat /etc/vsftpd.user_list
```

- **Banner Messages:**
    
    - Check for `ftpd_banner` directive that may contain messages or scripts.
- **Command Execution:**
    
    - Look for any `cmds_allowed` or `cmds_denied` directives that might be misconfigured.
- **Chroot Settings:**
    
    - Ensure `chroot_local_user=YES` to prevent users from accessing directories outside their home.

to search for unusual directives or post-login scripts 

- Check for non-standard directives 
	- Open the main vsftpd configuration `(/etc/vsftpd.conf)`
	- look for anything unfamiliar 
- Search for post-login scripts:
	- Check `/etc/pam.d/vsftpd` for any unusual PAM (Pluggable Authentication Modules) configurations.
	- Look for scripts in `/etc/rc.d/init.d/vsftpd` or `/lib/systemd/system/vsftpd.service`.

Also grep commands to search for any weird entries

``` bash
grep -r "local_" /etc/vsftpd.conf
grep -r "global_" /etc/vsftpd.conf
grep -r "post-login" /etc/pam.d/vsftpd
grep -r "vsftpd" /etc/rc.d/init.d/
```

``` bash
ls -l /etc/vsftpd.conf
ls -l /etc/pam.d/vsftpd
ls -l /etc/rc.d/init.d/vsftpd
```


search for any binary modifications

``` bash
strings /usr/sbin/vsftpd | grep -v "vsftpd"
```
Check for `vsftpd` logs for any unusual activity 

```bash
tail -n 100 /var/log/vsftpd.log
```

Verify Binary Integrity 

``` bash
sha256sum /usr/sbin/vsftpd
```

Check Running Processes

``` bash 
ps aux | grep vsftpd
```

Check vsftpd `log file`

``` bash
cat /var/log/vsftpd.log
```

----



**Restart Service:** 

``` bash
service proftpd restart
```

**Verify Service Status:** 

``` bash 
service proftpd status
```

Identify the Configuration file

- the main configuration file is usually located in `/etc/proftpd/proftpd.conf`

Open the Configuration 

``` bash
vi /etc/proftpd/proftpd.conf
```

look for suspicous Modules or Directorives

- check `LoadModule`
- Compare against the list of standard ProFTPD modules

``` bash
grep 'LoadModule' /etc/proftpd/modules.conf
```


- **Anonymous Access:**
    
    - Ensure `<Anonymous>` sections are disabled or properly secured.
- **User Directives:**
    
    - Review `User` and `Group` directives to ensure the FTP service runs under the correct user.
- **SQL and Exec Modules:**
    
    - If modules like `mod_sql` or `mod_exec` are loaded without necessity, they might be used for malicious purposes.


- **Search for Backdoors in Configuration**

- **Hidden Directories:**
    
    - Check for `HiddenStor` or `HiddenList` directives.
- **Exec Commands:**
    
    - Look for `ExecEngine` directives that allow command execution.
- **SFTP Configuration:**
    
    - Verify that SFTP settings are correct if in use.

Check ProFTPD binary

```bash
sha256sum /usr/sbin/proftpd
```

**Check ProFTPD Log Files:**

``` bash
cat /var/log/proftpd/proftpd.log
```

``` bash
cat /var/log/secure | grep proftpd
```




---


**Secure Pure-FTPd** 
- Configuration files are often in `/etc/pure-ftpd/` or `/etc/`.

- The main configuration might be in `/etc/pure-ftpd/pure-ftpd.conf`.

``` bash
vi /etc/pure-ftpd/pure-ftpd.conf
```



**Backup Configuration** 

``` bash 
cp /etc/pure-ftpd/pure-ftpd.conf /etc/pure-ftpd/pure-ftpd.conf.bak
```

**Edit Configuration** 

``` bash
vi /etc/pure-ftpd/pure-ftpd.conf
```

**Ensure the following settings** 

``` bash
NoAnonymous yes
ChrootEveryone yes
```

**Check for backdoor**
- verify that no unauthorized users are allowed

**Restart Service** 

``` bash
service pure-ftpd restart
```

**Verify Service Status**

``` bash
service pure-ftpd status
```









