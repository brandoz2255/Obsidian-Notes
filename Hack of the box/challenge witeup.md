For this challenge we used 
 ``` bash
  systemctl list-units --type=service
```
to look at all the services running and look at the type and descrioption however the challenge had us find  a specific descriotion to look for a specific type of service 

- Using the `grep` command helped out a lot with this we just grepped the description to find the name of the service we were looking for