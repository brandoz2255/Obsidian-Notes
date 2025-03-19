A continuation of the previous note describing the blue team side of using `wireshark` and how we can **detect if our network is being hacked** using of course `wireshark`. 


## Analyze packets from our firewall 
`Wireshark` and `tcpdump` are two tools used to see how we can creates files to view packets.  

- Port 80 and port 443 are two ports we would focus however *443* is used for encrypted `https` where *80* is `unencrypted` 

- on our virtual environment (which we will make later) we must go on a site and then open our firewall `pfsense` 

we will see a lot of options in the CLI however navigate to 8 which is the shell for the firewall 

- Next we run tcpdump in the shell we don't need any flags for the command since the firewall knows what to do it will capture all the packets on the site we went 
- `tcpdump tcp port 443` is how we can look at port 443 

```shell
tcpdump -i <interface> -s <# of packets to capture> -w <file.pcap> 
```

- we can use `wireshark` to look at suspicious activity however https://packettotal.com will find suspicious  traffic in the `.pcap` file 


cool exercsises on page 44 and 45 check them out!! wireshark usage exercise and firewall usage exercise some blue teaming experience we need 