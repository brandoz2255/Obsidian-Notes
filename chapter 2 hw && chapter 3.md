I typed everything out since  my handwriting is bad I also did it in MD so that you can follow it easier which why there are headers 

## 2.8 Part A: Largest Positive Number in 8-bit 2’s Complement

To find the largest positive number in 8-bit 2’s complement:

The first bit is the sign bit. For a positive number, it’s `0`.
The remaining 7 bits are set to `1`, which gives us the binary number:  
   **0111 1111**.
   
### Converting Binary to Decimal
I convert the binary `0111 1111` to decimal by summing the powers of 2 for each `1` bit:

$$
0111 1111 = 2^6 + 2^5 + 2^4 + 2^3 + 2^2 + 2^1 + 2^0
$$

This is:

- $2^6 = 64$
- $2^5 = 32$
- $2^4 = 16$
- $2^3 = 8$
- $2^2 = 4$
- $2^1 = 2$
- $2^0 = 1$

Adding these gives us:

**127** in decimal.

### Final Answer:
- **Binary**: `0111 1111`
- **Decimal**: `127`


## 2.8 Part B: Largest Magnitude Negative Number in 8-bit 2’s Complement

To find the largest negative number in 8-bit 2's complement:

 The sign bit is `1`, and all other bits are `0`.  
   This gives the binary number: **1000 0000**.

### Converting Binary to Decimal


**Inverting the bits** of `1000 0000`, which gives:  
   `0111 1111`
 **Adding 1** to `0111 1111`, resulting in:  
   `1000 0000`

Thus, `1000 0000` in binary equals **-128** in decimal.

### Final Answer:
- **Binary**: `1000 0000`
- **Decimal**: `-128`


## 2.8 Part C: Largest Positive Number in n-bit 2’s Complement

In an *n*-bit 2's complement system, the largest positive number is represented by:
 The first bit as `0` (to indicate a positive number).
All remaining \( n-1 \) bits as `1`, which gives the binary number:  
   **0...0111...1111** (with \( n-1 \) ones).

### General Formula
To find the largest positive number in decimal, we use the formula:

$$
2^{n-1} - 1
$$

### Example for n = 8:
For an 8-bit system:

$$
2^7 - 1 = 127
$$

### Final Answer for Any n-bit System:
- **Binary**: `0...0111...1111`
- **Decimal**: $$2^{n-1} - 1$$

---

## 2.8 Part D: Greatest Magnitude Negative Number in n-bit 2’s Complement

In an *n*-bit 2's complement system, the greatest magnitude negative number is represented by:

 The first bit as `1` (indicating a negative number).
All remaining \( n-1 \) bits as `0`, which gives the binary number:  
   **1000...0000** (with \( n-1 \) zeros).

### General Formula


$$
-2^{n-1}
$$

### Example for n = 8:
For an 8-bit system:

$$
-2^7 = -128
$$

### Final Answer for Any n-bit System:
- **Binary**: `1000...0000`
- **Decimal**: $-2^{n-1}$ 


---

## 2.10 Convert the following 2's complement binary numbers to decimal

### Part B: 01011010 (8-bit 2's complement)
 The MSB is `0`, so the number is positive.
 Convert directly to decimal:  
   
   $$0101 1010 = 2^6 + 2^4 + 2^3 + 2^1 = 64 + 16 + 8 + 2 = 90$$

### Final Answer:
- **Binary**: $01011010$
- **Decimal**: $90$

### Part C: 11111110 (8-bit 2's complement)
 The MSB is `1`, so the number is negative.
 **Invert the bits**:  
   $11111110 -> 00000001$
 **Add 1**:  
   $00000001 + 1 = 00000010$
 Convert `00000010` to decimal:  
   $2^1 = 2$
 Since the original number was negative, the final answer is **-2**.

### Final Answer:
- **Binary**: $11111110$
- **Decimal**: $-2$

---


## 2.11 Convert these decimal numbers to eight-bit 2’s complement binary numbers.

### Part A: 102
Convert 102 to binary:
   - Decimal $102$ = $2^6 + 2^5 + 2^2 + 2^1$ = $1100110$
Add a leading zero to fit 8-bit format:
   - 01100110
 **Result**: `01100110`

### Part D: -128
Recognize that -128 in 8-bit is a special case:
   - The only valid representation is 10000000, with the MSB as `1` and all other bits `0`.
2. **Result**: `10000000`


---
## 2.26 Express -64 as a 2’s complement number.

### Part A: How many bits do you need?
- To represent -64 in 2’s complement, the smallest number of bits needed is **7**.

