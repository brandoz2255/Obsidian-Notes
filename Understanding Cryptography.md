
#Cryptography
**Cryptography**: is the science off securing information by transforming it into a format that is unreadable to any unauthorized individuals. 

- involves creating and analyzing protocols that prevent third parties from reading private messages. 
- Cryptography is essential for maintaining the confidentiality, integrity, authentication, and non-repudiation of data.

An **algorithm** is a *specific set of steps or a procedure designed to perform a task or solve a problem*. Think of it as a recipe in mathematics or computer science that outlines the steps needed to achieve a particular result.

#### Example: Fahrenheit to Celsius Algorithm

The algorithm to convert Fahrenheit to Celsius is a straightforward mathematical formula:

1. **Input**: Temperature in Fahrenheit (F).
2. **Process**: Apply the conversion formula.
    - $C=59×(F−32)C = \frac{5}{9} \times (F - 32)C=95​×(F−32)$
3. **Output**: Temperature in Celsius (C).


**Encryption**:  is a method for protecting information by converting it into a coded format which can only be read or decrypted by someone who has the correct key. 

- It ensures the data remains confidential and inaccessible to unauthorized users. Encryption algorithm use mathematical formula to scramble data.  

- **Encryption algorithms** transform plaintext (P) into ciphertext (C) using an encryption key (K). 
- The process ensures that the *original message is obfuscated*, making it unreadable to anyone without the corresponding decryption key. 
- **Decryption** is the *reverse process*, where the ciphertext (C) and the decryption key (K) are used to retrieve the original plaintext (P).

1. **Common Encryption Algorithms**:
    
    - **AES**: Advanced Encryption Standard, widely used for securing data.
    - **RSA**: Rivest-Shamir-Adleman, used for secure data transmission and digital signatures.
    - **ECC**: Elliptic Curve Cryptography, known for strong security with shorter keys.

There are two main types of encryption:

1. **Symmetric Encryption**: Uses a single key for both encryption and decryption. Examples include *AES* **(Advanced Encryption Standard**) and *DES* **(Data Encryption Standard**).

```C
SITUATION ->

This means that both the sender and receiver (e.g., Alice and Bob) need to have the same key to communicate securely. The challenge arises when a third person (e.g., Charlie) wants to communicate with either Alice or Bob, as they would need separate keys to maintain secure communication. This can lead to a cumbersome key management problem, especially as the number of participants increases.
```

2. **Asymmetric Encryption**: Uses a pair of keys—a public key for encryption and a private key for decryption. Examples include *RSA* (**Rivest-Shamir-Adleman**) and *ECC* (**Elliptic Curve Cryptography**).

How to remember them perfectly is **Symmetric** is for both sides being identical meaning 


- single key  for both encrypting and decrypting both sides the same \
- faster

**Asymmetric** is for both side aren't the same meaning 

- different pair of keys a public one for encryption and private for decryption
- slower

[[more asymmetric info]]

**Encryption Algorithms and Standards**:

- **AES**: Considered very secure and widely used. Know its key sizes (128, 192, and 256 bits).
- **DES/3DES**: Understand why DES is considered weak due to its short key length and how 3DES improves upon it.
- **RSA**: Commonly used for secure data transmission, understand its role in key exchange and digital signatures.
- **ECC**: Offers strong security with shorter keys, used in mobile devices and small form factor devices.

Exam tip: 

Asymmetric cryptography the keys used to encrypt and decrypt data must come from the same key pair 

- This means that if you use a public key to encrypt a message, only the corresponding private key from the same key pair can decrypt it, and vice versa. 
- This pairing ensures that the process is secure and that only the intended recipient (who possesses the private key) can access the encrypted information.

### Analogy to Remember

Think of asymmetric keys like a mailbox:

- **Public Key (Mailbox)**: Anyone can drop a letter (message) into your mailbox (encrypt with the public key), but only you have the key to open the mailbox and read the letter (decrypt with the private key).
- **Private Key (Mailbox Key)**: Only you have this key, and it allows you to access the letters inside your mailbox.
