When working with a linux system it is essential to know the network services that are provided with the system itself. Which are essential in penetration testing and for the blue teaming status. 

- With the knowledge on this we can traffic information across systems
- The network can have someone listening to it which is useful for penetration testing listenting to a network
- with this we can see if or when a linux user connects to another server

# SSH
Secure shell is a network protocal taht allows the transmission of data and commands over the network. 

- the most commons=ly used SSH server is the openSSH server which is a free opensource SSH 
- This allows transmission of files with commands over a secure data

## How to do SSH
- First in order to set up one we must download the OpenSSH 
```shell-session
00818@htb[/htb]$ sudo apt install openssh-server -y
```

Now that its installed we can check with the following command 

```shell-session
00818@htb[/htb]$ systemctl status ssh

● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/system/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Sun 2023-02-12 21:15:27 GMT; 1min 22s ago
       Docs: man:sshd(8)
             man:sshd_config(5)
   Main PID: 7740 (sshd)
      Tasks: 1 (limit: 9458)
     Memory: 2.5M
        CPU: 236ms
     CGroup: /system.slice/ssh.service
             └─7740 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
```

As a penetration tester we must get access to the system but in our case of blue teaming we still must do this with the following 

```shell-session
00818@htb[/htb]$ ssh cry0l1t3@10.129.17.122

The authenticity of host '10.129.17.122 (10.129.17.122)' can't be established.
ECDSA key fingerprint is SHA256:bKzhv+n2pYqr2r...Egf8LfqaHNxk.

Are you sure you want to continue connecting (yes/no/[fingerprint])? yes

Warning: Permanently added '10.129.17.122' (ECDSA) to the list of known hosts.

cry0l1t3@10.129.17.122's password: ***********
```

- this is to log in in case we forget how to

We can configure our own SSH in the following directory   `/etc/ssh/sshd_config` using a text editor but we must be careful configuring it since of course we are against red team. 


# NFS
The Network File system which essentially is  anetwork protocol that allows us to store and manage files on a remote system as if they were stored on a local system
- Both windows and linux uses this type file system 
-  there are several NFS servers, including NFS-UTILS (`Ubuntu`), NFS-Ganesha (`Solaris`), and OpenNFS (`Redhat Linux`).

### How to install
We can do so with the following command --> 
```shell-session
00818@htb[/htb]$ sudo apt install nfs-kernel-server -y
```

We can check if its running with the following command 
```shell-session
00818@htb[/htb]$ systemctl status nfs-kernel-server

● nfs-server.service - NFS server and services
     Loaded: loaded (/lib/system/system/nfs-server.service; enabled; vendor preset: enabled)
     Active: active (exited) since Sun 2023-02-12 21:35:17 GMT; 13s ago
    Process: 9234 ExecStartPre=/usr/sbin/exportfs -r (code=exited, status=0/SUCCESS)
    Process: 9235 ExecStart=/usr/sbin/rpc.nfsd $RPCNFSDARGS (code=exited, status=0/SUCCESS)
   Main PID: 9235 (code=exited, status=0/SUCCESS)
        CPU: 10ms
```

We can configure it in the following directory `/etc/exports`
However the fie specifies which directory should be shared and what rights to which user. We can also configure the transfer speed and the use of encryption. 

|**Permissions**|**Description**|
|---|---|
|`rw`|Gives users and systems read and write permissions to the shared directory.|
|`ro`|Gives users and systems read-only access to the shared directory.|
|`no_root_squash`|Prevents the root user on the client from being restricted to the rights of a normal user.|
|`root_squash`|Restricts the rights of the root user on the client to the rights of a normal user.|
|`sync`|Synchronizes the transfer of data to ensure that changes are only transferred after they have been saved on the file system.|
|`async`|Transfers data asynchronously, which makes the transfer faster, but may cause inconsistencies in the file system if changes have not been fully committed.|

We can share files in NFS with the following command

```shell-session
cry0l1t3@htb:~$ mkdir nfs_sharing
cry0l1t3@htb:~$ echo '/home/cry0l1t3/nfs_sharing hostname(rw,sync,no_root_squash)' >> /etc/exports
cry0l1t3@htb:~$ cat /etc/exports | grep -v "#"

/home/cry0l1t3/nfs_sharing hostname(rw,sync,no_root_squash)
```

