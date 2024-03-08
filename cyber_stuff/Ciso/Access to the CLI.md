|                |                                                                                                                                                                                                                                                                                                |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Goal**       | Log in to a Linux system and run simple commands from the shell.                                                                                                                                                                                                                               |
| **Objectives** | - Log in to a Linux system and run simple commands from the shell.<br>    <br>- Log in to the Linux system with the GNOME desktop environment to run commands from a shell prompt in a terminal program.<br>    <br>- Save time when running commands from a shell prompt with Bash shortcuts. |
| **Sections**   | - Access the Command Line (and Quiz)<br>    <br>- Access the Command Line with the Desktop (and Guided Exercise)<br>    <br>- Execute Commands with the Bash Shell (and Quiz)                                                                                                                  |
| **Lab**        | Access the Command Line                                                                                                                                                                                                                                                                        |



- The is as we know the way to use the System without access to the GUI 
- The way the sytem allows access to the CLI is through a shell there are many types of Shells but I went more in depth on each type in Hackthebox [[Shells]]
- The default user shell is teh GNU Bourne-Again Shell (bash). 
- The regular user who is a non root user has the string with the [$] the Root user has the [#]
- Using bash to execute commands is powerful in Linux 
- when running a command we must mind the Sytnax always mind the argument the command and the option the MAN pages or --help
- The terminal is how you access the CLI in order to activiate it crtl alt f1 to f6 
- SSH to login remotely you know most of this shit refer to [[_Hack the Box_]]
```Shell
[user@host ~]$ ssh -i mylab.pem remoteuser@remotehost
[remoteuser@remotehost ~]$
```
- This is the SSH options which can be found looking at the MAN pages which is just full use of the SSH
- Logging into the SSH without the use of the password you need to have a public key that matches the 

[[Access the CLI in desktop ]]

