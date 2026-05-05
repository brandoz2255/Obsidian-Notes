# AES 

**Advanced Encryption Standard** (*AES*) is a specification for the encryption for data established by the US NIST in 2001. 

- **AES** is a *symmetric key encryption algorithm* that is widely used across the globe for securing data.

- Widely used today because its more stronger than *DES* and *Triple DES* despite being harder to implement

**Creation and History:**

- Developed as a result of a competition held by NIST to create a new, more secure encryption standard.
- Replaced DES as the federal standard for encryption in 2001.

#### Key Facts
**Technical Details:**

- **Symmetric Encryption:** Uses the same key for both encryption and decryption.
- **Block Cipher:** Operates on 128-bit blocks of data.
- **Key Length:** Can use key lengths of 128, 192, or 256 bits.
- **Encryption Process:** Involves multiple rounds of substitution and transposition (also known as permutation).
- **Considered Secure:** Widely regarded as secure and used in many applications and protocols.

**Substitution and Transposition:**

- **Substitution:** Each byte is replaced by another byte according to a substitution table (S-box).
- **Transposition:** Bytes are shifted and mixed around to create diffusion in the data.

**AES Commands in Linux:**

- **Encrypting a file:**
    - Command: `aescrypt -e -p passwordstring -o encrypted.aes string.txt`
    - Description: Encrypts the file `string.txt` using the password `passwordstring` and outputs it as `encrypted.aes`.

**Checking Encryption:**

- Command: `cat encrypted.aes`
- Description: The output will be unreadable due to encryption.

- **Decrypting a file (incorrect password):**
    - Command: `aescrypt -d -p wrongpassword encrypted.aes`
    - Description: Will give an error due to the wrong password.

- **Decrypting a file (correct password):**
    - Command: `aescrypt -d -p passwordstring encrypted.aes`
    - Description: Decrypts the file if the correct password is provided, making the content readable.

![[AES.png]]

[AES](https://www.geeksforgeeks.org/advanced-encryption-standard-aes/)



# Blowfish

Blowfish: a Method for encryption which  is highly regarded for its reliability efficiency and security. 

-  Is a block cipher that utilizes the symmetric encryption algorithm to secure data designed to replace DES and is known for its speed and effectiveness in software

![[Pasted image 20240804201836.png]]

**Creation and History:**

- Developed by Bruce Schneier in 1993.
- Released as a public domain algorithm, meaning it is free to use without any licensing requirements.
- Designed to address the limitations and vulnerabilities of DES, providing a faster and more flexible encryption method.


**Technical Details:** Blowfish follows a Feistel Network

- **Feistel Network:**
    
    - A Feistel network is a **symmetric structure** used in many block ciphers, including *DES* and *Blowfish*. It involves splitting the data block into two halves and processing each half in multiple rounds.
    - **How It Works:** In each round, one half of the data is modified using a function that involves both substitution and transposition operations. The modified half is then combined with the other half using an XOR operation, and the roles of the halves are swapped for the next round.

- **Substitution and Transposition:** Blowfish **uses both substitution** (*replacing bits with other bits*) **and transposition** (*rearranging bits*) operations to achieve encryption, providing strong diffusion and confusion properties.

- **Symmetric Encryption:** Blowfish uses the same key for both encryption and decryption, meaning the sender and receiver must share the same secret key.

- **Block Cipher:**
    
    - Operates on **64-bit blocks** of data, not 63 bits. Each block is processed independently, which makes it vulnerable to certain types of attacks as computing power increases.
- **Key Length:**
    
    - Variable key length ranging from 32 bits to 448 bits. This flexibility allows users to choose a key length that balances security needs with performance requirements.



[Blowfish](https://ninjaencrypt.com/tutorial/what-is-blowfish-encryption-and-how-does-it-work/)

# Two  Fish

Twofish: Is a  Symmetric key block cipher designed by Bruce Schiedder and his team at counter pane systems. It is a  block cip--her variance that's always operating compounding blocks of data usually **128 bits**. 

- Twofish is a symmetric key block cipher designed as a replacement for DES and is known for its flexibility, speed, and security.


- Developed by Bruce Schneier and his team in 1998.
    - Was a finalist in the AES (Advanced Encryption Standard) competition, which ultimately led to the selection of AES as the new encryption standard.
    - Released into the public domain, making it free to use without any licensing fees.

**Feistel Network:**

- Twofish employs a Feistel network structure, which involves splitting the data block into two halves and processing each half in multiple rounds.
- **Substitution and Transposition:** Utilizes a combination of substitution (using S-boxes for confusion) and transposition (using permutations for diffusion) operations within its rounds.

**Symmetric Encryption:**

- Uses the same key for both encryption and decryption, meaning the same key is required by both the sender and receiver.

- - **Block Cipher:**
	- Operates on **128-bit blocks** of data, which is an improvement over DES's 64-bit block size. This larger block size provides enhanced security against certain types of attacks, such as birthday attacks.
- **Key Length:**
	- - **Supports** key lengths of **128, 192, or 256** bits, allowing for flexibility in balancing security needs with performance. The longer the key, the more secure the encryption, but it may require more computational resources.