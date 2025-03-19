## what we will learn 
- reasons for process isolation 
- how Linux has historically done this 
- how containers use namespaces to provide isolation 
- Linux commands to create namespaces specifically 

#### Why processes need isolation 

- The whole idea began when people used to take turns submitting punch cards for a single computation 
- A process itself isnt really a independent program with its own time on the CPU it is shared acrossed the OS 
- One process it self can cause trouble for other processes such as 
	- using  too much CPU 
	- storage, network or memory 
	- orverwriting the memory of another process 
	- Extracting secret information from another process
	- sending another processes bad data 
	- flooding another process with requests so it dies 
- bugs and vulnerabilites are bad  since if there is one on a application that puts the whole machine at risk 
- where an isolated process such as  a container not so much 
- Physical objects need to be air gapped the same goes with processes on a CPU 
#### File permissions and Chroot 

- The whole point of containers is to isolate the process so it doesn't accidentally sees other processes or mess with it on purpose