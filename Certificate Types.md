
-------
### Types of Certificates and Their Validation Levels

**Root Certificates**

- **Root Certificates**: These are the core certificates of a Certificate Authority (CA) and are crucial for the entire PKI system. 
	- The CA's private keys, which are used to sign other certificates, are protected by the root certificates. 
	- They form the foundation of trust in the certificate hierarchy.

**Wildcard Certificates**

- **Wildcard Certificates**: These certificates cover an entire domain, allowing them to match many different subjects within that domain.
    - Example: A wildcard certificate with the name `*.linkedin.com` is valid for `www.linkedin.com`, `mail.linkedin.com`, or any other subdomain that ends with `linkedin.com`.
    - **Security Considerations**: Wildcard certificates must be carefully secured due to their broad applicability.
    - **Usage**: Commonly used in load balancing to manage traffic across multiple servers within the same domain.
    - **Limitations**: Wildcard certificates only cover one level deep in the domain hierarchy (e.g., `*.example.com` covers `sub.example.com` but not `sub.sub.example.com`).

**Certificate Authority (CA) Responsibilities**

- CAs are responsible for issuing certificates and vouching for the identity of the certificate subject. 
- The level of validation depends on the type of certificate being issued.

#### Types of Certificate Validation

1. **Domain Validation (DV)**
    
    - **Purpose**: Verifies domain ownership.
    - **Process**: The CA checks that the applicant has control over the domain in question.
	    - This is usually done by responding to an email sent to the domain's admin contact or by placing a specific file on the domain's server.
1. **Organizational Validation (OV)**
    
    - **Purpose**: Verifies the business name and the organization behind the domain.
    - **Process**: The CA checks the legitimacy of the business, often by reviewing legal documentation and verifying that the organization exists at the registered address.
3. **Extended Validation (EV)**
    
    - **Purpose**: Provides the highest level of trust by requiring an extensive investigation.
    - **Process**: The CA conducts a thorough review of the applicant's business, including legal, physical, and operational checks, before issuing the certificate. 
	    - This process ensures that the entity behind the certificate is trustworthy.

---

### Important Points for Sec+ Exam

- **Root Certificates**: Understand that root certificates are the foundation of the PKI and protect the CA's private keys.
- **Wildcard Certificates**: Recognize that wildcard certificates cover an entire domain and must be carefully secured due to their broad usage.
- **Certificate Validation Levels**: Know the different types of validation:
    - **Domain Validation (DV)**: Verifies domain ownership.
    - **Organizational Validation (OV)**: Verifies the business name and legitimacy.
    - **Extended Validation (EV)**: Requires extensive investigation and provides the highest level of trust.