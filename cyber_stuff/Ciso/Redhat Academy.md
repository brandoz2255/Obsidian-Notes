
# Index #2

[[what is Linux]]

[[Access to the CLI]]

[[Linux File System]]

[[Commands in bash]]

[[Specify Files]]

[[Access the CLI in desktop ]]

[[_Hack the Box_]]



## Orientation for the classroom envirement 
-  For the redhat Academy the main hands on learning we will be doing in the class will in the workstation and students will need to use servera and serverb 
- the password and username for these is student yes for both 
- the root password however is redhat

### Classwork Machines 

|Machine name|IP address|Role|
|:--|:--|:--|
|bastion.lab.example.com|172.25.250.254|Gateway system to connect the student private network to the classroom server (must always be running)|
|classroom.example.com|172.25.254.254|Server that hosts the required classroom materials|
|workstation.lab.example.com|172.25.250.9|Graphical workstation for student use|
|servera.lab.example.com|172.25.250.10|Managed server "A"|
|serverb.lab.example.com|172.25.250.11|Managed server "B"|

- The function Bastion acts as a router so if this down all the other student machines wouldn't be able to work
- Note when acessing Servera or serverb ignore the message of activating cockpit
- Only use shutdown to preserve the disks 

