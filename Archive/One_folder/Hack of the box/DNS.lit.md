[[Ciso/fleet.site&&vid]]
[vid](https://www.youtube.com/watch?v=CRa8lx0IsDY)
[site](https://resources.infosecinstitute.com/topics/hacking/dns-hacking/)
# DNS basics

 We already know that the DNS is the phone book of the internet hosting many addresses for the Domain names of web sites what we slightly knew but got more info on is how it works lets get a run down on this process 
	 - DNS is the system that  tells the computer to look at the Domain name and fetch the associated IP address for the  domain name 
	 - it converts teh human readable Domain to the Computer read able IP address so that it could display the website for you
	 - This process happens within the web browser
	 - It does this process by checking the local cache for the queried domain name that contains the list of IPs that can be used  
	 - Then it stores this cache so that the next time we look up something it doesn't go through the process of finding another IP address again 

However IP addresses have expiration dates so when the IP address expires it would the same process mentioned before and just store a new one. 
	- Also the DNS server is given by our ISP (internet service provider) pr we could set up our own ISP 

# Nslookup and DIG 
With the Nsloookup tool like before we could find out so much information from DNS servers such as the canonical names IP address and cache timers 
- This toool can be used in both  windows and Unix based OS however for windows its more harder to set up 

Here is an example of using Nslookup 
![[Screenshot from 2023-11-14 18-42-20.png]]
-  With the infomation provided we can do a reverse look up for more information on the  server 

DIG on the other hand is a much more reliable tool since it does what its name implies it DIGS for more information on the DNS server 

![[Screenshot from 2023-11-14 18-44-22.png]]
See how with DIG we found more specific information on the topic at hand b here we can see the options we got. Such the quieres and the adresses to the DNS server we also found the timeout number for the IP address which is what i mentioned beforre we can also see that it took 29 milisecs to do this. 