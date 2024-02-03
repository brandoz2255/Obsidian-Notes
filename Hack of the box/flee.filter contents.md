# Filter contents 
For  a while we have only been using a tool called ==cat== to get the information of a file. Whenever we would want to see inside the contents of a file in the Terminal we would alwasy use ==cat==. However there are more tools that we can use
	- A tool such as ==more==
	- and a tool such as ===less==
These tools are also helpfull when it comes to getting information within the contents of a file.
These are fundametnal pagers that essentailly allow us to scroll through the file in an interactive view 
## more
- to use more we would need to read the file first with the cat tool or we could use more with the path fule 
```shell-session
00818@htb[/htb]$ more /etc/passwd
```
```shell-session
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
<SNIP>
--More--
```

we can leave this page with the q key 
## Less
- The less command when we use the man page we can see that  it contains more features than the `more` statement 
```shell-session
00818@htb[/htb]$ less /etc/passwd
```

```shell-session
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
<SNIP>
```

- the way it is presented is almost jsut the same as the more command 

# Head
Usually when going around in the file system we would sometimes be only interested in issues at the beginning of the file or at the end 
- to get the only beginning of the first ten lines in a file we would use `head` command
- we can specify what it can print out but if  we don't it would only print out the first ten lines
```shell-session
00818@htb[/htb]$ head /etc/passwd

root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
```
# Tail
- essentailly is the exact opposite of head it shows only the last few lines of the file such as the last ten
```shell-session
00818@htb[/htb]$ tail /etc/passwd

miredo:x:115:65534::/var/run/miredo:/usr/sbin/nologin
usbmux:x:116:46:usbmux daemon,,,:/var/lib/usbmux:/usr/sbin/nologin
rtkit:x:117:119:RealtimeKit,,,:/proc:/usr/sbin/nologin
nm-openvpn:x:118:120:NetworkManager OpenVPN,,,:/var/lib/openvpn/chroot:/usr/sbin/nologin
nm-openconnect:x:119:121:NetworkManager OpenConnect plugin,,,:/var/lib/NetworkManager:/usr/sbin/nologin
pulse:x:120:122:PulseAudio daemon,,,:/var/run/pulse:/usr/sbin/nologin
beef-xss:x:121:124::/var/lib/beef-xss:/usr/sbin/nologin
lightdm:x:122:125:Light Display Manager:/var/lib/lightdm:/bin/false
do-agent:x:998:998::/home/do-agent:/bin/false
user6:x:1000:1000:,,,:/home/user6:/bin/bash
```

# Sort
- we can sort through the information we get in a file using the sort command this one is used in the same way we would use the grep command 
- We can look at results alphabetically or numerically to get a better overview
```shell-session
00818@htb[/htb]$ cat /etc/passwd | sort

_apt:x:104:65534::/nonexistent:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
cry0l1t3:x:1001:1001::/home/cry0l1t3:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
dnsmasq:x:107:65534:dnsmasq,,,:/var/lib/misc:/usr/sbin/nologin
dovecot:x:114:117:Dovecot mail server,,,:/usr/lib/dovecot:/usr/sbin/nologin
dovenull:x:115:118:Dovecot login user,,,:/nonexistent:/usr/sbin/nologin
ftp:x:113:65534::/srv/ftp:/usr/sbin/nologin
games:x:5:60:games:/usr/games:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
htb-student:x:1002:1002::/home/htb-student:/bin/bash
<SNIP>
```

