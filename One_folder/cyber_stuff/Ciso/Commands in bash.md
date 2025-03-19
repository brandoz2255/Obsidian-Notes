- We can save time from a shell prompt with bash shortcuts 
- The basic command syntax the GNU shell bash is a program that interpretss commands that the user types 
- each string that is typed has thee parts which are the` command` , the `options `[Usually alomost always begin with a hyphen - or double --]and `arguments`
- Each word that is typed into the bash is alwasy sepreated from the other words with spaces. [duhh]
- Commands are names of the programs that are installed with the system 
- Each command has its own argument and options [duhh]
- when you have the correct syntax for the command you are ready to execute 
- example 
```Shell-session
[user@host ~]$ whoami
user
[user@host ~]$
```

- We are already aware of  this command might skip this part 
- New thing we learned to execute a command like more than one in a single line needs to be seperated by a `;` with any command[usually]
- the `date` command is a simple command [duhh]
```shell-session
[user@host ~]$ date
Sun Feb 27 08:32:42 PM EST 2022
[user@host ~]$ date +%R
20:33
[user@host ~]$ date +%x
02/27/2022
```

- You can use the `passwd` command to change the password of course the password you already needs to be confirmed before changing it 
- The super user `sudo` and `su` or `root` can access the passwd to change another users password
- By default the password needs to be strong so remember this 
```Shell-session
[user@host ~]$ file /etc/passwd
/etc/passwd: ASCII text
[user@host ~]$ file /bin/passwd
/bin/passwd: setuid ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=a467cb9c8fa7306d41b96a820b0178f3a9c66055, for GNU/Linux 3.2.0, stripped
[user@host ~]$ file /home
/home: directory
```
- `File` Command which is of course new to us but in this isntance it has uses
- This does not need to have the file name extensions toclassify its file by type 
- the command scans the compiled header fora 2 digit `magic number` and displays its type. text files are recognized they are not compiled 

```Shell-session
[user@host ~]$ file /etc/passwd
/etc/passwd: ASCII text
[user@host ~]$ file /bin/passwd
/bin/passwd: setuid ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=a467cb9c8fa7306d41b96a820b0178f3a9c66055, for GNU/Linux 3.2.0, stripped
[user@host ~]$ file /home
/home: directory
```

-  `cat` This command is often used in Linux. we know the usage of thus command we can open and see the contents of the file 
- However it can also be used to see multiple files and concatenate the contents from various files and redirect contents of the file to a terminal or to files
```Shell-session
[user@host ~]$ cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
...output omitted...
```

- To display the contents of multiple files 
```Shell-session
[user@host ~]$ cat file1 file2
Hello World!!
Introduction to Linux commands.
```

- Some files are too logn to read through the whole thing the `less` command helps with that 
- The `head` and `tail` commands display the begginign of the file and the ends of it 
- by default these commands only display 10 lines however the -n can specify how many lines 
```Shell-session 
[user@host ~]$ head /etc/passwd
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
operator:x:11:0:operator:/root:/sbin/nologin
[user@host ~]$ tail -n 3 /etc/passwd
gdm:x:42:42::/var/lib/gdm:/sbin/nologin
gnome-initial-setup:x:980:978::/run/gnome-initial-setup/:/sbin/nologin
dnsmasq:x:979:977:Dnsmasq DHCP and DNS server:/var/lib/dnsmasq:/sbin/nologin
```
- `wc` Command counts the lines and words and characters in a file
- Use the `-l, -w, or -c` options to display only the given number of lines words or characters
```Shell-session
[user@host ~]$ wc /etc/passwd
41   98 2338 /etc/passwd
[user@host ~]$ wc -l /etc/passwd ; wc -l /etc/group
41 /etc/passwd
63 /etc/group
[user@host ~]$ wc -c /etc/group /etc/hosts
883 /etc/group
114 /etc/hosts
997 total

```

## Understand Tab Completion 
- with Tab completion users can quickly complete commands or file names after typing enough at the prompt to make it unique. 
- if the characters aren't unique then then pressign the tab key twice displays all commands that begin with the typed characters 
```Shell-session
[user@host ~]$ pasTab+Tab1
passwd       paste        pasuspender
[user@host ~]$ passTab 2
[user@host ~]$ passwd
Changing password for user user.
Current password:
```
`press tab twice`

