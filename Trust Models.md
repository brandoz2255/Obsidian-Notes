- Strong Cryptography always depends on some degree of trust 
- depends on  a secure key exchange process 
- requirements for a key exchange | The two parties must be confident that they are really communicationg with each other and that neither one is an imposter 
- also tthat nobody is able ot eavesdrop onto the communication between the two parties on the key exchange 
- Diffie hellmand helps but there has to another way to be 100 sure 
- In asymmetric cryptography there are two keys and one that they dont need to share such as the private key 
-  can and should share the pub key 
- Eavesdropping protection isnt needed during key exchange 
- we still need to prevent imposters 
- trust models 
	- Personal knowledge 
	- web of trust (WOT)
	- public key infrastructure (PKI)
- Web of trust  was introduced by Phil zimmerman which relies on indirect relationships 
- you might know somoen who knows tht person 
- like someon you meet on linkedIn
- or maybe you know a person of  person of aperson 
- Participants digitally sigmn the public keys of people they know personally 
- when they verify when that ley belongs to that person 
- and if the web becomes larger this allows more people to communicate with trust 
- issues 
	- WOT uses a decentralized approach 
	- high barrier to new entry 
	- good deal of technical knowledge 
- PKI builds upon the web of trust conecpt but introducses centralized authority who make the process easier 

----

### Trust and Cryptography

Strong cryptography relies on a certain degree of trust particularly in the key exchange process. For secure communication parties involved must trust that -->

1. They are genuinely communicating with each other and neither party is an imposter
2. No one is eavesdropping on the key exchange process or their communication 

While the Diffie-Hellman helps in securing keys to protect against imposters we need 

#### Asymmetric Cryptography

In asymmetric cryptography, two keys are used:

- **Private Key**: This key is kept secret and should never be shared.
- **Public Key**: This key can and should be shared freely.

During this key exchange in asymmetric cryptography protection against eavesdropping is a less of a concern, but preventing imposters remains critical. 

#### Trust Models in Cryptography

1. **Personal Knowledge**: Trust is established based on direct personal relationships 
2.  **Web of Trust (WOT)**: 
	1. Introducing by Phil Zimmerman Web of Trust relies on indirect relationships 
	2. may trust someone who knows the person you want to communicate with with connection with someone else you know mutually 
	3. Participants also digitally sign on public keys of people they personal know, verifying that the key belongs to that person 

- **Issues with WOT**:
    
    - WOT uses a decentralized approach, which can make it difficult for new participants to enter.
    - It requires a good deal of technical knowledge and has a high barrier to entry.
- **Public Key Infrastructure (PKI)**:
    
    - PKI builds upon the Web of Trust concept but introduces a centralized authority to simplify the process.
    - This centralized model makes it easier for people to trust public keys and for new participants to enter the system.

### Important Points for Sec+ Exam

- **Trust in Cryptography**: Understand that strong cryptography depends on a secure key exchange process and a foundation of trust between the parties involved.
- **Asymmetric Cryptography**: Recognize the roles of private and public keys and the importance of preventing imposters in key exchanges.
- **Web of Trust (WOT)**: Know that WOT is a decentralized trust model that relies on indirect relationships and personal knowledge but has a high barrier to entry.
- **Public Key Infrastructure (PKI)**: Be aware that PKI introduces a centralized authority to the trust model, making the process more accessible and trusted.