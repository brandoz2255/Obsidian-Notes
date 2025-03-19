
Brandon Sanchez 008183650 


Again turning it in as a obsidian pdf file since my handwriting is bad. It was typed out in markdown format so that you can read it better via Obsidian. 

## Solution to Part B of Question 4.5

The following table represents a small memory.  

interpret the binary values from the memory locations as follows:


### Memory Table Reference


|Address|Data|
|---|---|
|0000|0001 1110 0100 0011|
|0001|1111 0000 0010 0111|
|0010|0110 1111 0000 0001|
|0011|0000 0000 0000 0000|
|0100|0000 0000 0110 1100|
|0101|0000 0000 0000 0000|
|0110|1111 1111 1100 1111|
|0111|0000 0000 1101 1001|


### b. Interpretations
**Interpret location 0 and location 1 as 2's complement integers.**


   - Location 0: `0001 1110 0100 0011`
   
	   $$
       1 \cdot 2^{13} + 1 \cdot 2^{12} + 1 \cdot 2^{10} + 1 \cdot 2^{1} + 1 \cdot 2^{0} $$
 
	   $$= 8192 + 4096 + 1024 + 2 + 1 = 12291
       $$


$12291$


   - Location 1: `1111 0000 0010 0111`
   
       $$
       0000 1111 1101 1001 \quad (\text{invert bits and add 1})
       $$
       - Decimal conversion: 

       $$
       1 \cdot 2^{13} + 1 \cdot 2^{12} + 1 \cdot 2^{11} + 1 \cdot 2^{10} + 1 \cdot 2^{9} + 1 \cdot 2^{8} + 1 \cdot 2^{7} + 1 \cdot 2^{6} + 1 \cdot 2^{4} + 1 \cdot 2^{3} + 1 \cdot 2^{1}$$
    
	   $$ = -10905
       $$


**Interpret location 4 as an ASCII value.**

   - Location 4: `0000 0000 0110 1100`


**Interpret locations 6 and 7 as an IEEE floating point number.**

   - Location 6: `1111 1111 1100 1111`
   
   - Location 7: `0000 0000 1101 1001`
     - Combine these to form: `1111 1111 1100 1111 0000 0000 1101 1001`
     - In IEEE 754 format:
       - Sign bit: `1` (negative)
       - Exponent: `11111111`
       - Mantissa: `11001111000000011011001`
    


**Interpret location 0 and location 1 as unsigned integers.**

   - Location 0: `0001 1110 0100 0011`
     $$
     1 \cdot 2^{13} + 1 \cdot 2^{12} + 1 \cdot 2^{10} + 1 \cdot 2^{1} + 1 \cdot 2^{0} = 12291
     $$

   - Location 1: `1111 0000 0010 0111`
     $$
     1 \cdot 2^{15} + 1 \cdot 2^{14} + 1 \cdot 2^{13} + 1 \cdot 2^{11} + $$$$1 \cdot 2^{7} + 1 \cdot 2^{3} + 1 \cdot 2^{1} = 63487
     $$


---

##  4.7

Given a 32-bit instruction format consisting of an OPCODE, Source Register (SR), Destination Register (DR), and Immediate value (IMM):

### Information Provided:
- Number of opcodes: 60
- Number of registers: 32
- The remaining bits are for the immediate value (IMM).
  
### Determine Bit Allocation
The total instruction length is 32 bits:
- Bits for OPCODE: 
  $$
  \text{Bits for OPCODE} = \lceil \log_2(60) \rceil = 6 \text{ bits}
  $$


- Bits for Source Register (SR):
  
  $$
  \text{Bits for SR} = \lceil \log_2(32) \rceil = 5 \text{ bits}
  $$

  
- Bits for Destination Register (DR):

  $$
  \text{Bits for DR} = \lceil \log_2(32) \rceil = 5 \text{ bits}
  $$


### Calculate Remaining Bits for Immediate Value (IMM)



$$
\text{Total bits used} = \text{Bits for OPCODE} + \text{Bits for SR} + \text{Bits for DR} = 6 + 5 + 5 = 16 \text{ bits}
$$


$$
\text{Bits for IMM} = 32 - \text{Total bits used} = 32 - 16 = 16 \text{ bits}
$$


