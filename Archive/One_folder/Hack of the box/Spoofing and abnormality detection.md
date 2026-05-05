## ARP && Abnormality Detection 

- ARP stands for the Address Resolution Protocol  is a communication protocol that is used in Computer networks to essentially map a IP address and connect it to a MAC address
- If we remember correctly is that the MAC address is essentially the finger print of a computer and the IP address is the literal home address of the person (computer)

## How Address Resolution Works 
- What gave birth to ARP is the MAC address and the need to send the data 

![[Screenshot from 2023-11-27 15-25-24.png]]

|*Step*|*Description*|
|---|---|
|`1`|Imagine our first computer, or Host A, needs to send data to our second computer, Host B. To achieve successful transmission, Host A must ascertain the physical address of Host B.|
|`2`|Host A begins by consulting its list of known addresses, the ARP cache, to check if it already possesses this physical address.|
|`3`|In the event the address corresponding to the desired IP isn't in the ARP cache, Host A broadcasts an ARP request to all machines in the subnet, inquiring, "Who holds the IP x.x.x.x?"|
|`4`|Host B responds to this message with an ARP reply, "Hello, Host A, my IP is x.x.x.x and is mapped to MAC address aa:aa:aa:aa:aa:aa."|
|`5`|On receiving this response, Host A updates its ARP cache with the new IP-to-MAC mapping.|
|`6`|Occasionally, a host might install a new interface, or the IP address previously allocated to the host might expire, necessitating an update and remapping of the ARP cache. Such instances could introduce complications when we analyze our network traffic.|

- ARP gets the MAC just from a IP address coming from a local network 
## ARP Poisoning & Spoofing 

Remember later Rate limiting 
cyber@jb122

-  When looking for attacks or someone exploiting vulnerabilities in ARP is called Indicators of Compromise (IOCs) 
- The art of ARP spoofing happens when the malicious attack sends false ARP messages over the LAN in order to link the attackers MAC to the IP of a legitimate Device on the network 
- Detecting the attack of an ARP traffic is difficult since it mimics the natural laguage and method of a normal ARP traffic However we can better identify them with these steps 

|*Step*|*Description*|
|---|---|
|`1`|Consider a network with three machines: the victim's computer, the router, and the attacker's machine.|
|`2`|The attacker initiates their ARP cache poisoning scheme by dispatching counterfeit ARP messages to both the victim's computer and the router.|
|`3`|The message to the victim's computer asserts that the gateway's (router's) IP address corresponds to the physical address of the attacker's machine.|
|`4`|Conversely, the message to the router claims that the IP address of the victim's machine maps to the physical address of the attacker's machine.|
|`5`|On successfully executing these requests, the attacker may manage to corrupt the ARP cache on both the victim's machine and the router, causing all data to be misdirected to the attacker's machine.|
|`6`|If the attacker configures traffic forwarding, they can escalate the situation from a denial-of-service to a man-in-the-middle attack.|
|`7`|By examining other layers of our network model, we might discover additional attacks. The attacker could conduct DNS spoofing to redirect web requests to a bogus site or perform SSL stripping to attempt the interception of sensitive data in transit.|

`Static ARP Entries`:  Manually creating ARP entries for the critical devices on our network make sure that the correct MAC is for the specific IP. 


`Switch and Router Port Security`: restrict the number of MAC addresses on a single port preventing attackers from connecting 

## Installing TCPDump
- To capture the network traffic and look at the ARP we must use either `tcpdump` or `wireshark`(used mostly for windows)
- Usually in Linux tcp dump is located in `/usr/sbin/tcpdump`. 

#### Installation 

```shell-session
00818@htb[/htb]$ sudo apt install tcpdump -y
```

##### Example
```shell-session
00818@htb[/htb]$ sudo tcpdump -i eth0 -w filename.pcapng
```

- `-i `option specifies our network interface with the switch 
- `-w `specifies the capture rule using the switch

### Finding ARP Spoofing 
- for this example we would use the file we got from HTB using Wireshark

```shell-session
00818@htb[/htb]$ wireshark ARP_Spoof.pcapng
```

- Then in the GUI we filter it with the `arp.opcode` command 

![[Screenshot from 2023-11-28 17-35-36.png]]

- In order to find ARP Spoofing we must consider the red flags such as one IP consistenly sending requests to a specific  MAC or IP like as in more than usual 
- Especially when they didn't ask for it this is a telltale sign of ARP spoofing
- For example look at the image `08:00:27:53:0C:BA` is behaving suspicously since it has been sending out requests so many times

A Wireshark functionality can help fine tune our analysis in which --> 

1. `Arp.Opcode == 1`: This represents all types of ARP Requests
2. `Arp.Opcode == 2`: This signifies all types of ARP Replies

Option 1: This option tells `Wireshark` to capture all of the requests packets so we can look at the devices asking for the MAC given an IP on the network 


Option 2:  This option looks at the ARP reply packets useful for looking at cases in which devices are responding with the correct MAC to a requested IP address 

In case we find two MAC on the same IP which is bad we can confirm this with a LInus system with this command syntax 

```shell-session
00818@htb[/htb]$ arp -a | grep 50:eb:f6:ec:0e:7f

? (192.168.10.4) at 50:eb:f6:ec:0e:7f [ether] on eth0
```

``` Shell-session 
arp.duplicate-address-detected && arp.opcode == 2
```


[[Identify original IP addresses ]]

