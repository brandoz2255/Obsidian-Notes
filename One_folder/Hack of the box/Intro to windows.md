# The Operating System
The Windows Operation system was first developed in the year 1985 on November 20. The windows Operating system is highly based on the Graphical User Interface aka GUI. Windows Desktop introduced the Windows File Manager, Program Manager, and Print Manager programs.

|Operating System Names|Version Number|
|---|---|
|Windows NT 4|4.0|
|Windows 2000|5.0|
|Windows XP|5.1|
|Windows Server 2003, 2003 R2|5.2|
|Windows Vista, Server 2008|6.0|
|Windows 7, Server 2008 R2|6.1|
|Windows 8, Server 2012|6.2|
|Windows 8.1, Server 2012 R2|6.3|
|Windows 10, Server 2016, Server 2019|10.0|

# Remote access
Remote access is as the name implies it allows a user to access a computer from a remote location this done simply by logging in via terminal on a Linux machine but can be done as well in a Windows machine as we have done in Smiths class. 

- Most commonly a remote access is accessed over a network and local access is needed before to access a computer remotely 

# RDP
RDP is a Client server architecture where a client side application is used to specify a computers target IP address or hostname ove a network where RDP access is enabled.  The Target computer where this access is enables is considered the server 

- The default logical port for the RDP is port `3389` 
- We can use RDP to connect to  windows desktop via Linux or windows. 

# xfreerdp
This is a tool in linux on how we can connect to a remote desktop in windows. Allows us to connect remotely and we can freely manuever around the  system. 

- With `xfreerdp` we can transfer files to and from the host which gives a xfreerdp an advantage

The overall Syntax and use age for Free rdp 
```shell-session
00818@htb[/htb]$ xfreerdp /v:<targetIp> /u:htb-student /p:Password
```


# Command Line
In windows it uses a different set of commands howeve most of evrything is done within  the CLI but useful information can be found within the CLI like using the `TREE `command 

```cmd-session
tree c:\ /f | more
```

- This command is helpful for finding things in s specific drive we can look at the tree and determine where are our target is