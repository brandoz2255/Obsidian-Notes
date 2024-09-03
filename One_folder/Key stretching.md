
### Key Stretching

**Key stretching** a technique used to enhance the security of an encryption key derived from a relatively insecure value. 
- values such as a password 
- goal is to make it more resilient against attacks such as dictionary attacks

#### How Key Stretching Works

- **Insecure Value**: Typically a password and is more commonly used which weak against *brute force* or *dictionary attacks*
- **Mathematical Algorithm**: Key Stretching applies math to the algorithim to make the keys more complex and the passwords more complex 
	- so that the attackers don't brute force their way 
	- increasing the difficulty of brute forcing the keys

#### Key Stretching Techniques

Two kinds of Techniques are used in Key Stretching

- **Salting**: adds a unique value at the end of the key which ends up making it unique and harder to guess the password. Also makes it harder against Rainbow Table attacks
- **Hashing**: The resulting value from the salting process is then hashed making harder to brute- force the keys adding time to the verification process

#### Key Stretching Algorithms

- **PBKDF2 (Password-Based Key Derivation Function v2)**
	- Combines salting and hashing to stretch a key 
	- Should be applied to at least 4000 times to ensure the security

- **bcrypt**
	- Based on the Blowfish encryption algorithm.
	- Uses a hashing approach combined with salting to strengthen the key.

----------- 

### Important Points for Sec+ Exam

- **Understand Key Stretching**: Know that key stretching enhances the security of an encryption key derived from a password by using techniques like salting and hashing.
- **Salting and Hashing**: Recognize the importance of these techniques in making passwords more resistant to attacks.
- **PBKDF2**: Remember that this algorithm should be run at least 4000 times for effective key stretching.
- **bcrypt**: Be aware that bcrypt uses the Blowfish algorithm, adding both salting and hashing to create a strong, secure key.
- **Security Against Attacks**: Key stretching is essential for defending against dictionary attacks and brute-force attacks by slowing down the attack process.