# Grep
- To look for  a very specified results we can use the `grep` command which offers many features in this example we can look for users who use the default shell
```shell-session
00818@htb[/htb]$ cat /etc/passwd | grep "/bin/bash"

root:x:0:0:root:/root:/bin/bash
mrb3n:x:1000:1000:mrb3n:/home/mrb3n:/bin/bash
cry0l1t3:x:1001:1001::/home/cry0l1t3:/bin/bash
htb-student:x:1002:1002::/home/htb-student:/bin/bash
```
- we can use the -v option with grep to look for a specific suers who has disabled the default shell
```shell-session
00818@htb[/htb]$ cat /etc/passwd | grep -v "false\|nologin"

root:x:0:0:root:/root:/bin/bash
sync:x:4:65534:sync:/bin:/bin/sync
postgres:x:111:117:PostgreSQL administrator,,,:/var/lib/postgresql:/bin/bash
user6:x:1000:1000:,,,:/home/user6:/bin/bash
```

# Cut 
-  Furthermore lets say we want to find something in a file but there are alot of delimiters and we just wants words in a specified position 
- we use `cut` for this example with `cat` and `grep` however in the man we must use the -d and -f options and specify our needs with the `:` 
```shell-session
00818@htb[/htb]$ cat /etc/passwd | grep -v "false\|nologin" | cut -d":" -f1

root
sync
mrb3n
cry0l1t3
htb-student
```

# Tr
- Another tool we can use to replace certain characters from a line with characters defined is the tool `tr` 
- the first option we would define the character we want to replace in the second option would put the character we want to replace it with
```shell-session
00818@htb[/htb]$ cat /etc/passwd | grep -v "false\|nologin" | tr ":" " "

root x 0 0 root /root /bin/bash
sync x 4 65534 sync /bin /bin/sync
mrb3n x 1000 1000 mrb3n /home/mrb3n /bin/bash
cry0l1t3 x 1001 1001  /home/cry0l1t3 /bin/bash
htb-student x 1002 1002  /home/htb-student /bin/bash
```
# Column
- the column command just displays the lists in a column hence the name but only with the option -t but always look at the man pages
```shell-session
0818@htb[/htb]$ cat /etc/passwd | grep -v "false\|nologin" | tr ":" " " | column -t

root         x  0     0      root               /root        /bin/bash
sync         x  4     65534  sync               /bin         /bin/sync
mrb3n        x  1000  1000   mrb3n              /home/mrb3n  /bin/bash
cry0l1t3     x  1001  1001   /home/cry0l1t3     /bin/bash
htb-student  x  1002  1002   /home/htb-student  /bin/bash
```

# Awk 
- Displays the the first $1 and last $NF 
```shell-session
00818@htb[/htb]$ cat /etc/passwd | grep -v "false\|nologin" | tr ":" " " | awk '{print $1, $NF}'

root /bin/bash
sync /bin/sync
mrb3n /bin/bash
cry0l1t3 /bin/bash
htb-student /bin/bash
```

# Sed
- This command `Sed` is for when we would want to change specific names in the whole file or standard output 
- the common use for this command is subsituting text 
- example
```shell-session
00818@htb[/htb]$ cat /etc/passwd | grep -v "false\|nologin" | tr ":" " " | awk '{print $1, $NF}' | sed 's/bin/HTB/g'

root /HTB/bash
sync /HTB/sync
mrb3n /HTB/bash
cry0l1t3 /HTB/bash
htb-student /HTB/bash
```
- the `s` flag at the beginning stands for the subsitute command 
- then the pattern would be specified after the `/` then we  enter the pattern we want to replace and we finnaly use the `g` flag to replace all matches 
# Wc 
- to avoid counting lines or characters we would use the `wc` command
```shell-session
00818@htb[/htb]$ cat /etc/passwd | grep -v "false\|nologin" | tr ":" " " | awk '{print $1, $NF}' | wc -l

5
```
- using the `-l` option we specify the lines  

 Determine what user the ProFTPd server is running under. Submit the username as the answer. 
 ```shell-session
  ps aux | grep proftpd
proftpd   1732  0.0  0.1 126448  3668 ?        Ss   04:59   0:00 proftpd: (accepting connections)
htb-stu+  6286  0.0  0.0  14864  1052 pts/0    S+   05:51   0:00 grep --color=auto proftpd

```
