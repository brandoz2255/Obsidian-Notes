A Rogue access point is essentially how a attacker gets into a network by adding  remote unauthorized access point to allow unauthorized users into the network. 
[[ARP Spoofing]]
- DOS attacks can occur when this Rogue access point is established onto the network 
- Also can be done by a man on the inside such as an employee setting it up to destroy the network

![[Screenshot from 2023-12-03 21-43-16.png]]

## Evil twin attack 
- An evil twin closely similar to what a man in the middle attack is which its an attack that occurs when the attacker isn't essentially on the network its self but attacking via web sever

![[Screenshot from 2023-12-03 21-56-43.png]]

- It works by setting up the web server as a remote access point tricking the victim that it is a trusted site and then they get into the victims pc and get information they need(attacker)

#### Detect Evil twin with airng

```bash
00818@htb[/htb]$ sudo airodump-ng -c 4 --essid HTB-Wireless wlan0 -w raw

 CH  4 ][ Elapsed: 1 min ][ 2023-07-13 16:06    
 BSSID              PWR RXQ  Beacons    #Data, #/s  CH   MB   ENC CIPHER  AUTH ESSID
 F8:14:FE:4D:E6:F2   -7 100      470      155    0   4   54   OPN              HTB-Wireless
 F8:14:FE:4D:E6:F1   -5  96      682        0    0   4  324   WPA2 CCMP   PSK  HTB-Wireless 
```

- This How we can check for a Evil twin using the airodump ng  
- How we can tell is that there are two different MAC's so an attacker created an evil twin for HTB-Wireless 

- This is an example of a `hostil portal attack` in which attackers create a portal to steal credentials from employees/victim  

- we can double check with `(rogueap.cap)` type this into the cmd bar `(wlan.fc.type == 00) and (wlan.fc.type_subtype == 8)`

![[20231225_15h08m08s_grim.png]]

- Beacon analysis is imnprotant for differentiating the acess points RSN (Robust securty Network) is important for data communicating with the clients about supprotedd ciphers and other things

 ![[20231225_15h11m11s_grim.png]]
 - this is how we examine our access points to get the RSN information

This image should indicate that the WPA2 is supported with the standard [[AES]] and [[TKIP]] in conjunction with [[PSK]] as its authentication mechanism



![[20231225_15h33m41s_grim.png]]

mosts evil twin attacks will represent this and what we have defined before with the encryption instances to make it harder to detect its an evil twin 

### FInding a Fallen user 

Even with security trainign some users will fall victim to the evil twin we can find the fallen user that fell victim to this attack with this filter 
`(wlan.bssid == F8:14:FE:4D:E6:F2)`

![[20231225_15h37m35s_grim.png]]


- if an ARP request is detected form a suspicious network its definitely a sign of a security issue 

1. `Its MAC address`
2. `Its host name`