`next press tab once`
-  Tab completion essentially helps to complete file names when typing them as arguments to commands.  
- You can press Tab to complete as much of the file name as possible. 
- presssing tab a second time causes the shell to list all files that the current pattern matches. Type additional characters until the name is unique, and then use tab completion to complete the command 
```Shell-session 
[user@host ~]$ ls /etc/pasTab 1
[user@host ~]$ ls /etc/passwdTab 2
passwd   passwd-
```
- `useradd` command essentally creates users on the sytem the  `useradd`  command has many options that will be hard to remember 
- Using the tab completion can complete the option name with minimal typing

```Shell-seesion
[root@host ~]# useradd --Tab+Tab 1
--badnames              --gid                   --no-log-init           --shell
--base-dir              --groups                --non-unique            --skel
--btrfs-subvolume-home  --help                  --no-user-group         --system
--comment               --home-dir              --password              --uid
--create-home           --inactive              --prefix                --user-group
--defaults              --key                   --root
--expiredate            --no-create-home        --selinux-user
```

## Writing Long command on multiple Lines 
-  Using commands with many options and arguments can quickly become annoying however we could instead type a long commands by using more than one line for easier reading 
- In order to write one command in more than one line we would use a backslash `\` which is known to as the escape character
- the backlash character ignores the meaning of the following 
- In order to add new line of command when in CLI you would press enter after the backslash in the CLI  commands can continue over many lines
```Shell-session 
[user@host ~]$ head -n 3 \
/usr/share/dict/words \
/usr/share/dict/linux.words
==> /usr/share/dict/words <==
1080
10-point
10th

==> /usr/share/dict/linux.words <==
1080
10-point
10th
```
- The `history` we know what this is 
- `!` is a metacharcter  to expand previous commands without retyping them 
- The `!number` command expands to the command that matches the specified number. the `!string` command expands to the most recent command that begins with the specified string 
- The !string command expands to the most recent command that begins with the specified string
```Shell-session
[user@host ~]$ history
...output omitted...
   23  clear
   24  who
   25  pwd
   26  ls /etc
   27  uptime
   28  ls -l
   29  date
   30  history
[user@host ~]$ !ls
ls -l
total 0
drwxr-xr-x. 2 student student 6 Feb 27 19:24 Desktop
...output omitted...
[user@host ~]$ !26
ls /etc
abrt                     hosts                     pulse
adjtime                  hosts.allow               purple
aliases                  hosts.deny                qemu-ga
...output omitted...
```

- the arrows keys will help with navigating through previous commands in the shells history. 
- the up arrow edits and the previous command in the history list 
- pressing `ctrl +A `is a bash shortcut which jumps to the beginning of the command line
- pressing `esc+ `is a shortcut  which copies the klkast argument of previous commands

### Other Important shit

| Shortcut                | Description                                                     |
| :---------------------- | :-------------------------------------------------------------- |
| **Ctrl**+**A**          | Jump to the beginning of the command line.                      |
| **Ctrl**+**E**          | Jump to the end of the command line.                            |
| **Ctrl**+**U**          | Clear from the cursor to the beginning of the command line.     |
| **Ctrl**+**K**          | Clear from the cursor to the end of the command line.           |
| **Ctrl**+**LeftArrow**  | Jump to the beginning of the previous word on the command line. |
| **Ctrl**+**RightArrow** | Jump to the end of the next word on the command line.           |
| **Ctrl**+**R**          | Search the history list of commands for a pattern               |

essentially [[Lab_2]] 


```Shell
## Summary

- The Bash shell is a command interpreter that prompts interactive users to specify Linux commands.
    
- Many commands have a `--help` option that displays a usage message or screen.
    
- You can use workspaces to organize multiple application windows.
    
- The Activities button at the upper-left corner of the top bar provides an overview mode that helps to organize windows and to start applications.
    
- The `file` command scans the beginning of a file and displays what type it is.
    
- The `head` and `tail` commands display the beginning and end of a file, respectively.
    
- You can use tab completion to complete file names when typing them as arguments to commands.
    
- You can use the graphical interface for many administrative tasks. You can disable the interface to preserve resources for running applications.
    
- You can write many commands in the same line by using the semicolon `;` character, and can run a single command in multiple lines by using the backslash `\` character.
```
