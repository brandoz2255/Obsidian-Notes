
----
### Hash Functions in Cryptography

**Hash Functions**: Play a key role in Public Key Cryptography especially in creating Digital certificates and digital signatures. 

- These are one-way functions 
- That transform a variable length input into a unique fixed-length output 
- ensuring the original input cannot be retrieved by the hash

#### Characteristics of Hash Functions

- **One-Way Function**: Hash functions are irreversible meaning once you hash content you can't get that content back
- **Fixed-Length Output**: Regardless of the input size the hash function is always the same length whether you hash a single word or an entire book 
	- the hash value would remain fixed
- **Collision Resistance**: Secure hash functions are resistant to collision meaning that two different inputs should never provide the same hash output. 
	- if two inputs end up creating the same hash output this algorithm is insecure

#### Common Hash Functions

1. **MD5 (Message Digest 5)** Not secure
	1. Created By *Ron RIvest* in 1991, MD5 produces the 128-bit hash
	2. Initially a replacement for MD4, MD5 has since been found to a majority of security flaws. Especially in Collision resistance 
	3. In 2013, a Critical vulnerablity was discovered, leading to MD5 being considered insecure
2. **SHA-1 (Secure Hash Algorithm 1)** Not Secure:
	1. Developed by NIST produces a 160 bit hash value 
	2. Contains Multiple Security flaws 
3. **SHA-2** Insecure
	1. A family of six different hash algorithms, producing hash values of 224, 256, 384, and 512 bits
	2. While SHA-2 is still widely used it shares a lot of mathematical similarities with SHA-1 and MD5 
		1. making is susceptible to the same flaws
4. **SHA-3**
	1. Developed as a replacement for the SHA-2 and SHA-3 and uses the Keccak algorithm, which employs different approach to hashing
	2. SHA-3 can produce hashes of any desired length , determined by the user
	3. Despite being newer SHA-3 faces some skepticism from academic institutions because of its government roots
5. **RIPEMD (Race Integrity Primitives Evaluation Message Digest)**: 
	1. Developed by Belgian researchers as an alternative to government-sponsored hash functions
	2. also produces 128,256, and 320 bits. the 128 bit version is no longer secure which is why the 160 bit is widely used especially in Bitcoin 

#### Hash-Based Message Authentication Code (HMAC)

- **HMAC**: Combines symmetric cryptography with hash functions to provide both authentication and integrity for messages 
- **Operation**: Sender of the messages uses a secret key in conjunction with a hash function to create a message authentication code (MAC). The recipient then repeats the process with same secret key to verify the authenticity and integrity of the message. 

#### Hash Functions in Asymmetric Cryptography

- Hash function are integral to the creation of digital signatures and digital certificates, providing a means to verify the authenticity and integrity of digital documents and communications 

---

### Important Points for Sec+ Exam

- **Irreversibility**: Understand that hash functions are one-way and cannot be reversed to reveal the original input.
- **Collision Resistance**: Know that a secure hash function must prevent collisions—where two different inputs produce the same hash.
- **Common Hash Algorithms**: Be familiar with MD5, SHA-1, SHA-2, SHA-3, and RIPEMD, and understand which are considered secure (SHA-3) and which are not (MD5, SHA-1, certain configurations of SHA-2).
- **HMAC**: Recognize the role of HMAC in providing authentication and integrity by combining hash functions with symmetric cryptography.

---

### Additional Information for Sec+ Exam

1. **Birthday Attack**: Understand the concept of a birthday attack, where a hash function is exploited to find collisions faster than brute force.
2. **Key Derivation Functions (KDFs)**: Be aware that KDFs like PBKDF2, bcrypt, and scrypt are used to securely derive cryptographic keys from passwords.