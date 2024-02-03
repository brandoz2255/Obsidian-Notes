We can detect Spoofing with hackers attempting to craft there own packets we can tell when something is crafted if doesn't come from our subnet. The IP that is 

- When IP isn't from our same subnet 
- If the IP has a different range than our own 

Hackers do this for the following reasons 

1. **Decoy Scanning:** Change source IP to explore target, evading firewall restrictions successfully.
    
2. **Random Source Attack DDoS:** Flood victim port, exhausting network controls or destination host resources.
    
3. **LAND Attacks:** Set source as destination, exhaust network resources, crash target host.
    
4. **SMURF Attacks:** Send ICMP packets with victim's source, exhaust resources.
    
5. **Initialization Vector Generation:** Capture, decrypt, modify, and inject to build decryption table for attack.

when a hacker wants to enumerate something they might change their IP address when they do this we can notice strange behavior 

1. `Initial Fragmentation from a fake address`
2. `Some TCP traffic from the legitimate source address`