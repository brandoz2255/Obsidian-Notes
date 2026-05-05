
##### Understanding the Tor Protocol

The **Tor Protocol** is short for *The Onion Router* which is a `software package to facilitate anonymous internet access`. it achieves this by using a *series of encryption layers and relay nodes making it difficult to trace the origin of the data*. Originally created by the NSA to send sure messages to Washington tor has since evolved to widely used tool for privacy. 

**How it works**
This is how Tor works in this example

- Alice wants to visit a website without revealing her identity
- Her browser connects to a Tor directory server, which provides a list of available relay nodes
- Tor uses multiple nodes, each operated by different users, to route Alice's request
	- Each node only knows the identity of the previous node not Alice's identity or final destination 
	- This processes ensures that no single node can be traced back

That why it is called *The Onion Router* akin to pealing an onion where each layer (node) only reveals limited information. 

**Perfect Forward Secrecy (PFS)**
Is a crucial feature in Tor that enhances security by *using encryption to conceal communication details even from participants involved in communication*. 

- In Tor when Alice sends a request to a website the requests is then encrypted in a way that only the intended recipient (the final node) can decrypt it
- The  request passes through multiple nodes (node 1 --> node 2 --> node 3) before reaching the end 
- Each node only decrypts the layer of encrypt that is relevant and forwards the remaining data to the next node
- This chain of encryption ensures that even if one node is compromised the rest remains secure 
- When using Tor the entity you communicate with directly is the *entry node* then comes in *node 2*

This level of encryption is the reason why using Tor is slow since accessing websites need to through this level of encryption each time. 

- also retake this sets quiz 
