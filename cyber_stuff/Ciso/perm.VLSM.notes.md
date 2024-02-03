# VLSM Method 
[source](https://www.youtube.com/watch?v=IgthYZ9N1vs)
The `VLSM` method of subnetting comes from the idea of taking the main network and then dividing it into smaller networks called usable hosts 

The VLSM stands for Variable length sub-net mask which is designed to work in a scenario in which it uses various subnet masks within the same network
	- The name variable length comes from the idea that with this method allows the subnet mask to have their own respectful variable size 
	- Which is why its called Variable length subnet mask
	- This works not only theoretically but is highly encouraged in the real world to use this method especially in business with large networks
## Its Purpose
The purpose for the VLSM as mentioned before it is more practical than other methods of subnetting especially in==large businesses== 

Its also the most practical way to practice subnetting in theory and putting it to the test while harnessing the knowledge of networking since this puts you in a hypothetical environment that is useful to learning how subnetting works

In a class C type of network the IP would be something like 192.168.100.0 
- Leaving the .0 as room for subnetting as mentioned later in this note 
-  ![[Pasted image 20231109230027.png]]
Lets take a deeper look at this snapshot of this video explaing the purpose of VLSM subnetting 
	- Here we can see that all of them (them being the usuable hosts) have the same host which is the network of 192.168.100
	- we can see that each network address in this regular subnetting has 62 hosts available for use
	- Since they all have the same number of useable hosts this could pose a problem in the real world 
	- Since in alot of business this really isnt needed since in different scenarios each network host in the real world have different sizes and different lengths 
- One such example is in a scenario in which a business has two departments the engineering departments and the HR departments 
- The department that will require the most hosts usage would be the engieering department since their staff is simply much larger 
- However in the case for the HR Department they are smaller when compared to the engineering department so having alot of unusable hosts would pose a problem
One key thing to remember for most business they  use a WAN connection so having multiple unsuable hosts for a network that only uses two hosts is a bad design 
## Subnet Action
In our example case we are using this subnet method to help set up a network for a business that needs a network for the engineering team this is the overall look of what the scenario is 
![[Screenshot from 2023-11-09 23-58-11.png]]

- In this example we use a regular class C type of network to get our heads familar with the idea of subnetting with the VLSM method 
- the target IP is 192.168.1.0 in case we forget something inportant here is that the .0 is the room for subnetting 
- we can see that for this chart we have the network using 24 bits 
- In order to begin subnetting  we must follow these steps first \
![[Screenshot from 2023-11-09 23-27-47.png]]
1. **Start with the most number of hosts
2. select the nearest block size 
3. start subnetting 

Example: Looking back at the graph we see the larget number of hosts given is LAN 3 which has the number of hosts at 29 

- to begin subnetting we first need to pick a correct block size that fits the number of hosts we need 
- We can do this by using a chart 
- ![[Screenshot from 2023-11-09 23-17-32.png]]
- this chart is definitely useful for our scenario 

**When we are subnetting it is important to use the correct block size for our subnet mask in this case it would be the block 32 since our LAN 3 Connection is requesting 29 hosts 

- Then the subnetting process can begin 
![[Screenshot from 2023-11-09 23-22-43.png]]
Since we used the 32 block size the .0 ending of our IP would change to the .32 ending since this is the block size we chose to fit 29 usuable hosts
	- In order to subnet this we need the main network so that would be the .32 address
	- then we need a network to broadcast this from generally it is always the one before the main network in this case its .31
	- That leaves us at the hosts network going from .1 to .30 giving us a total of 30 usuable hosts in this network
For subnetting the rest of the network we would simply do the same thing like rince and repeat the same steps
![[Screenshot from 2023-11-09 23-31-01.png]]
Look in this example on the second biggest host requirement which was LAN 5 with the hosts of 25
	- So we just repeat
	- choose the block size that fits 25 hosts 
	- In this case it would be the block size of 32 again so we just choose that 
	- However here is where the steps change in which since the mask of .32 already exist and we are just adding another .32 we need to have the network at .64 since that is the sum of the blocks
	- then we give the broadcast to .63 and have usable hosts from .33 to .62 
Now we would need to add the sum of blocks each time we subnet since we are of course adding new blocks into our network 
**For example after this we would go for LAN 4 which has 14 hosts and for those 14 we would use the block size of 16 to get 16 more usable host for those 14 requirements 
Essentially we would add 64 with 16 = 80 so our network LAN 4 would end with .80 then we subnet it like usual with the broadcast at .79 etc. 

# Conclusion 
Overall Subnetting is not much of a confusion process as a whole it is tedious but makes sense in the long run. The part where most would get confused on is the VLSM. Since it results in the idea that the main network being divided into other networks to be used at usable hosts. 


[[lit.VLSM.note]]