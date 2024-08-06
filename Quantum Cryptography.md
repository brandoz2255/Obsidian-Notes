- Elliptic Curve and Quantum Cyrptography
- Asymmetric Cryptography is based upon the difficulty of solving complex math problems
- Prime Numbers are divisble by themselvs and 1 
- FFactoring Prime numbbers 
	- 15 is th product of two primes 
	- 21 as well 
	- RSA use much larger prime numbers like 33878633 we wont be able to find the primes quickly 
	- Findin a way to solve the rpome factor probl;em would rbeak  modern cryptography 
	- ECC aka Elliptic curce cryptography uses the EC discrete log problem 
	- Exam Tips different  approach them prime numbers just remember thats all we need to know (but as a computer scientist i am curious on fully understanding the background ill lok it up when i have time)
	- Quantum computing 
		- can defeat prime numbers 
		- ECC wont providfe agaisnt quantum attacks 
		- Quantum may be used to develope stronger crytography 


**Elliptic Curve Cryptography**(*ECC*): Is an asymmetric encryption technique that relies on the mathematical properties of elliptic curves to provide security. It offers strong security with shorter key lengths compared to traditional algorithms like RSA

- Is an approach to Public-key encryption base ddon  algebraic structuer of elliptic curve. 

**How ECC Works:**

- **Elliptic Curves:** ECC uses the mathematics of elliptic curves over finite fields. An elliptic curve is defined by an equation of the form $y^2 = x^3 + ax + b$
- **ECC Discrete Logarithm Problem:** The security of ECC is based on the difficulty of solving the elliptic curve discrete logarithm problem (ECDLP), which involves finding a point on the curve given a starting point and a scalar multiple.

**Advantages of ECC:**

- **Shorter Key Lengths:** ECC provides equivalent security to RSA with much shorter key lengths. For example, a **256-bit** ECC key is considered as secure as a **3072-bit** RSA key.
- **Efficiency:** *ECC* requires less computational power, making it ideal for environments with limited resources, such as mobile devices and IoT devices.

- **Security Considerations**: 
	- Quantum Computing: Like other Asymmetric algorithms ECC is vulnerable to Quantum attacks.  in which Quantum computers could potentially solve the ECDLP efficiently compromising ECC securities. 

**Current Usage:**

- ECC is widely used in secure communications, including SSL/TLS, cryptocurrencies, and digital signatures.

**Key Facts and Exam Tips for ECC:**

1. **ECC vs. RSA:**
    
    - Understand that ECC provides similar security to RSA but with shorter key lengths and greater efficiency.
2. **Mathematical Basis:**
    
    - Be familiar with the elliptic curve discrete logarithm problem as the foundation of ECC’s security.
3. **Use Cases:**
    
    - Know that ECC is used in various secure communication protocols, particularly in environments with resource constraints.
4. **Quantum Threat:**
    
    - Be aware that ECC, like RSA, is vulnerable to quantum computing attacks.

[ECC](https://en.wikipedia.org/wiki/Elliptic-curve_cryptography)

**Quantum Cryptography:** This leverages the principle of quantum mechanics to create secure communication methods that  are theoretically immune to traditional computational attacks. 

- **Quantum Computing**: have the potential to break most modern algorithms by solving complex mathematical problems efficiently. 
- **Quantum Supremacy:** Achieving quantum supremacy mean that quantum computers can solve problems beyond the reach of regular Computers. 

- **Quantum Cryptography Techniques:**
    
    - **Quantum Key Distribution (QKD):** Uses quantum mechanics to securely distribute encryption keys between parties. The most famous protocol is BB84, which allows two parties to share a secret key over an insecure channel.
    - **Quantum-Resistant Algorithms:** Efforts are underway to develop cryptographic algorithms that are secure against quantum attacks. These include lattice-based cryptography, hash-based cryptography, and others.

**Key Facts and Exam Tips for Quantum Cryptography:**

1. **Quantum Threat:**
    
    - Understand the potential of quantum computers to break traditional cryptographic algorithms like RSA and ECC.
2. **Quantum Key Distribution:**
    
    - Be familiar with QKD and its role in providing theoretically secure key exchange.
3. **Quantum-Resistant Algorithms:**
    
    - Know that efforts are underway to develop cryptographic algorithms resistant to quantum attacks.
4. **Quantum Supremacy:**
    
    - Recognize the concept of quantum supremacy and its implications for cryptography.