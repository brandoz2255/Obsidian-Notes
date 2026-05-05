- DNS we know what this is but tis essentially the system in which it coneverts the DNS domain name into the computer readable address the IP adress
- Of course like many things that exist online they have security risks this can be due to a misconfigured DNS nameserver which lead to information beinmg disclosed 

## Dns basics
- DNS is the system that converts the human readable Domain names into the computer readable IP address 
- This process takes place within the  web browser 
- How it works essentially is that the user types the domain such as eg google.com the DNS fetches the IP address and displays the site to the user 
- It does this by checking the local cache for the queried domain name that contains a list of IPs so that it can be used 
- its then stored in the cache so that it doesn't have to go through the pain of loooking for teh IP each time you type the domain 
- The DNS server is giving to the user by the ISP we can also manually   set up our own DNS server 

# Nslookup and DIG 
- Lookup information from DNS servers 
- we can find so much information with this tool such as canonical names IP addresses cache timers 
- nslokup
	- can be used in both windows and unix based OS
	- lookup names and IP addresses 
	- Deprecaeted 
DIG
	- for  finding more advanced Domain information 
	- this should be the first choice 

nslookup example oon sc use in perm notes

we can do a reverse look up jsutnby knwoing the IP addresses we can look up the

dig sc ex \

with we can see the options that were used we can see the quiere and the addresses wefound bthe timeout number andn teh internet address we can se that somebody cahed the ip address it took 29 mil secconds top find teh information 
DIG has beter trouble shooting results 
