
**PGP**(*Pretty Good Privacy*): is an *encryption program that provides cryptographic privacy and authentication* for data communication. It uses a combination of symmetric and asymmetric cryptography to secure emails and messages/data


- A popular program for encrypting and decrypting email over the internet as well authenticate message with *digital Signatures*. 

**Key Points:**

- **Creation and History:**
    
    - Developed by Phil Zimmermann in 1991.
    - PGP quickly became popular as a method for securing email communication and ensuring privacy and authenticity.
    - It is widely used today, and OpenPGP, a non-proprietary version, is available for free use and distribution.

How it works: 
- *PGP* uses both *symmetric* and *asymmetric* cryptography to encrypt data
- **Symmetric Crytpography**: used for encrypting the message content. A symmetric session key is generated to encrypt the data as symmetric is faster. 
- **Asymmetric Cryptography**: used for encrypting  the symmetric session key. where each use has a public and private key pair, where the public is openly distributed, and the private key is kept secret. 

**Encryption and Decryption Process:**

- **Encryption:**
    
    1. **Generate a Random Symmetric Key:** The sender generates a random symmetric key to encrypt the plaintext message.
    2. **Encrypt the Message:** The plaintext message is encrypted using the symmetric key.
    3. **Encrypt the Symmetric Key:** The symmetric key is encrypted with the recipient's public key.
    4. **Send Encrypted Data:** The encrypted message and encrypted symmetric key are sent to the recipient.

- **Decryption:**
    
    1. **Decrypt the Symmetric Key:** The recipient uses their private key to decrypt the symmetric key.
    2. **Decrypt the Message:** The recipient uses the decrypted symmetric key to decrypt the message, obtaining the original plaintext.

**GnuPG**(*GPG*): A free and opensource implementation of OpenPGP. It provides a CLI tool for encrypting and decrypting data, managing keys and more. 

GPG to generate a key pair

```C++
gpg --gen-key
```

- Select Default RSA 
- Key Sized desired key size 
- Expiration where you want the key to expire
-  **Enter User Information:** Provide name and email (e.g., Alice Sender).
- **Passphrase:** Choose a memorable passphrase for the key.

Export the Pub key 
```C++
gpg --armor --export bob@recipient.org > bob.pub
```

Import Public key:
```c++
gpg --import bob.pub
```

Encrypt a Message:

```C++
gpg --armor --recipient bob@recipient.org --encrypt demo.txt
```

Decrypt a Message:

```C++
gpg --decrypt message_from_alice.txt
```

**Key Facts and Exam Tips:**

1. **PGP Framework:**
    
    - Understand that PGP is not a single algorithm but a framework that uses a combination of algorithms for encryption and decryption.
2. **Combination of Cryptography:**
    
    - PGP uses both symmetric and asymmetric cryptography to provide efficient and secure encryption.
3. **Key Distribution:**
    
    - Public keys are distributed openly, while private keys are kept secure by their owners.
4. **OpenPGP and GnuPG:**
    
    - Recognize that OpenPGP is a non-proprietary version of PGP and GnuPG (GPG) is a free implementation widely used today.
5. **Command Usage:**
    
    - Be familiar with basic GPG commands for key generation, encryption, and decryption.
6. **Security Features:**
    
    - Understand the security features PGP provides, including confidentiality, authentication, integrity, and non-repudiation.


[PGP](https://www.techtarget.com/searchsecurity/definition/Pretty-Good-Privacy)
\
