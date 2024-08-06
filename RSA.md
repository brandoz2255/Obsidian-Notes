
**RSA (Rivest-Shamir-Adleman)**: is one of the earliest and most widely used asymmetric encryption algorithm. It is used for secure data transmission and is based on the mathematical properties of large prime numbers. 

- Developed in 1977 by Ron Rivest, Adi Shamir, and Leonard Adleman.
- Named after its creators, RSA was one of the first public-key cryptosystems and remains in widespread use today.
- The patent for RSA expired in 2000, allowing unrestricted use of the algorithm.

How RSA works :

- **Prime Numbers**: RSA relies on two large prime numbers which are multiplied to produce a modulus for key pair generation. 

- **Public and Private Keys**: The algorithm generates a public key and a private key. The public Key is distributed openly where the private key is kept secret by the owner. 

- **Encryption:** The sender encrypts the message using the recipient’s public key.
- **Decryption:** The recipient decrypts the message using their private key.

- RSA is often used to securely exchange symmetric keys, as the algorithm itself is computationally intensive and slower for encrypting large volumes of data.

**Security Considerations:**

- **Mathematical Foundation:** The security of RSA is based on the difficulty of factoring the product of two large prime numbers, a problem for which there is currently no efficient solution.
- **Key Length:** RSA supports variable key lengths between 1024 and 4096 bits. A longer key length provides greater security, but it also requires more computational resources.
- **US Recommendations:** *US authorities recommend a minimum key length of 2048 bits* for adequate security against modern computational capabilities.


**Key Facts and Exam Tips:**

1. **Asymmetric Encryption:**
    
    - RSA is an asymmetric encryption algorithm, meaning it uses a pair of keys (public and private) for encryption and decryption.
2. **Key Length:**
    
    - RSA supports variable key lengths, typically between 1024 and 4096 bits.
    - A minimum key length of 2048 bits is recommended for secure communications.
3. **Encryption and Decryption Process:**
    
    - Understand how RSA uses the public key for encryption and the private key for decryption.
    - Be aware that the sender encrypts data using the recipient’s public key, and the recipient decrypts it with their private key.
4. **Use Case:**
    
    - Know that RSA is primarily used to securely exchange symmetric keys due to its computational intensity.
5. **Limitations:**
    
    - RSA is slower than symmetric encryption algorithms and is not suitable for encrypting large amounts of data directly.
6. **Security Considerations:**
    
    - The security of RSA depends on the difficulty of factoring large prime numbers, a process that remains computationally challenging.