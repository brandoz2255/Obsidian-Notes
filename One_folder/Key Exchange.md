- every crypt algorithin relies on keys 
- in symm theu need to agree in the one key to exchange 
- alice and bob want to keep their convo congidential 
- how can they secure their key exchange
- Out-of-Band key exahnge 
	- uses a different comm channel 
	- they can meek in person 
	- or create a ley send it via usb physical mail
	- talk over the phone could wokr as well
- Out of ban could be difficult 
- In-Band key Exchange soples this problem 
---------------------------------
### Key Exchange in Cryptography

Every cryptographic algorithm relies fundamentally on keys. The key is the cornerstone of encryption and decryption processes, ensuring that the information remains secure.

#### Symmetric Key Exchange

In symmetric cryptography, both parties (e.g., Alice and Bob) must agree on a single key to encrypt and decrypt their communications. However, the challenge arises in how to securely exchange this key while maintaining the confidentiality of their conversation.

**Out-of-Band Key Exchange**
One method is using a secure key exchange method such as **Out-of-Band (OOB) key exchange**, which involveds using a different communication channel #fcard

- **Meeting in person**: Alice and Bob can meet face-to-face to exchange the key.
- **Physical transfer**: The key can be sent via a USB drive, physical mail, or another physical medium.
- **Phone call**: They could exchange the key by talking over the phone.

While most effective this can be quite difficult if the two parties don't want to do all of this extra work. 

#### In-Band Key Exchange

To address the limitations of Out-of-Band exchange, **In-Band key exchange** methods are used. This approach allows the key to be exchanged over the same communication channel that will be used for the encrypted communication, making the process more straightforward and efficient.. This approach allows the key to be exchanged over the same communication channel that will be used for the encrypted communication, making the process more straightforward and efficient. #fcard 