### Part B: Largest Positive Number with 7 bits
- The largest positive number in 2’s complement with 7 bits is:
  $$
  2^6 - 1 = 63
  $$
- **Binary**: `0111111`
- **Decimal**: `63`

### Part C: Largest Unsigned Number with 7 bits
- The largest unsigned number with 7 bits is:
$$
  2^7 - 1 = 127
$$
- **Binary**: `1111111`
- **Decimal**: `127`


----



## 2.33 Compute the following

### Part A: 01010111 OR 11010111
Performing the OR operation bit by bit:

| Bit Position    | 0   | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
| --------------- | --- | --- | --- | --- | --- | --- | --- | --- |
| Binary 1        | 0   | 1   | 0   | 1   | 0   | 1   | 1   | 1   |
| Binary 2        | 1   | 1   | 0   | 1   | 0   | 1   | 1   | 1   |
| **Result (OR)** | 1   | 1   | 0   | 1   | 0   | 1   | 1   | 1   |

- 01010111 OR 11010111 = 11010111

### Part F: 0101 OR (1100 OR 1101)


|Bit Position|0|1|2|3|
|---|---|---|---|---|
|Binary 1|1|1|0|0|
|Binary 2|1|1|0|1|
|**Result (OR)**|


   - 1100 OR 1101 = 1101
 Now solve the outer expression:



|Bit Position|0|1|2|3|
|---|---|---|---|---|
|Binary 1|0|1|0|1|
|Binary 2|1|1|0|1|
|**Result (OR)**|1|1|0|1|
   - 0101 OR 1101 = 1101


----


## 2.39 Write IEEE floating point representation of the following decimal numbers

### Part A: 3.75

**Convert 3.75 to binary**  
   - The integer part `3` in binary is:  
     $$
     3 = 11_2
     $$
   - The fractional part `.75` in binary is:  
$$     
     0.75 = 0.11_2
$$     
   - So, 3.75 in binary is:  
     $$
     3.75 = 11.11_2
     $$

 **Normalize the binary number**  
   - Move the decimal point to the right to get the normalized form:  
     $$
     11.11_2 = 1.111 \times 2^1
     
$$

 **Determine the exponent**  
   - The exponent in binary (with a bias of 127) is calculated as:  
     $$
     1 + 127 = 128
     $$
   - So, the exponent is:  
     $$
     128 = 10000000_2
     $$


**Determine the mantissa**  
   - The mantissa is the fractional part after the decimal point in the normalized form:  
     $$
     1.111_2 \quad \Rightarrow \quad \text{Mantissa} = 11100000000000000000000
     $$

**Determine the sign**  
   - Since the number is positive, the sign bit is `0`.

 
 **Combine everything**  
   - **Sign bit**: 0  
   - **Exponent**: $10000000$  
   - **Mantissa**: $11100000000000000000000$  
   - Final IEEE 754 representation for 3.75:  
     $$
     0 \ 10000000 \ 11100000000000000000000
     $$

---

### Part B: $-55\frac{23}{64}$

 **Convert $-55\frac{23}{64}$ to decimal**  
   - First, convert the fraction to decimal:  
     $$
     -55 + \frac{23}{64} = -55 + 0.359375 = -55.359375
     $$

 **Convert $-55.359375$ to binary**  
   - The integer part `55` in binary is:  
     $$
     55 = 110111_2
     $$
   - The fractional part `0.359375` in binary is:  
     $$
     0.359375 = 0.010111_2
     $$
   - So, $-55.359375$ in binary is:  
     $$
     -55.359375 = 110111.010111_2
     $$

**Normalize the binary number**  
 
     $$
     110111.010111_2 = 1.10111010111 \times 2^5
     $$

 **Determine the exponent**  
   - The exponent in binary (with a bias of 127) is calculated as:  
     $$
     5 + 127 = 132
     $$
   - So, the exponent is:  
     $$
     132 = 10000100_2
     $$

5. **Determine the mantissa**  

     $$
     1.10111010111_2 \quad \Rightarrow \quad \text{Mantissa} = 10111010111000000000000
     $$

6. **Determine the sign**  
   - Since the number is negative, the sign bit is `1`.

7. **Combine everything**  
   - **Sign bit**: 1  
   - **Exponent**: 10000100  
   - **Mantissa**: 10111010111000000000000  
   - Final IEEE 754 representation for $-55\frac{23}{64}$:  
     $$
     1 \ 10000100 \ 10111010111000000000000
     $$


---

## 2.40 Write the decimal equivalents for these IEEE floating point numbers.

