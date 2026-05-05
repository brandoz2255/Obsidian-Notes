When delving into detecting anomalies in the network specifically detecting fragmentation attacks we need to look at the IP layer 

- The `Ip layer` is responsible for transferring packets between machines however this layer doesn't help with looking at tampered packets
- The application layer is needed to look at the packets to check if they have been tampered with 
- We need to explore some packets fields to determine what happened 

1. `Length - IP header length`: This field contains the overall length of the IP header.
2. `Total Length - IP Datagram/Packet Length`: This field specifies the entire length of the IP packet, including any relevant data.
3. `Fragment Offset`: In many cases when a packet is large enough to be divided, the fragmentation offset will be set to provide instructions to reassemble the packet upon delivery to the destination host.
4. `Source and Destination IP Addresses`: These fields contain the origination (source) and destination IP addresses for the two communicating hosts.

## Commonly abused fields 

-  Attackers might craft packets to disrupt communication across machines 
- we need to look at these fields to develope a understanding on how we can detect their mis-use 
- Attacker also needs to by pass the IDS control we need to look at fields to understand how they did this if they did 

## Abuse of Fragmentation 
Fragmentation is like breaking a large message into smaller parts for efficient communication, ensuring each part fits a standard size. The destination is then instructed on how to piece these parts together in the correct order.

MTU is how these data sets are divided here is how hackers would abuse this field 

1. **IPS/IDS Evasion:** Fragmented attacks bypass detection; control reassembly for prevention.
    
2. **Firewall Evasion:** Attackers use fragmentation to evade firewall controls; reassembly is crucial.
    
3. **Resource Exhaustion:** Fragmentation with small MTU strains controls, aiding attacker's enumeration efforts.
    
4. **Denial of Service:** Old hosts vulnerable; malicious fragmentation induces successful denial-of-service attacks.

If our network performs intented it should 

IDS/IPS/Firewall waits for all fragments before reconstructing for inspection.

## Finding irregularities

We would use Wireshark to find the above mentioned irregularities. 

```Wireshark
00818@htb[/htb]$ wireshark nmap_frag_fw_bypass.pcapng
```

Multiple ICMP request is what a simple `Nmap` scan looks like 

```Nmap
00818@htb[/htb]$ nmap <host ip>
```

- example of `nmap` enmuration syntax 

```Nmap 
00818@htb[/htb]$ nmap -f 10 <host ip>
```

![[20231228_18h29m08s_grim.png]]

- This how `wireshould` would detect a `nmap` scan of the one we see in the aforementioned command 

![[20231228_18h32m42s_grim.png]]

- A clear cut example of a fragmentation scan 