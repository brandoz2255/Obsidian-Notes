
---
### Digital Signatures in Cryptography

**Digital Signatures** are the elcectronic counterparts towards the physical signatures 

- Providing integrity Authentication and Non-Repudiation  in digital communications 
- the utilize the asymmetric cryptography to ensure that the signer of a message can be verified 
- and has not been alterd and the signer cannot deny having signed the message

#### Key Concepts of Digital Signatures

- **Integrity**: Ensures that the message was not alter after already being signed 
- **Authentication**: Verifies that owner of the public key is the person who signed the message 
- **Non-Repudiation**: Allows the  recipient to prove a third party that the signer indeed signed the message.

#### How Digital Signatures Work

Digital signatures rely on the following components:

1. **Hash Functions**: The hash funciton used must be collision resistant as mentioned before two inputs cannot provide the same hash value 
2. **Asymmetric Cryptography**:
	- Typically asymmetric cryptography public keys used to encrypt data and private to decrypt 
	- in Digital signatures the process is reversed private key is used to encrypt the hash (Creating the signature) and public is used to decrypt
3. **Public and Private Keys**:
	- **Private Key**: Used by the sender to encrypt the hash value, creating the digital signature.
	- **Public Key**: Used by the recipient to decrypt the digital signature and verify the integrity of the message.

- **Alice Sends a Message to Bob**:
    
    - Alice creates a message and uses a hash function to produce a unique hash of that message.
    - She then encrypts the hash using her private key, creating a digital signature.
    - Alice sends both the message and the digital signature to Bob.

**Bob Verifies the Signature**:

- Bob receives the message and the digital signature.
- He uses the same hash function to generate a hash from the message.
- Bob then decrypts the digital signature using Alice’s public key, obtaining the hash that Alice encrypted.
- Bob compares the two hashes. If they match, Bob knows the message was indeed signed by Alice and has not been altered.

**Verification by a Third Party**:

- If necessary, Bob can have a third party, Charlie, verify the signature by repeating the process. If Charlie gets the same result, it further confirms the authenticity and integrity of the message.

#### Confidentiality and Digital Signatures

- **Lack of Confidentiality**: Digitally signing a message does not provide confidentiality. Anyone with the message can read it. To ensure that only bob can read the message, Alice would need to encrypt it with bob's public key before sending it. 


----

### Important Points for Sec+ Exam

- **Digital Signatures**: Understand that digital signatures provide integrity, authentication, and non-repudiation but do not inherently provide confidentiality.
- **Asymmetric Cryptography**: Recognize the reversal in the use of keys for digital signatures: private keys for signing (encryption) and public keys for verification (decryption).
- **Hash Functions**: Be aware of the importance of collision-resistant hash functions in ensuring the security of digital signatures.