
---

### Uses of Digital Certificates

While digital certificates are most commonly used to protect web services, they also provided authentication for individuals, devices, and various other services

#### Certificate Subject

- **Certificate Subject**: The owner of the  public key included the certificate 
	- For example in LinkedIns digital certificate there is a section for the subject which provides info about the entity that owns the public key 
	- The certificate subject can include names, email, addresses, and other identifying information relevant  to the owner 

#### Certificate Hierarchy

- **Top CA in the Chain**: The top Certificate Authority (CA) in the certificate chain is responsible for validating the entire chain of trust 
	- in this example LinkedIn, the top CA might be DigiCert, which the browser trusts this root 
	- Allowing validation of the site 
	- The Keychain Access Tool (on MacOS) can be used to view all root certificates trusted by the browser

#### Object Identifiers (OIDs)

- **OIDs in Digital Certificates**: Object Identifiers (OIDs) are strings of numbers similar in appearance to IP addresses used to uniquely identify objects within certificates
	- **Exam Tip**: Be aware of Certificate Object Identifiers  (OIDs) as they appear in exam questions 
		- *OIDs* are important for identifying specific attributes or policies associated with digital signatures 


#### Other Certificate Subjects

- Certificates are not limited to web servers; they can also be used for:
    - **Web, SSH, File, Email**: Authentication for these services.
    - **Devices**: Such as routers, switches, VPNs, and access points.
    - **Developers**: For code signing, ensuring that the code has not been altered since it was signed.

### Certificate Attacks and Pinning

- **Certificate Attack**: A general term for those how attempt to undermine the security of digital certificates
	- such as man in the middle attacks or exploiting vulnerabilities 

**Certificate Pinning**:
- A security technique where the certificate is "pinned" to a specific public key or CA
- Reducing the Man in the middle attacks 
- **Function**: when a user receives certificates from a certificate subject the pinning mechanism ensures that it doesn't change or should not change. 
	- if so then there is an attack happening
- **User Instructions**: Users should be informed to remember the pin

---

### Important Points for Sec+ Exam

- **Certificate Uses**: Understand that digital certificates are used for more than just web server protection; they also authenticate individuals, devices, and services.
- **Certificate Subject**: Be familiar with the concept of a certificate subject, which includes the public key owner and other identifying information.
- **Certificate Hierarchy**: Recognize the importance of the top CA in the certificate chain, which ensures the validity of the entire chain.
- **Object Identifiers (OIDs)**: Know what OIDs are and their role in identifying specific attributes or policies within digital certificates.
- **Certificate Pinning**: Understand the concept of certificate pinning as a defense against man-in-the-middle attacks, ensuring that certificates remain unchanged.