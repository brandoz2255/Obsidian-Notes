
**Steganography**: is the practice of hiding information within other secret text or data. it is often used to conceal messages or data in more larger less suspicious files making the information harder to detect. 

- **Key Points**:
	- The main goal of *Steganography* is to conceal the message file or a data within another file typically referred to as the cover file. 
	- Unlike encryption in which it makes data unreadable to unauthorized users Steganography hides the data within files so that it is not obvious  to observers. 

Where its common is where one hides text within image files which is done by making slight modifications tot he image pixels. In order to embed the information into the image file making it hidden

- **How Steganography Works:**
	- **Image Steganography:** Slight modifications are made to the pixel values of an image, typically in the least significant bits, so that the image appears unchanged to the human eye but contains hidden data.
	- **Metadata Manipulation:** Information can also be hidden within the metadata of a file, which stores information about the file itself rather than the visible content.

**Tools used**:

- **OpenStego**: is an Application designed to hide and extract information within image files. 
	- Allows for users to **embed messages** inside pixels or metadata off an image file and **also extract them**. 


**Key Points for Security+ and MCQs:**

1. **Purpose of Steganography:**
    
    - Understand that steganography is used to hide the existence of information rather than to encrypt it.
2. **Common Applications:**
    
    - Be aware that images are the most common media used for steganography.
3. **Tools for Steganography:**
    
    - Know examples of steganography tools like OpenStego and their basic functionality (hiding and extracting messages).
4. **Difference from Encryption:**
    
    - Recognize that steganography hides information, whereas encryption makes information unreadable.
5. **Detection Techniques:**
    
    - Be familiar with steganalysis techniques used to detect and analyze steganographic content.
6. **Security Implications:**
    
    - Understand that while steganography is useful for hiding data, it should be combined with encryption for enhanced security. 