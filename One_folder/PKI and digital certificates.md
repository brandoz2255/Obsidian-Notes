
------------------------

### Public Key Infrastructure (PKI) and Certificate Authorities

**Public Key Infrastructure (PKI)**: Relies heavily on trusted Certificate Authorities(CA) Rather than a peer to peer based trust like WOT. 
- PKI offers a more centralized approach on managing Digital Certificates 

#### The Role of Certificate Authorities (CAs)

- **Certificate Authority (CA)**: A trusted third-party organizations that verifies the identity of individuals  or organizations and issues digital certificates. 
	- These certificates contain both identity information and a copy of the subject's public key.

**Analogy with Government Identification**:

- The process og getting a Digital Certificate is similar to the process of getting a government identification
- For example DMV requires multiple forms of identifying yourself before getting a drivers license 
- once verified the DMV issues you a license, which you can use to prove your identity to others 

#### Digital Certificates

- **Digital Certificates**:  These are besically the identity cards of Cyberspace, used to prove your identity in the digital world. 
- **Obtaining a Digital Certificate**:
	- To obtain a digital certificate, you approach a CA, which will require you to prove your identity throught various methods 
	- After verifying your identity the CA issues a Digital Certificate that contains your Public key and identity information 
	- CA thens signs on your Certificate adding that layer of trust

**Security Considerations**:

- Digital Certificates doesn't not contain and sensitive information so you can freely distribute this information 
- Anyone attempting to misuse you digital certificate would be unable to do so without your private key

-------

### Important Points for Sec+ Exam

- **PKI and Trust**: Understand that PKI relies on centralized, trusted Certificate Authorities rather than decentralized models like WOT.
- **Certificate Authorities (CAs)**: Know that CAs verify identities and issue digital certificates containing public keys and identity information.
- **Digital Certificates**: Be aware that digital certificates act as identity cards in cyberspace, proving identity without exposing sensitive information.
- **Security of Certificates**: Recognize that while digital certificates are publicly shareable, they are secure because they do not contain private keys, preventing unauthorized use.