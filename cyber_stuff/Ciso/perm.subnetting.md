## Subnetting taking a step further 
- subnetting is the art or act of dividing a network to allow devices to use the said network such as each devices need its own IP to actively use the network 
	- So this is where subnetting comes from it is ==the act of taking the IP that the device is using and each time a new devices wants to use the network it subnets or divides into a new network to allow access to another device on that network==
	- There is a formula of course to perfoming such action and multiple methods which will be discussed in this permanent notes section 
	- such as this formula provided by the man the myth the legen himself Alberto  $$111111,.111111.00^{0000000.000000000000}$$
	- heres another formula provided by google becuase this formula confuses the shit out me 
	- $$2y-2= num$$
	- where y is the number of bits borrowed 
	- and $$2x-2=num$$
	- where x is the number of bits remaining 
# Variable length
- The process of the Ip being split is whats called the subnet mask 
	- This is called a variable length subnet mask which basically is just what we described before the process of subnetting 
	- Essentially its the segemented piece of a larger network like a divided peice of a much more larger network 
	- This exists since withing a variable length we only have so much IP addresses to give to each individual device 
	- Especially in smaller networks this process is definitely more scarce since in a smaller network they would need to conserve more IP addresses
	- In cases like this we need more than just one network to provide the demand for IP addresses 
	- How do we conserve these IP's 

Through a proces called NAT Which is called network address translation 

## How to Subnet 

- Generally the first step of the process is to find a network in order to subnet and mask
- We would need to list the network into segments if possible of course in order to do this we need to identify the network first like mentioned earlier 

Generally in a home network the most type of network that they use for most home networks is the class C networks these networks usaully use the `198.168.0.0/124` Home networks and class C networks in general also use the` 255.255.255.0 ` ips 

- With this we can now begin breaking these Ips down 
	- in order to do this we need to identify the bits we need to subnet this and the formulas but we could also visualize this with a box 
	- formulas $$2y-2= num$$
	- 32 -28 is usually the ip range however we at this time don't really understand how to use the subnet formula but one day we will we can however explain 
	- Each time a new device is added into a network we see the main network get divided into two masks this is because of the formula is an exponential equation or at Albertos is his makes more sense lets add it 
$$111111,.111111.00^{0000000.000000000000}$$
see so much better the cut in half part makes more sense when we put into a visualization for example our ==cheat sheet==! 


### Cheat sheet
**The best way to visualize the VLSM process we need to make a box and split a section of it into a half each time a device is added**
Another great if we as the user can get a full understanding of this process is this `website` it shows the box without the box so in theory using the box and this site helps with understanding `VLSM` 

- the site [CALC](https://www.davidc.net/sites/default/subnets/subnets.html)
- the box --> ![[IMG_6556.jpg]]
- This is what I mean` its essentially splitting in half each time we add a device to the network `this can also be seen in the website but the site goes all the way by giving out the full IP address of each device added and showing the box but only for the first couple of IPs
- We can do this all the way until we make it to the 32 bits then that us the last IP a device can have\
- ![[Screenshot from 2023-11-09 19-48-00.png]]
	**The websites version is so much different compared to the box but its also so similar the differences is that each division there is also a division for the division its kinda hard to explain but its almost basically the same as the box method**

# Conclusion 
The overall process of the Subnetting is called VLSM  which is justt short for variable length subnet mask. It is just a larger network that gets cut into smaller segments each a device is added to the network in order to conserve IP address. Since each network depending on the size has limited number of IPs to spare to each device and some devices themselves require more than just one IP so thats why the process of VLSM is important. This permanent note covers all the process of identifying networks and the VLSM process as well as putting the theory to the test. 

[[fleet.VLSM.note]]