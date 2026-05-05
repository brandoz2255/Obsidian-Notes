* **Nmap** also known as Network Mapper
* basic Scan: suppose that in order ot perform a basic scan against a target [10.129.42.253] 
* We would essentially input [nmap 10.129.42.253]
* This would complete the scan quickly this would be because if we don't specify any additional option Nmap will scan only the 1000 most common ports by default 
* **By default Nmap will conduct a [[TCP]] scan unless its specified otherwise
* Port specifies what port it is and what its using 
* state heading confirms that these ports are opened or closed 
* service tells us that the service's name is typically mapped to the specific port number 
* The default scan will not tell us what is listening on that port until we of courses instruct Nmap to interact with the service
* port [3389] commonly means the device is a windows
* To do a more specified Nmap scan input[ -sC] parameter to specify Nmaps scripts should be used to try and obtain more detailed info
* [-sV] parameter instructs Nmap to perform a version scan. this scan Nmap will fingerprint services on the target system and identify the service protocol
* [-p-]tells Nmap that we want to scan all the TCP ports
***Example*** 
```shell-session
nmap -sV -sC -p- 10.129.42.25
```
***Output*** 
```shell-session
tarting Nmap 7.80 ( https://nmap.org ) at 2021-02-25 16:18 EST
Nmap scan report for 10.129.42.253
Host is up (0.11s latency).
Not shown: 65530 closed ports
PORT    STATE SERVICE     VERSION
21/tcp  open  ftp         vsftpd 3.0.3
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_drwxr-xr-x    2 ftp      ftp          4096 Feb 25 19:25 pub
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to ::ffff:10.10.14.2
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 2
|      vsFTPd 3.0.3 - secure, fast, stable
|_End of status
22/tcp  open  ssh         OpenSSH 8.2p1 Ubuntu 4ubuntu0.1 (Ubuntu Linux; protocol 2.0)
80/tcp  open  http        Apache httpd 2.4.41 ((Ubuntu))
|_http-server-header: Apache/2.4.41 (Ubuntu)
|_http-title: PHP 7.4.3 - phpinfo()
139/tcp open  netbios-ssn Samba smbd 4.6.2
445/tcp open  netbios-ssn Samba smbd 4.6.2
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Host script results:
|_nbstat: NetBIOS name: GS-SVCSCAN, NetBIOS user: <unknown>, NetBIOS MAC: <unknown> (unknown)
| smb2-security-mode: 
|   2.02: 
|_    Message signing enabled but not required
| smb2-time: 
|   date: 2021-02-25T21:21:51
|_  start_date: N/A
```
* this would take alot longer since its more specified 
* From this we can see that the os is Ubuntu Linux 
The Syntax for running the Nmap Script 
* Nmap Scripts are a great way to enhance our scans functionality and inspection of the available options
* [[Network Enumeration]] can be done with Nmap
* Nmap can be used to get banners such as using  `nmap -sV --script=banner <target>`
* We could also use `nmap -sV --script=banner -p21 10.10.10.0/24`mm 
[[FTP ]]
* FTP is a standard protocol, and this service can often contain interesting data. A Nmap scan on the port default for FTP is vsftpd 3.0.3
```shell-session
00818@htb[/htb]$ nmap -sC -sV -p21 10.129.42.253

Starting Nmap 7.80 ( https://nmap.org ) at 2020-12-20 00:54 GMT
Nmap scan report for 10.129.42.253
Host is up (0.081s latency).

PORT   STATE SERVICE VERSION
21/tcp open  ftp     vsftpd 3.0.3
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_drwxr-xr-x    2 ftp      ftp          4096 Dec 19 23:50 pub
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to ::ffff:10.10.14.2
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 3
|      vsFTPd 3.0.3 - secure, fast, stable
|_End of status
Service Info: OS: Unix

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 1.78 seconds
```

* FTP CLI Ultitie
```shell-session
00818@htb[/htb]$ ftp -p 10.129.42.253

Connected to 10.129.42.253.
220 (vsFTPd 3.0.3)
Name (10.129.42.253:user): anonymous
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.

ftp> ls
227 Entering Passive Mode (10,129,42,253,158,60).
150 Here comes the directory listing.
drwxr-xr-x    2 ftp      ftp          4096 Feb 25 19:25 pub
226 Directory send OK.

ftp> cd pub
250 Directory successfully changed.

ftp> ls
227 Entering Passive Mode (10,129,42,253,182,129).
150 Here comes the directory listing.
-rw-r--r--    1 ftp      ftp            18 Feb 25 19:25 login.txt
226 Directory send OK.

ftp> get login.txt
local: login.txt remote: login.txt
227 Entering Passive Mode (10,129,42,253,181,53).
150 Opening BINARY mode data connection for login.txt (18 bytes).
226 Transfer complete.
18 bytes received in 0.00 secs (165.8314 kB/s)

ftp> exit
221 Goodbye.
```

start 
* In the shell above we see that FTP supports common commands such as **cd** and **ls** and then allows us to download files with the **get** command

[SMB:][ ] Server message block is a protocol on windows that provides vectors for movement
* Some SMB data can be [[RCE]] exploited such as [[EternalBlue]] 
```shell-session
00818@htb[/htb]$ nmap --script smb-os-discovery.nse -p445 10.10.10.4
```
type the SMB Nmap 
```shell-session
Starting Nmap 7.91 ( https://nmap.org ) at 2020-12-27 00:59 GMT
Nmap scan report for doctors.htb (10.10.10.40)
Host is up (0.022s latency).

PORT    STATE SERVICE
445/tcp open  microsoft-ds

Host script results:
| smb-os-discovery: 
|   OS: Windows 7 Professional 7601 Service Pack 1 (Windows 7 Professional 6.1)
|   OS CPE: cpe:/o:microsoft:windows_7::sp1:professional
|   Computer name: CEO-PC
|   NetBIOS computer name: CEO-PC\x00
|   Workgroup: WORKGROUP\x00
|_  System time: 2020-12-27T00:59:46+00:00

Nmap done: 1 IP address (1 host up) scanned in 2.71 seconds
```
* **-N**  Suppresses the password prompt **-L** specifies what we want to retrieve 
```shell-session
00818@htb[/htb]$ smbclient -N -L \\\\10.129.42.253
```


[[Network Enumeration]]

[[More Nmap]]