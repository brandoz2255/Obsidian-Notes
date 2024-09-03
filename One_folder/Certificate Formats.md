
----

# Certificate Formats

Digital Certificates come in various formats each serving different purposes and commonly used in different systems

**Digital Encoding Rules** (*DER*): 
- DER format: Most common certificate format
- is  a Binary format
- **File extensions:** DER use `.der`, `.crt`, and `.cer`

**Privacy Enhanced mail** (**PEM**)
- **PEM Format**: Stands for Privacy Enhanced Mail, Closely relates to the DER format 
- **PEM Cecrtificates**: ASCII text versions of DER 
	- can easily be converted between formats using OpenSSL 
- **File extensions**: PEM uses a `.pem`, and `.crt` file extensions 

**Exam Tip**: CRT files may represent either DER binary or PEM text certificates.
- Format binary or text can only be examined via the contents of the file
	- such as `cat` or `open` the file

**Personal Information Exchange** (*PFX*)
- **PFX Format**: Another standard format for certificates, maintained in binary form
	- **Usage**: Commonly used in Windows systems 
	- **File Extensions**: PFX certificates use `.pfx`, and `.p12` 

**P7B Format**: 
- **P7B Format**: The ASCII text equivalent of **PFX certifates**
	- **Usage**: Commonly used by Windows Systems 
	- **File extensions**: P7B uses `.p7b` file extensions 