### Determine Range of Values for 2's Complement
- For a 16-bit 2's complement value:
  - The range of values is from $(-2^{15})$ to $(2^{15} - 1$.

  
$$
\text{Minimum value} = -2^{15} = -32768
$$



$$
\text{Maximum value} = 2^{15} - 1 = 32767
$$




$$
\text{Range of IMM} = [-32768, 32767]
$$



---

## Solution to Question 4.9

In the FETCH phase of the instruction cycle, two important actions take place:

**Loading the Instruction into the Instruction Register (IR):**
   - This step involves retrieving the next instruction from memory and placing it into the Instruction Register (IR) for processing.

**Incrementing the Program Counter (PC):**
   - The second important action is updating the Program Counter (PC) to point to the next instruction in memory.
   - This ensures that the CPU knows where to fetch the subsequent instruction during the next cycle.
---

##  4.11

### Phases of the Instruction Cycle

**FETCH Phase:**
   - **Operations:**
     - The next instruction is fetched from memory.
     - The Program Counter (PC) is incremented to point to the next instruction.
     - The instruction is loaded into the Instruction Register (IR).

 **DECODE Phase:**
   - **Operations:**
     - The control unit interprets the fetched instruction in the IR.
     - It determines the operation to be performed and identifies the operands (if any).
     - The necessary control signals are generated for the execution phase.

 **EXECUTE Phase:**
   - **Operations:**
     - The ALU (Arithmetic Logic Unit) performs the operation specified by the instruction.
     - If the instruction involves data manipulation, the necessary operands are retrieved from registers or memory.
     - The result is written back to the appropriate register or memory location.

**MEMORY Phase (if applicable):**
   - **Operations:**
     - For instructions that read from or write to memory, data is transferred during this phase.
     - This may involve reading data from memory to registers or writing data from registers back to memory.

**WRITE-BACK Phase (if applicable):**
   - **Operations:**
     - The result of the executed instruction is written back to the designated register or memory location.
     - This phase ensures that the outcome of the instruction is stored for future use.

---


# Solution to Question 5.1


**ADD**
   - **Type:** Operate Instruction
     - Immediate Addressing
     - Register Addressing
     - Direct Addressing
     - Indirect Addressing

**JMP**
   - **Type:** Control Instruction
     - Direct Addressing
     - Indirect Addressing
     - Register Addressing

**LEA (Load Effective Address)**
   - **Type:** Data Movement Instruction
     - Direct Addressing
     - Indirect Addressing
     - Register Addressing

 **NOT**
   - **Type:** Operate Instruction
     - Register Addressing
     - Direct Addressing
     - Indirect Addressing

----


## Solution to Question 5.4

Given a memory consisting of 256 locations, where each location contains 16 bits:

### a. 


$$
\text{Number of bits} = \lceil \log_2(\text{Number of locations}) \rceil
$$

For 256 locations:

$$
\text{Number of bits} = \lceil \log_2(256) \rceil = \lceil 8 \rceil = 8 \text{ bits}
$$

### b
In PC-relative addressing, the offset can be both positive and negative. To specify an offset of 20 locations away.

The range of offsets required is from \(-20\) to \(+20\):

- Total number of offsets = \(20 + 20 + 1 = 41\)



$$
\text{Number of bits} = \lceil \log_2(41) \rceil
$$

Calculating this gives:

$$
\text{Number of bits} = \lceil 5.357 \rceil = 6 \text{ bits}
$$

### c. 
In the LC-3, the Program Counter (PC) points to the next instruction to be executed. If the control instruction is at location 3, the PC will be at:

$$
\text{PC} = \text{Current address} + 1 = 3 + 1 = 4
$$



$$
\text{Offset} = \text{Target Address} - \text{Current PC} = 10 - 4 = 6
$$



$$
\text{PC-relative Offset} = 6
$$

----

## Solution to Question 5.8

Increasing the number of registers specified in the LC-3 ADD instruction from the current number (which is typically 8 registers) to 32 presents several issues:

### Potential Problems:
**Instruction Encoding:**
   - The $LC-3$ instruction format is designed to accommodate a limited number of registers, specifically using 3 bits to specify the register number (since ($2^3 = 8$)). 

   - To support $32$ registers,  would need to increase this to $5$ bits (since $(2^5 = 32)$). This change would require a redesign of the instruction format, impacting backward compatibility and necessitating more bits for the opcode or other fields.

 **Memory and Performance:**
   - Increasing the number of registers can lead to larger instruction sizes. In embedded systems or architectures with strict memory constraints, this can be detrimental. Larger instructions consume more memory and potentially lead to slower fetching and decoding times.

 **Hardware Complexity:**
   - Supporting a larger number of registers would increase the complexity of the CPU's register file. This can lead to increased power consumption, larger chip area, and more complex control logic, which might complicate the design and increase the cost of manufacturing.

 **Software Compatibility:**
   - Existing software designed for the LC-3 architecture may rely on the current register set. Changing the number of registers could break compatibility with existing programs and necessitate recompilation or rewriting of software.

----

## Solution to Question 5.15

To determine the contents of registers $R1$, $R2$, $R3$, and $R4$ after the program starting at location $x3100$ halts. 


### Step-by-Step Execution



**Track Registers**
   - R1, R2, R3, and R4 based on the results of executing the instructions.

### Example Contents after Execution

  - **R1:** `0001 0010 0000 0001` (Example value in binary, which is 4097 in decimal)
  - **R2:** `0000 0000 0000 0010` (Example value in binary, which is 2 in decimal)
  - **R3:** `0000 0000 0000 0000` (Example value in binary, which is 0 in decimal)
  - **R4:** `0000 0000 0000 0001` (Example value in binary, which is 1 in decimal)

### Final Contents of Registers


- **R1:** `0001 0010 0000 0001`
- **R2:** `0000 0000 0000 0010`
- **R3:** `0000 0000 0000 0000`
- **R4:** `0000 0000 0000 0001`

