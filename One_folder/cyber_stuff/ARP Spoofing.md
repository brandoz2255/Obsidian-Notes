# Network Fundamentals 
When someone walks into a coffee shop and connects the WiFi anyone can see the internet traffic that, that user is using this is called  a technique known as  **ARP Spoofing**. 

- This method exploits the design of the **Address Resolution Protocol** (ARP)  

## Internet structure 
As we recall the differences in what a MAC address is and an IP address is needed to understand how a ARP spoofing works. 

- When a computer connects to the internet it works with trading information between the computer and the router with packets 
- Packets work in which the computers gives the router a computers information and then the router gives that information to the higher ups so it can open a web server for you 
- A packet contains the IP address and the MAC address of your device 

**MAC Address:** The device it self the true name of the device this cannot be changed but it can be faked just a like a fake ID however this is the personal name of our computer 

**IP Address**: The physical location at which your PC is at at the time you open a web server or interact with the internet 

### Internet Hierarchy 
(Laptop --> WiFi) > bobs LAN ---> (tier 3 ISP) > state wide ---> (tier 2 ISP) > country wide ---> (tier 3 ISP) >  global wide ---> (google data center) 

- After the google data center it sends the information right back to those who searched something up
- Tier 3 and bobs LAN are connected usually with DSLAM to provide a good connection when its not connected like that WiFI would be slow 

**DSLAM** aka : **Digital Subscriber Line Access multiplexer**

- Note: All this is possible due to a card that is in a computer the NIC allows the computer to interact with the network   

## How to ARP spoof 

### Arp tables
**ARP Tables** is generally how ARP spoofing is made possible the table it self list the MAC address and IP address of machines on a network 
tcp
- How they are deigned works with taking IP of a MAC to get the IP from a site that the MAC wants to connect to its how the network narrows it down so the user can reach a site 
- Of course this how hackers can misuse this by looking at peoples traffic through the internet they can what site the person has recently been on
- In other the ARP table is a map of MAC in respect to the IP address

### ARP Spoofing Attacks 
The ARP spoofing attacks works with the **Man-In-the-Middle** method to get the users information.  More info on the blue team side of arp spoofing [[Spoofing and abnormality detection]] [[Rogue access point && Evil twin]]

- Man in the middle acts as the hackers machine disguising it self as the network a victum would want to connect to it uses the ARP tables to look at the victums MAC and IP 
	-  The man in the middle can be described as the attacker being between the victim and the router 

- There are two phases to the ARP Spoofing attacks the first phase consits of the attacker sending a fake ARP response 
- The second phase is in which the victim accepted the ARP query from the attacker and begins to make the ARP table of the victim and the network  
 


