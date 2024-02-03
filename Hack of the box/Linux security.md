In the world of security most malware that exist in the world of cyber mostly target windows machines so this gives Linux the high ground in the world of security and active directory attacks 

- One of the most easy and important security measures in Linux is making sure that system and all of its packages is updates 

```shell-session
00818@htb[/htb]$ apt update && apt dist-upgrade
```

- The place that puts it in the front-line of possible intrusion is web servers or ssh 

- When using SSH its important to take off root login and only allow `sudo` and we should only allow some root privileges with the `sudo` command not access to all. 

- We also need to make sure there are no availability for priveledge escalation in which done with` mis configured cron jobs, outdated kernel, permission issues, and some updates need to be updated manually.`  

#### SELinux and AppArmor
-  Security Enhanced Linux or AppArmor is a kernel security module that can be used for security access control policies
-  Gives every service in Linux a label and rules for each service and who can and cant move it. 

There are other services like SELinux and AppArmor that are similar 

- [Snort](https://www.snort.org/)
- [chkrootkit](http://www.chkrootkit.org/)
- [rkhunter](https://packages.debian.org/sid/rkhunter)
- [Lynis](https://cisofy.com/lynis/)

Security settings should be --> 

- Removing or disabling all unnecessary services and software
- Removing all services that rely on unencrypted authentication mechanisms
- Ensure NTP is enabled and Syslog is running
- Ensure that each user has its own account
- Enforce the use of strong passwords
- Set up password aging and restrict the use of previous passwords
- Locking user accounts after login failures
- Disable all unwanted SUID/SGID binaries

## TCP Wrappers 
- A TCP Wrapper is a tool in Linux systems that allow the system admin to let any specific Ip client into the system 
- For example if a client wants to get into the system and they don't have the specified Ip address they wont be granted into the system
- We canb set up such secuiryt measures in these two directories 

- `/etc/hosts.allow`
    
- `/etc/hosts.deny`

- They allow and deny hosts into the system 

#### /etc/hosts.allow

```shell-session
00818@htb[/htb]$ cat /etc/hosts.allow

# Allow access to SSH from the local network
sshd : 10.129.14.0/24

# Allow access to FTP from a specific host
ftpd : 10.129.14.10

# Allow access to Telnet from any host in the inlanefreight.local domain
telnetd : .inlanefreight.local
```

#### /etc/hosts.deny

```shell-session
00818@htb[/htb]$ cat /etc/hosts.deny

# Deny access to all services from any host in the inlanefreight.com domain
ALL : .inlanefreight.com

# Deny access to SSH from a specific host
sshd : 10.129.22.22

# Deny access to FTP from hosts with IP addresses in the range of 10.129.22.0 to 10.129.22.255
ftpd : 10.129.22.0/24
```