### Part A: 0 10000000 00000000000000000000000
 **Sign bit (S)**: 0 (positive number)
 **Exponent (E)**: $10000000_2 = 128$. Subtract the bias $(127)$:  
   $$
   128 - 127 = 1
   $$
   
 **Mantissa (M)**: $00000000000000000000000$. The mantissa is:  
   $$
   1.00000000000000000000000 = 1
   $$
   
 Apply the floating-point formula:  
   $$
   \text{Value} = (-1)^0 \times 1 \times 2^1 = 2
   $$
   
   
**Decimal Equivalent**: 2



### Part B: 1 1000011 00010000000000000000000
 **Sign bit (S)**: 1 (negative number)
 **Exponent (E)**: 1000011_2 = 131. Subtract the bias (127):  
   $$
   131 - 127 = 4
   $$
   
**Mantissa (M)**: 00010000000000000000000. The mantissa is:  
   $$
   1.00010000000000000000000 = 1.0625
   $$
   
 Apply the floating-point formula:  
   $$
   \text{Value} = (-1)^1 \times 1.0625 \times 2^4 = -17
   $$
   
   
**Decimal Equivalent**: -17


---



## 3.15 Fill in the truth table for the logical expression NOT(NOT(A) OR NOT(B))

### Logical Expression: NOT(NOT(A) OR NOT(B))

**NOT(A)**: Negate A.
 **NOT(B)**: Negate B.
**NOT(A) OR NOT(B)**: Perform the OR operation on NOT(A) and NOT(B).
**NOT(...)**: Negate the result of the OR operation.

### Truth Table:

| A | B | NOT(A) | NOT(B) | NOT(A) OR NOT(B) | NOT(NOT(A) OR NOT(B)) |
|---|---|--------|--------|------------------|-----------------------|
| 0 | 0 |   1    |   1    |        1         |           0           |
| 0 | 1 |   1    |   0    |        1         |           0           |
| 1 | 0 |   0    |   1    |        1         |           0           |
| 1 | 1 |   0    |   0    |        0         |           1           |

### Conclusion:

This the truth table for **NOT(NOT(A) OR NOT(B))** is the same as the truth table for the **AND** gate.

So, the logical expression **NOT(NOT(A) OR NOT(B))** is equivalent to the **AND** gate.


---

## 3.16 Fill in the truth table for a two-input NOR gate.


### Truth Table for A NOR B:

| A | B | A OR B | A NOR B |
|---|---|--------|---------|
| 0 | 0 |   0    |    1    |
| 0 | 1 |   1    |    0    |
| 1 | 0 |   1    |    0    |
| 1 | 1 |   1    |    0    |

### Basically:

 **A = 0, B = 0**:  
   - A OR B = 0  
   - A NOR B = NOT(0) = 1

 **A = 0, B = 1**:  
   - A OR B = 1  
   - A NOR B = NOT(1) = 0

 **A = 1, B = 0**:  
   - A OR B = 1  
   - A NOR B = NOT(1) = 0

 **A = 1, B = 1**:  
   - A OR B = 1  
   - A NOR B = NOT(1) = 0

---

## 3.29 Fill in the truth table for the logic circuit in Figure 3.41.

### Logic Circuit Breakdown:
 **AND1**: A AND B
 **AND2**: B AND C
 **OR1**: (A AND B) OR (B AND C)
 **NOT1**: NOT((A AND B) OR (B AND C))
 **AND3**: C AND NOT((A AND B) OR (B AND C)) = Z

### Step-by-Step Calculation:

| A | B | C | A AND B | B AND C | (A AND B) OR (B AND C) | NOT((A AND B) OR (B AND C)) | Z = C AND NOT((A AND B) OR (B AND C)) |
|---|---|---|---------|---------|------------------------|-----------------------------|--------------------------------------|
| 0 | 0 | 0 |    0    |    0    |           0            |             1               |                  0                   |
| 0 | 0 | 1 |    0    |    0    |           0            |             1               |                  1                   |
| 0 | 1 | 0 |    0    |    0    |           0            |             1               |                  0                   |
| 0 | 1 | 1 |    0    |    1    |           1            |             0               |                  0                   |
| 1 | 0 | 0 |    0    |    0    |           0            |             1               |                  0                   |
| 1 | 0 | 1 |    0    |    0    |           0            |             1               |                  1                   |
| 1 | 1 | 0 |    1    |    0    |           1            |             0               |                  0                   |
| 1 | 1 | 1 |    1    |    1    |           1            |             0               |                  0                   |

### Final Truth Table:

| A | B | C | Z |
|---|---|---|---|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 |
