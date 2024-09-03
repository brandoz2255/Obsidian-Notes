- Inspect the ARP_Poison.pcapng file, part of this module's resources, and submit the first MAC address that was linked with the IP 192.168.10.1 as your answer. 
- basically used the same method for last challenge using the command or dispkay filters to display the information needed since the questioned speicified only the first one we open it and look for the mac address which is 

```Answer
2c:30:33:e2:d5:c3
```

![[Screenshot from 2023-11-28 18-56-30.png]]

``` SYntax
arp.opcode ==2 && arp.dst.proto_ipv4 == 192.168.10.1
```