We need to mount it first we  can do so with the following command

```shell-session
cry0l1t3@htb:~$ mkdir ~/target_nfs
cry0l1t3@htb:~$ mount 10.129.12.17:/home/john/dev_scripts ~/target_nfs
cry0l1t3@htb:~$ tree ~/target_nfs

target_nfs/
├── css.css
├── html.html
├── javascript.js
├── php.php
└── xml.xml

0 directories, 5 files
```

- With this we can see that we have mounted on the NFS share (`dev_scripts`) from the target IP of (`10.129.12.17`) we did this locally from our mount point of `target_nfs` 

# Web Server 
A web server is the most important part of the penetration testers role for this we must configure this well and I mean really. They provide all types of software that provides data and documents and other applications over the internet. 

-  Web servers use the HTTP aka hypertext transfer protocol to send data between the clients and the web browsers and receive such requests from clients 
- These are renedered using the Hyper text markup language aka HTML in the clients browser to display the data towards the client 
- This allows a dynamic communication between the client and the web server 
- Some of the most popular web servers for Linux servers are Apache, Nginx, Lighttpd, and Caddy. Apache is one of the most popular and widely used web servers and is available on a variety of operating systems, including Ubuntu, Solaris, and Redhat Linux.
- This is why we must be careful when configuring the web server 

Penetration testers can for example use a web server to perform file transfer allowing the red team to log in and interact with the target system through HTTP or HTTPS port. Phising attacks can also be performed. 

- We can install Apache with the following commands 
```shell-session
00818@htb[/htb]$ sudo apt install apache2 -y
```

For Apache2, to specify which folders can be accessed, we can edit the file `/etc/apache2/apache2.conf` with a text editor. This file contains the global settings. We can change the settings to specify which directories can be accessed and what actions can be performed on those directories.

- How we can configure an Apache 

**Code: txt**

```txt
<Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
</directory>
```


- This section specifies the default `/var/www/html` folder is accesssible so taht the users can use the idnexes and the `FollowSymLinks` options 
- To change files in this directory can be done with `AllowOverride All`,
- Basically alot 

# Python web server
We can install a python web server as well using this following command
```shell-session
00818@htb[/htb]$ sudo apt install python3 -y
00818@htb[/htb]$ python3 -m http.server
```

When we run this command we have specified that our python server will be started on the TCP/8000 port with this we can access the folder. 

```shell-session
00818@htb[/htb]$ python3 -m http.server --directory /home/cry0l1t3/target_files
```

- This command will start the python on port 8000 which we can acccess on the `/home/cry0l1t3/target_files` directory folder from the browser. 
- We can also host it on another port but we need to specify using the` -p `option in the command

```shell-session
00818@htb[/htb]$ python3 -m http.server 443
```
- This will host it on the server of 443 for example

# VPN 
A Virtual Private network aka VPN as the title suggest its how we can hide our network signal or securely access the network without others seeing our every move. 
- How this is done is when we create a encrypted tunnel connection between the client and the server which means that all data transmitted over this connection would be encrypted. 
- VPNs are mainly used by companies that allow their employees with secure access to the internal network without having to be physically located on the corporate network
- This essentially allows the employee to access the network form any given location without having to be in he specified location 
- most popular VPN servers for Linux servers are **OpenVPN, L2TP/IPsec, PPTP, SSTP, and SoftEther. OpenVPN** is a popular open-source VPN server available for various operating systems, including Ubuntu, Solaris, and Redhat Linux

A penetration tester or a hacker can use VPN to essentially connect tot he internal network which can happen if the VPN access is created by a customer so that they can test the vulnerablities. 

- Openvpn Provides many of the cool features such as **encryption, tunneling traffic shaping , network routing**and the ability to dynamically change networks we can install the server client. 
```shell-session
00818@htb[/htb]$ sudo apt install openvpn -y
```

- Can be customized using the following directory `/etc/openvpn/server.conf`
- This file contains many of the essential settings that a VPN server would need we can change such as **encryption, tunneling, traffic shaping, etc**
```shell-session
00818@htb[/htb]$ sudo openvpn --config internal.ovpn
```


End of page we would conlcusion later 

[[Working with web services]]


[[CCDC notes]]