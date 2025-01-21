# Data Obfuscation


**Data Obfuscation**: is a technique used to transform data into a fromat that is unreadable or less undertandable to unauthorized users. 

- This goal is to protect sensitive information such as (*Personally Identifiable Information*) **PII** 

- **Data Masking**: Replacing sensitive data with fictional but realistic data (e.g., replacing real social security numbers with randomly generated numbers).

- **Tokenization**: Replacing sensitive data with a token that acts as a reference to the original data stored securely elsewhere.

- **Encryption**: Converting data into ciphertext, which can only be de-crypted with the appropriate key.

- **Anonymization**: Removing or altering data that can identify individuals, making it impossible to trace back to the original source.

- **Hashing**: A process that transforms data into a fixed size of string characters which represents a sequence of characters, numbers, or letters. You input the data then the output is the hash value/hash code which is unique to the input. 
	- **Hash Function**: A mathematical algorithm that maps data of arbitrary size to a fixed-size value. Examples include SHA-256, MD5, and SHA-3.

**Rainbow table Attacks**: method for cracking  hashes/hashed passwords by using precomputed tables containing common hash values of common passwords. 

- These tables allow attackers to reverse the hash function by comparing the hash values in the table to the target hash, significantly speeding up the process of finding the original password/data.

**Attack Process**:

- **Step 1**: An attacker obtains a hashed password from a compromised database.
- **Step 2**: The attacker uses a rainbow table that contains hashes of common passwords.
- **Step 3**: The attacker compares the obtained hash with the hashes in the rainbow table.
- **Step 4**: If a match is found, the attacker knows the corresponding plaintext password.

### Analogy

**Rainbow Table as a Cheat Sheet**:

- Imagine a student (attacker) has a cheat sheet (rainbow table) with the answers (precomputed hashes) for a set of potential questions (possible passwords or ID numbers).
- The teacher (system) stores the students' scores (hashed values) but does not reveal the actual questions (original data).
- The student (attacker) uses the cheat sheet to quickly match the answers (hashed values) to the questions (original data), revealing the questions' answers (original data).

- **Salting**: used to defend against Rainbow Tables it is used on hash values by providing a unique random value callled a salt to each password before it is hashed. This ensures that if two users have the same password  the hash values are different. \

in short 
- **Salt**: A random value added to the plaintext password before hashing.

**How It Works**:

- **Step 1**: Generate a random salt value for each password.
- **Step 2**: Combine the salt with the password.
- **Step 3**: Hash the combined salt and password.
- **Step 4**: Store the salt and the hashed value in the database.

**Verifying a Password**:

- User enters their password: `password123`
- Retrieve the stored salt: `randomSaltValue`
- Combine: `password123randomSaltValue`
- Hash: `hash(password123randomSaltValue)`
- Compare: The newly generated hash with the stored hash. If they match, the password is correct.


# Data de-identification

**Deidentification** is the process of removing or obfuscating personal identifiers from data sets to protect the privacy of individuals  

- This ensures that the data cannot be traced back to specific individuals, making it suitable for use in scenarios where personal information should not be disclosed, such as in research or data analysis.

**Examples of Identifiers to Remove**:

- Names (e.g., John Doe)
- Social Security numbers
- Addresses (e.g., 123 Main St)
- Phone numbers
- Email addresses
- Medical record numbers
- Account numbers

Where all you need is a ZIP code a DOB and gender of the individual which alone makes you 87% unique. 


**Health Insurance Portability and Accountability Act (HIPAA)** sets the standard for protecting sensitive patient data in the United States. 

- **HIPAA Privacy Rule**: A federal regulation that aims to protect the privacy of patients' health information. It outlines how PHI should be used and disclosed by covered entities.

The **HIPAA Privacy Rule** is a key component of HIPAA, which establishes national standards for the protection of individually identifiable health information, known as *Protected Health Information* (**PHI**).

- **PHI**: Any information about health status, provision of healthcare, or payment for healthcare that can be linked to an individual. This includes medical records, health history, test results, and insurance information.