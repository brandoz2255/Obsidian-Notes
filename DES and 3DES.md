#symmetric
# DES

**DES**: *Data Encryption Standard(DES)* is a symmetric Key algorithm for the encryption of digital data. 

- Develped by IBM in the 1970s 
- Adopted as a federal encryption standard by the **National Institute of Standards and Technology** (*NIST*) in 1977.

**Technical Details:**

- **Block Cipher:** Operates on 64-bit blocks of data.
- **Key Length:** Uses a 56-bit key for encryption, though the total key length is 64 bits (8 bits used for parity).
- **Feistel Structure:** DES uses a Feistel network structure, *which involves multiple rounds of processing to encrypt data.*

**The encryption Processes**:

- **Feistel Function (F-Function):** Used for 16 rounds of encryption. *Which is called a Round*
- **Substitution and Transposition:** Each F-box performs a combination of substitution and transposition operations.
	- Which is a 64 bit plain text block that is handed over to the **initial Permutation** (*IP*) function

![[DES.png]]

for each F boz there is a **S-box** *->* 

- **S-Boxes:** The substitution operations are broken up into eight different operations called S-boxes.
- **P-Boxes:** The output from the S-boxes is then permuted using P-boxes (permutation boxes).

![[DES_2.png]]

However this encryption is *no Longer considered Secure* **what is secure is 2048 or higher bits** for the key length is considered secure. 

[DES](https://www.geeksforgeeks.org/data-encryption-standard-des-set-1/)


# 3DES

**Definition**: **Triple** **DES** (*3DES*) is an encryption algorithm that applies the **Data Encryption Standard** (*DES*) cipher algorithm three times to each data block.

- in short it does that 16 round processes in *DES* 3 times

 Developed to improve *DES* after it was found to insecure.

Designed to work with existing DES algorithms 

- **Three Rounds of DES:** Applies DES encryption three times.
- **Key Usage:**
    - Uses three different keys (K1, K2, K3).
    - Key length results in *112 bits* of effective security.
    - Different keying options available:
        - **Keying Option 1:** K1, K2, and K3 are all different.
        - **Keying Option 2:** K1 and K3 are the same, but different from K2 (K1 = K3 ≠ K2).
        - **Keying Option 3:** All three keys are the same (K1 = K2 = K3).
- Where option 3 is the *least secure*

**How 3DES Works:**

It Operates in three steps **Encrypt-Decrypt-Encrypt** (*EDE*)

- **Process:**
    - Encrypts with K1.
    - Decrypts with K2.
    - Encrypts again with K3.

![[3DES.png]]

**Security and Usage:**

- **Key Strength:**
    - Provides a key strength of 112 bits, which is stronger than DES’s 56-bit key.
- **Applications:**
    - Used in financial services and other industries requiring higher security than DES.

 [3DES](https://www.techtarget.com/searchsecurity/tip/Expert-advice-Encryption-101-Triple-DES-explained)