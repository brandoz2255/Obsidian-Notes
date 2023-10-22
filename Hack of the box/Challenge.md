 Excel one privilege user by simply adding the u function to the scrip of sudo for more information of course and keep this in mind for all future references always go back to look at the man pages 

``` Shell session
sudo -u user2 /bin/bash
```
then the flag.txt can be opened 
next is gaingin acess to root which will be used by the chmod command
by simply chmod the id_rsa in the machine [my hyposthesis is doing it as user2 then leaving and re ssh-ing to the ip as the root user with the id_rsa key but will get back to it] [Ok theory did not work opened the ssh key created a file with vim with the same ssh key then chmod the file and then did the ssh with the key]

``` Shell
sudo chmod 600 id_rsa
```

``` shell
ssh root@REMOTE_IP -p port -i id_rsa
```
  
  *  First ssh onto the IP  
  * next enter password 
  * Find a way to open flag.txt