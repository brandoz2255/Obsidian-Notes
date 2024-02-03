VLSM is for the CCNA 

- VLSM stands for the `V`ariable `L`ength `S`ubnet `M`ask
- This is a design is in which it uses various subnet masks within the same network
- This was made to allow subnet mask to have their own variable size
- hence the name variable length 

# why? use it
- it is the most practical way to use it in the real world with real world examples 
- here are some examples from this very hot lady on youtube 
- ![[Pasted image 20231109230027.png]]
- this is the regular subnetting for a class C network 
- the subnet here is correct however what could be wrong in this certain scenario 
- these all have the same host 
- all of them have the same 62 usable host for that network which means they all have the equal size subnet
- they all have the same number of useable host which could be a big problem in the real world since there is a lot of times where subnets have different sizes or different length 
- example would be the engineering department in a business usaully the engineering department in a business is bigger than lets say the HR department 
- so in that case we would have a different number of hosts for the subnet 
- And if we consider the WAN length as well it only uses 2 usable hosts so if we use this type of subnetting in the real word they would all have the same number of hosts
- in the example provided in the video the engineering depart would need 60 hosts and the HR department would only need 15 hosts 
- this type of subnetting would help the engineering department since the number of host needed are higher 
- where in the HR department this subnet would be good too but there will be alot of unused hosts in the HR field 

## Actual action 
- VLSM 
- ![[Pasted image 20231109231149.png]]
- This is a total of eight networks in this example for the ip of 192.168.1.0/24 
- The set up is going to be for 24 hosts and how the networks are set up in which it has 4 LAN connections and 4 WAN connections 
- each network actually have diffetent sizes of networks which is why we used VLSM
- We need to know the binary chart  
- In order to start subnetting we need to start with the network that has the most number of hosts
![[Screenshot from 2023-11-09 23-17-32.png]]
example of the binary chart however ==mental note we need to look at our prevous notes on subnetting and do the Kettle method on that as well as teh binary chart ==

![[Screenshot from 2023-11-09 23-19-26.png]]
- How she used the chart essentially we need 29 hosts for our first network so we look at what we know since we need 29 we need to look for the block size that is most compatible with our network demands in this case it would be a block size of 32
![[Screenshot from 2023-11-09 23-22-43.png]]
- This is very helpful actually 
- so since we need the block size of 32 we look at the network Ip we are subnetting which is 192.168.1.0 
- since our requirements are 29 hosts the only block size we need is 32 so we add the .32 as our main network for those 32 hosts 
- Then we need a broadcast for that network which is always the one before the initial block size according to the lady so it would be .31 in this case 
- So for the usable hosts in this network would be .1-30 

and for every other network we basically just need to repeat the steps 
- find the block that meets the requirements of the network
- then select t he block size compaptible 
- then we subnet 
![[Screenshot from 2023-11-09 23-27-47.png]]

However if it rerquires the same block size as before like in the videos case in which it required 25 hosts this time we pick the same 32 block size but we need to use the sam network so we increase the increment to 64 block size for the added hosts example

![[Screenshot from 2023-11-09 23-31-01.png]]

next number after that one is the one with 13 hosts in that case using 16 block size 
- Now i fully understand this VLSM since we started with the largets hosts requirement wich was 29 we set the block size to 32 then the next one required 32 blocks as well so we added them to 64 
- In the third times case we would of course add 16 to 64 which would be 80 
- So the third network would be having the .80 ending and im guessing we just subnet the rest like usual ==and yes it is==
![[Screenshot from 2023-11-09 23-36-44.png]]

[[perm.VLSM.notes]]