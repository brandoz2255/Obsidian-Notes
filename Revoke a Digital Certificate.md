
----

### Certificate Revocation

**Certificate Revocation** is a process that invalidates compromised or otherwise untrusted digital certificates, ensuring that they can no longer be used for secure communications.

#### Methods of Certificate Revocation

1. **Certificate Revocation List (CRL)**:
    
    - A **Certificate Revocation List (CRL)** is a list maintained by a Certificate Authority (CA) that contains the serial numbers of revoked certificates.
    - When a CA revokes a certificate, it places the serial number of that certificate on its CRL.
    - Entities that rely on the CA can check the CRL to ensure that they are not using a revoked certificate.
2. **Online Certificate Status Protocol (OCSP)**:
    
    - **OCSP** provides real-time verification of a certificate's status.
    - When an entity needs to verify a certificate, it sends an OCSP request to the CA.
    - The CA checks the certificate's serial number and provides an immediate status update, indicating whether the certificate is valid, revoked, or unknown.



----

### Important Points for Sec+ Exam

- **Certificate Revocation**: Understand the importance of revoking compromised digital certificates to maintain security.
- **CRL (Certificate Revocation List)**: Be aware that a CRL is a list of revoked certificates maintained by a CA and that entities must check the CRL to avoid using revoked certificates.
- **OCSP (Online Certificate Status Protocol)**: Recognize that OCSP provides real-time verification of certificate status, offering an alternative to the CRL method.