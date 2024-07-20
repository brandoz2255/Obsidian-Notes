
### Five goals of Cryptography

**Confidentiality**: makes sure that the information is not accessible too any unauthorized individuals 

- **Details**:
    - **Data at Rest**: Protecting data stored on storage devices (e.g., hard drives, SSDs).
    - **Data in Transit**: Securing data as it moves over networks (e.g., emails, web traffic).
    - **Data in Use**: Protecting data that is being processed actively in memory.
- **Example**: Encrypting sensitive files on a disk to prevent unauthorized access.

**Integrity**: Ensures that data is not altered or tampered with , without proper authorization 

- **Details**:
    - Uses hash functions (e.g., SHA-256) to create a unique hash of the data.
    - Any alteration in the data will change the hash value, indicating tampering.
- **Example**: Using checksums or hash functions to verify that a downloaded file has not been corrupted or tampered with.

**Authentication**: Verifying the identity of users or devices to ensure  that only authorized entities can access the information. 

- **Details**:
    - Often involves usernames, passwords, biometrics, or digital certificates.
- **Example**: Requiring a user to enter a password or use a fingerprint scan to access a secure system.

**Obfuscation**: making data difficult to understand or interpret to conceal its true meaning!

- **Details**:
    - Techniques include code obfuscation, data masking, and steganography.
- **Example**: Encrypting a message so that it appears as random data to anyone who intercepts it without the key.

**Non-repudiation**: Ensuring that the sender of a message cannot deny having sent it and the recipient  cannot deny having received it. 

- **Details**:
    - Achieved using digital signatures, which provide proof of the origin and integrity of a message.
    - Only possible with asymmetric cryptography.
- **Example**: Bob sends a digitally signed email to Alice. Alice can verify that the email was indeed sent by Bob and not altered in transit.

**Digital Signatures**: A digital  code generated and authenticated by public key encryption, attached to an electronically transmitted document in order to verify the  contents and the senders identity. 

**How It Works**:

- The sender (e.g., Bob) uses their private key to create a digital signature on a message.
- The recipient (e.g., Alice) uses Bob's public key to verify the digital signature.
- If the signature matches, it confirms that the message was sent by Bob and was not altered in transit.

**Trade-Offs in Cryptography**:

- **Computational Resources**: Cryptographic operations, especially asymmetric ones, require significant computational power.
- **Symmetric vs. Asymmetric Cryptography**:
    - **Symmetric Cryptography**: Faster and more efficient, but key distribution and management can be challenging.
    - **Asymmetric Cryptography**: Solves key distribution issues but is slower and more resource-intensive.
- **Balancing Act**: Often, a hybrid approach is used, where asymmetric cryptography secures key exchange, and symmetric cryptography encrypts the actual data.

#algorithms  
# Crypt Algorithms


Don't implement your own cryptographic algorithim sinces the ones designed are professionally designed unless you really know what you are doing. 

Exam Tips: Since **Cryptographic algorithms** are *intricate and complex designed to ensure secure and reliable encryption and decryption process*. which means that even the smallest errors in the implementation or usage can lead to vulnerabilities.  

**Security through Obscurity** is a concept where the security of a system relies on keeping its design, implementation, or specific details secret. The idea is that by obscuring how a system works, it becomes more difficult for attackers to find and exploit vulnerabilities.

- However, this approach is generally considered weak and insufficient on its own, as once the secret is discovered, the system's security can be easily compromised.

- **Not a Standalone Measure**: Relying solely on obscurity does not provide robust security. True security should rely on strong, well-tested cryptographic algorithms and security practices.
- **Exposure Risk**: If the obscured details become known, the system's security can be quickly undermined. Attackers can reverse-engineer or discover hidden details through other means.

**Algorithm selection** involves choosing the appropriate cryptographic algorithm to meet specific security requirements. The choice depends on various factors such as the type of data, the desired level of security, performance considerations, and the potential threats.

- **Types of Cryptographic Algorithms**:
    
    - **Symmetric Algorithms**: Use a single key for both encryption and decryption.
        - **Examples**: AES (Advanced Encryption Standard), DES (Data Encryption Standard), 3DES (Triple DES).
    - **Asymmetric Algorithms**: Use a pair of keys (public and private) for encryption and decryption.
        - **Examples**: RSA, ECC (Elliptic Curve Cryptography).
    - **Hash Functions**: Produce a fixed-size hash value from input data, used for data integrity.
        - **Examples**: SHA-256, MD5.

- **Factors Influencing Algorithm Selection**:
    
    - **Security Level**: The strength of the algorithm against potential attacks. For example, AES-256 offers higher security than AES-128.
    - **Performance**: The computational resources required. Symmetric algorithms are generally faster and less resource-intensive than asymmetric algorithms.
    - **Data Sensitivity**: The criticality of the data being protected. Highly sensitive data requires stronger algorithms.
    - **Compliance Requirements**: Regulatory standards that mandate the use of specific algorithms.
    - **Key Management**: The complexity of managing encryption keys. Asymmetric keys simplify key distribution but are computationally intensive.
# Life cycle
### Phase 1: Initiation

- **Definition**: The initiation phase for cryptographic algorithms starts with defining the security needs, including what data needs protection and to what extent, based on the CIA triad (Confidentiality, Integrity, Availability).
- **Importance**: For the Security+ exam, understanding the initial assessment of security needs is crucial because it sets the stage for selecting the appropriate cryptographic methods and policies.
- **Analogy**: Think of this as deciding the type of safe you need for your valuables—what you're protecting determines the security features you require.

### Phase 2: Development and Acquisition

- **Definition**: This phase involves the selection or development of cryptographic algorithms that meet the initial security specifications. It also includes the acquisition of cryptographic modules certified for use.
- **Importance**: The Security+ exam might test your knowledge on the selection of appropriate cryptographic standards and their integration into systems, underscoring the importance of compliance and security from the start.
- **Analogy**: This is like choosing the right materials and locks for the safe, ensuring they meet the security standards necessary to protect your valuables.

### Phase 3: Implementation and Assessment

- **Definition**: The algorithm is implemented within systems and assessed to ensure it effectively secures data without impacting system performance unduly.
- **Importance**: Implementing and testing to confirm the effectiveness and security of cryptographic implementations are critical topics on the Security+ exam.
- **Analogy**: This phase is akin to installing the safe in your home and testing it by locking and unlocking it, ensuring it works as expected without any hitches.

### Phase 4: Operation and Maintenance

- **Definition**: Ongoing operations include monitoring the effectiveness of the cryptographic solutions and performing necessary updates or reconfigurations to adapt to new threats or changes in requirements.
- **Importance**: Regular updates and maintenance are vital to keep cryptographic measures effective, a key area covered in the Security+ exam.
- **Analogy**: Just as you might change your safe’s lock combination regularly or maintain its mechanisms to ensure it continues to protect your valuables, cryptographic solutions require similar diligence.

### Phase 5: Sunset

- **Definition**: Eventually, cryptographic algorithms become obsolete or compromised and need to be retired. This phase ensures the secure decommissioning of the algorithms and any data encrypted by them.
- **Importance**: Understanding the secure retirement and replacement of cryptographic tools is essential for the Security+ exam to avoid potential security breaches.
- **Analogy**: This is like replacing an old safe with a new one when it's no longer secure or adequate for your needs, ensuring that nothing valuable is left behind to be compromised.