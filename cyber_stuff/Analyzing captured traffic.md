To analyze captured traffic from the arp spoofing we did in the arp spoofing chapter we must use two tools `tcpdump` and `wireshark` to analyze unencrypted packets 

- `Wireshark` can also be used to analyze what went wrong on the coffee shops part however not every coffee shop knows what is `wireshark` 
- We will also learn about tne internet protocol and how the protocol works 

## Protocols
Think of protocols as a set rules that govern the communication between machines as in our civilized society we have proper rules for communicating with each other so do machines. 

- For humans we begin with a hello then introduction of ourselves well so do the machines they begin with handshake and then exchange information

- It starts with the DNS system where the domain name is introduced and then begins the DNS query looking for the IP associated with the Domain name of the site 

- Since the IP address is the only way that the computer can read the site and display the contents to the user the domain is so that a human can easily look up the site without having to manually type the IP address every time they want to go to google 

This process is done via a port on the machine and each packet shows the specific prot that it needs to connect to on the machine to connect the IP 

- A port is an easy for an attacker to inject unwanted malware onto your system an easy to atttack a machine its the first step to hacking find an open port 

## Five Layer internet protocol stack

Engineers that created the internet meticulously hand crafted the internet so that lit can handle the process of transferring information across systems seemingly easy. They did this with the 5 layer Internet Protocol. 

- Cool thing about each layer they don't interfere with one another they were design to not interrupt each other 

**Application Layer**:  Interacts with the user via application/web providing services 

**Transport Layer**: Manages the flow data between the the users machine and the main server end to end communication of data . 

**Network Layer** :  routes packets between networks in charge of the traffic of packets between the networks

**Data Link Layer**: Data link is responsible for the link between two nodes directly connected managing the physical medium and error detection 

**Physical Layer:**  physical connection of binary data to the machine such as cables or the `nic` of a machine 

## Wireshark 

Wireshark is a tool  on  how  a person can look at the packets that have gone through your `nic`. Which makes it an excellent tool for analyzing traffic.  

- We can Open up  wireshark with the applicatons section or by also going into the terminal and typing `sudo wireshark` 
- `eth0` represents **Ethernet** in `wireshark` as `wlan` represents **WiFi** and lo represents `loopback` interface 
- `loopback` interface is how we can redirect traffic back to the machine itself 

One thing we must recall from the **ARP spoofing** attack chapter is just when we **intercept all the packets** from a *victim* computers directly to our *nic* and the `OG` packets go back to the victim leaving them unaware of the situation. 

- One thing to note when we are on the wireshark and don't have a specific file we want to look at and manually capture and look at packets we must press the shark icon 
- Then when we open a site we can view packets we can stop capturing packets by pressing the red button


## wireshark filters 

`ip.dst == IP_ADDRESS`

This is a general syntax for just looking at packets accociated with the IP address 

General syntax for wireshark filters 

```wireshark
[protocol].[header/field] [operator value +=-||] [value]
```

```wireshark
ip.src == 192.168.1.101
```

- example of syntax usage 

it doesn't need to be that complicated here is an example of looking for `tcp` logins 

```
tcp contains login
```

