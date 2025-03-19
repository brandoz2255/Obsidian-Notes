
---

### Digital Certificates and the X.509 Standard

**Digital Certificates**: follow the X.509 which was created by the International Telecommunications Union (ITU). These certificates are usually referred to as X.509 certificates 

#### Process of Obtaining a Digital Certificate

1. **Key Pair Generation**: 
	1. Alice begins creating the public private key pair for using an encryption algorithm of her choice 
2. **Certificate Signing Request (CSR)**: 
	1. Alice Creates a **Certificate Signing Request** (*CSR*), which contains her public key, name, and other identifying information such as email address or server name
	2. CSR is then sent to a Certificate Authority (CA). If the CA operates as a third party it may also be referrred to as a **Registry Authority(RA)** 
3. **Validation by Certificate Authority**:
	- Once receiving CSR, the CA validates Alices identity using the information provided. This step is crucial to ensure it is issue to the correct entity. 
	- Once validated, The CA extracts Public key and identity information from the CSR, Inforporates it inot a X.509 certificate 
	- Then sends it right back to Alice 
4. **Attributes of the X.509 Certificate**:
	-  This is then issued to include several attributes, such as the *subjects public key* and *expiration date*, *Common Name* (**CN**), Which identifies the subject (eg `www.linkedin.com`)
	- Certificates may also include **Subject Alternative Names (SANs)**, which allow multiple domain names to be associated with the certificate.


#### Generating a Certificate Using OpenSSL

- **OpenSSL** is a common tool used to generate a CSR. Below is a brief outline of the process:
    - Run the command: `openssl req -new -newkey rsa:2048`
    - Enter a password to protect the private key, then re-enter it.
    - Provide additional information, such as country code, state, city, CA, and organizational unit (if applicable).
    - Specify the server or hostname and an email address.
    - Optionally, set a challenge password.
    - OpenSSL will generate a CSR, which can then be submitted to a CA to request an X.509 certificate.

---

### Important Points for Sec+ Exam

- **X.509 Standard**: Understand that digital certificates adhere to the X.509 standard, which is crucial for secure digital communication.
- **Certificate Signing Request (CSR)**: Know the process of generating a CSR, including the information it contains and its role in obtaining a digital certificate.
- **Certificate Authority (CA)**: Be aware that a CA is responsible for validating the identity of the requester and issuing the X.509 certificate.
- **Common Name (CN) and SANs**: Recognize the significance of the CN attribute and Subject Alternative Names (SANs) in identifying the subject of a certificate.

