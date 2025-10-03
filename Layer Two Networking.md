- Step one SYN Client -> server
	- sens a TCP packet with a SYN flag
	- Includes ISN random number for tracking packets
	- "I want to connect, heres my starting sequence number"
- SYN-ACK(Server -> client)
	- Server sends TCP packet with SYN flag set
	- Includes servers own ISN + acknowledgement
	- "I got your request, hrees my sequence number Im ready"
- ACK (Client -> server)
	- Clients sends ACK flag
	- Acknowledgement  servers ISN+1
	- "got it connection established"


