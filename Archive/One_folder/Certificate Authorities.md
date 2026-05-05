
---
### Certificate Authorities (CAs) and Certificate Management

**Certificate Authorities (CAs)**: trusted organizations responsible for issuing certificates to individuals and entities. these certificates are essential for establishing secure communication over the internet. 

#### Role of Certificate Authorities

- **Trust and Verification**:
	- Users and entities rely on CAs to verify the authenticity of digital certificates 
	- to trust a certificate users validate using the CA public key
	- That processes confirms the certificate is legitimate and issued by a trusted CA
	- CA typically charge fees for their services
	- which can be a limiting factor for organizations requiring a lot

#### Self-Signed Certificates

- **Cost-Effective Solution**:
	- To avoid unnecessary cost many organizations create their own self signed certificates 
	- These certificates follow the X.509 standard but are not trusted by external parties 
	- mainly used for internal purposes
	- Larger organizations often establish their own CA

#### Certificate Chaining

- **Intermediate CAs**:
    
    - Certificate chaining: is a technique using intermediate CA to issue certificates. This method alllows organizations to issue certificates to trusted external users
    - The *chain of trust* begins with the root CA and extends through intermediate CAs
    - ultimately leading to the end certificate (e.g., a website's SSL certificate).

**Example**:

- When visiting a website like Google, you can view its certificate chain by clicking on the lock icon in your browser.
- The certificate hierarchy will display the chain of trust, showing how the end certificate is linked to a trusted root CA.
- For instance, Google's certificate may show that it was issued by an intermediate CA (e.g., GTS) but ultimately traces back to a trusted root CA.

#### Offline CAs

- **Protection of Root Keys**:
	- Offline CAs are used to protect sensitive root keys.
	- these CAs are not connected to the internet but are only used for signing the certificates of intermediate CAs within the same organization 
	- This practice helps with the risks of root key exposure 


#### Example: LinkedIn

- **Third-Party Certificates**:
    - Like many organizations, LinkedIn uses certificates issued by third-party CAs, such as DigiCert. 
    - This means they do not rely on an internal CA but instead purchase certificates from a trusted external provider.
    - In this case, the certificate hierarchy would show that the certificates belong to DigiCert, with a trusted global root likely being an offline CA.

### Importance of CAs in PKI

- **Integral Role**:
	- CAs play a huge role in the **Public Key Infrastructure** (*PKI*) by ensuring the authenticity  of trustworthiness of digital certificates. 


