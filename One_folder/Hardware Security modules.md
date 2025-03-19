
-------
### Cryptography and Hardware Efficiency

Cryptography demands alot of high computing power which is why to addres this engineers developed hardware specifically designed to perform cryptography. 

#### Hardware Security Modules (HSMs)

- **Hardware Security Modules (HSMs)**: Special-purposes computing devices that manage encryption and keys 
	- HSMs perform the cryptographic operations and also handle the key management without exposing it to human beings
	- Cloud service providers such as AWS offer their own versions of HSM to enhance security in cloud environments

#### Federal Information Processing Standard (FIPS)

- **FIPS Requirements**: U.S. Federal agencies must compy with these requirements outlined in the *Federal Information Processing Standard* 
	- **FIPS 140-3**: is a standard for specifying the usage of HSM in government agencies especially those from cloud services 

#### FIPS 140-2 Security Levels

**FIPS 140-2** defines four security levels for *HSMs*, each with increasing levels of protection:

- **Level 1**:
    
    - Allows the use of standard operating systems.
    - No physical security requirements.
- **Level 2**:
    
    - Equivalent to EAL2.
    - Requires tamper-evident seals to indicate if an HSM has been physically compromised.
- **Level 3**:
    
    - Equivalent to EAL3.
    - Requires tamper-resistant controls that protect the HSM from unauthorized access or modifications.
- **Level 4**:
    
    - Equivalent to EAL4.
    - Enforces strict physical security controls, ensuring the highest level of protection against physical and environmental threats.

---

### Important Points for Sec+ Exam

- **Understanding HSMs**: Recognize the role of HSMs in managing cryptographic operations and keys securely, minimizing the risk of key exposure.
- **FIPS Compliance**: Know that *U.S. Federal agencies must adhere to FIPS standards*, particularly FIPS 140-3, when using HSMs.
- **FIPS 140-2 Security Levels**: Be familiar with the four security levels defined by FIPS 140-2, especially the differences in physical and software/firmware security requirements at each level.
    - **Level 1**: No physical security.
    - **Level 2**: Tamper-evident seals.
    - **Level 3**: Tamper-resistant controls.
    - **Level 4**: Strict physical security.