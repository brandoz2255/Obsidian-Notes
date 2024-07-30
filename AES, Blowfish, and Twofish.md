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

- Blowfish 
- is a public domain algorithm 
- designed as a DES replaement 
- uses  a feistel network 
	- what is this ? 
- combines both substitution and transposition operations 
- symm encrypt algorithim 
- block ciper on 63 bit blocks 
- key length 32 and 448 bits 
- not considered secure 

# Blowfish

[Blowfish](https://ninjaencrypt.com/tutorial/what-is-blowfish-encryption-and-how-does-it-work/)
- Twofish 
- designed as a DES replacement 
- place into public fomain 
- uses feistel netowork
- - combines both substitution and transposition operations 
- key facts: 
 - symm encrypt algorithim 
- block ciper on 128 bit blocks 
- key length 128 and 192 or 256 bits
-  considered secure 