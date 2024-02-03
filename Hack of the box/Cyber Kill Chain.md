# What is the kill chain
![[Screenshot from 2023-11-20 14-08-51.png]]
- The kill chain consists of 7 different stages 
- Essentially the Kill chain is the process on how we describe the thinking process of an attacker and how they manifest 
- With understanding the life cycle we can have insight in how far the attacker is on our system

**Recon**: This is the enumeration stage of the process in the pen testing or attacking thought process. can be used in other stages as well
- Essentially its the process of gathering as much information as possible on the target machine
- This done via a passive mode and aggressive mode 
- The passive has using open source knowledge to gather information 
- The arggressive is actively 

**Weaponize:**
- The malware phase of the attackers mindset how this works essentially is after the Recon phase then they use the malware 

**Delivery**: 
- It is essentially the stage in which they send the malicious  weapon that they used or formulated in the weaponized stage and they figure out a way to send it to the system
- basically how they send it to the system 

**Exploitation**:
- This stage is after the delivery process in which they run the exploit they found in the weaponize and run the exploit that was delivered in the delivery stage

**Installation**: 
- This is basically that the attacker is already on the target machine and doing their thing depending on their goals 
	- Droppers - Deliver malware to the system
	- backdoor - essentially how an attacker has access to they system to take info
	- Rootkits - Delivered through a dropper or delivery stage hides malware

**C&C**: Or C2
- The command and control This is when the attaker has the remote access to the system they can literal write unauthorized commands within our system 

**Action**:
- the overall objective of each attack

