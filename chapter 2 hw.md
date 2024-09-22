## 2.8 Part A: Largest Positive Number in 8-bit 2’s Complement

To find the largest positive number in 8-bit 2’s complement:

1. The first bit is the sign bit. For a positive number, it’s `0`.
2. The remaining 7 bits are set to `1`, which gives us the binary number:  
   **0111 1111**.
   
### Converting Binary to Decimal
We convert the binary `0111 1111` to decimal by summing the powers of 2 for each `1` bit:

\[
0111 1111 = 2^6 + 2^5 + 2^4 + 2^3 + 2^2 + 2^1 + 2^0
\]

This is:

- \(2^6 = 64\)
- \(2^5 = 32\)
- \(2^4 = 16\)
- \(2^3 = 8\)
- \(2^2 = 4\)
- \(2^1 = 2\)
- \(2^0 = 1\)

Adding these gives us:

**127** in decimal.

### Final Answer:
- **Binary**: `0111 1111`
- **Decimal**: `127`


## 2.8 Part B: Largest Magnitude Negative Number in 8-bit 2’s Complement

To find the largest negative number in 8-bit 2's complement:

1. The sign bit is `1`, and all other bits are `0`.  
   This gives the binary number: **1000 0000**.

### Converting Binary to Decimal

In 2's complement, the largest magnitude negative number is calculated by:
1. **Inverting the bits** of `1000 0000`, which gives:  
   `0111 1111`
2. **Adding 1** to `0111 1111`, resulting in:  
   `1000 0000`

Thus, `1000 0000` in binary equals **-128** in decimal.

### Final Answer:
- **Binary**: `1000 0000`
- **Decimal**: `-128`


## 2.8 Part C: Largest Positive Number in n-bit 2’s Complement

In an *n*-bit 2's complement system, the largest positive number is represented by:
1. The first bit as `0` (to indicate a positive number).
2. All remaining \( n-1 \) bits as `1`, which gives the binary number:  
   **0...0111...1111** (with \( n-1 \) ones).

### General Formula
To find the largest positive number in decimal, we use the formula:

\[
2^{n-1} - 1
\]

### Example for n = 8:
For an 8-bit system:

\[
2^7 - 1 = 127
\]

### Final Answer for Any n-bit System:
- **Binary**: `0...0111...1111`
- **Decimal**: \( 2^{n-1} - 1 \)

---

## 2.8 Part D: Greatest Magnitude Negative Number in n-bit 2’s Complement

In an *n*-bit 2's complement system, the greatest magnitude negative number is represented by:
1. The first bit as `1` (indicating a negative number).
2. All remaining \( n-1 \) bits as `0`, which gives the binary number:  
   **1000...0000** (with \( n-1 \) zeros).

### General Formula
To find the greatest magnitude negative number in decimal, we use the formula:

\[
-2^{n-1}
\]

### Example for n = 8:
For an 8-bit system:

\[
-2^7 = -128
\]

### Final Answer for Any n-bit System:
- **Binary**: `1000...0000`
- **Decimal**: \( -2^{n-1} \)


---

## 2.10 Convert the following 2's complement binary numbers to decimal

### Part B: 01011010 (8-bit 2's complement)
1. The MSB is `0`, so the number is positive.
2. Convert directly to decimal:  
   0101 1010 = 2^6 + 2^4 + 2^3 + 2^1 = 64 + 16 + 8 + 2 = 90

### Final Answer:
- **Binary**: 01011010
- **Decimal**: 90

### Part C: 11111110 (8-bit 2's complement)
1. The MSB is `1`, so the number is negative.
2. **Invert the bits**:  
   11111110 -> 00000001
3. **Add 1**:  
   00000001 + 1 = 00000010
4. Convert `00000010` to decimal:  
   2^1 = 2
5. Since the original number was negative, the final answer is **-2**.

### Final Answer:
- **Binary**: 11111110
- **Decimal**: -2

---


## 2.11 Convert these decimal numbers to eight-bit 2’s complement binary numbers.

### Part A: 102
1. Convert 102 to binary:
   - Decimal 102 = \(2^6 + 2^5 + 2^2 + 2^1\) = 1100110
2. Add a leading zero to fit 8-bit format:
   - 01100110
3. **Result**: `01100110`

### Part D: -128
1. Recognize that -128 in 8-bit is a special case:
   - The only valid representation is 10000000, with the MSB as `1` and all other bits `0`.
2. **Result**: `10000000`


---
## 2.26 Express -64 as a 2’s complement number.

### Part A: How many bits do you need?
- To represent -64 in 2’s complement, the smallest number of bits needed is **7**.

### Part B: Largest Positive Number with 7 bits
- The largest positive number in 2’s complement with 7 bits is:
  \[
  2^6 - 1 = 63
  \]
- **Binary**: `0111111`
- **Decimal**: `63`

### Part C: Largest Unsigned Number with 7 bits
- The largest unsigned number with 7 bits is:
  \[
  2^7 - 1 = 127
  \]
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
1. Solve the inner expression first:


|Bit Position|0|1|2|3|
|---|---|---|---|---|
|Binary 1|1|1|0|0|
|Binary 2|1|1|0|1|
|**Result (OR)**|


   - 1100 OR 1101 = 1101
3. Now solve the outer expression:



|Bit Position|0|1|2|3|
|---|---|---|---|---|
|Binary 1|0|1|0|1|
|Binary 2|1|1|0|1|
|**Result (OR)**|1|1|0|1|
   - 0101 OR 1101 = 1101


----


## 2.39 Write IEEE floating point representation of the following decimal numbers

### Part A: 3.75

1. **Convert 3.75 to binary**  
   - The integer part `3` in binary is:  
     \[
     3 = 11_2
     \]
   - The fractional part `.75` in binary is:  
     \[
     0.75 = 0.11_2
     \]
   - So, 3.75 in binary is:  
     \[
     3.75 = 11.11_2
     \]

2. **Normalize the binary number**  
   - Move the decimal point to the right to get the normalized form:  
     \[
     11.11_2 = 1.111 \times 2^1
     \]

3. **Determine the exponent**  
   - The exponent in binary (with a bias of 127) is calculated as:  
     \[
     1 + 127 = 128
     \]
   - So, the exponent is:  
     \[
     128 = 10000000_2
     \]

4. **Determine the mantissa**  
   - The mantissa is the fractional part after the decimal point in the normalized form:  
     \[
     1.111_2 \quad \Rightarrow \quad \text{Mantissa} = 11100000000000000000000
     \]

5. **Determine the sign**  
   - Since the number is positive, the sign bit is `0`.

6. **Combine everything**  
   - **Sign bit**: 0  
   - **Exponent**: 10000000  
   - **Mantissa**: 11100000000000000000000  
   - Final IEEE 754 representation for 3.75:  
     \[
     0 \ 10000000 \ 11100000000000000000000
     \]

---

### Part B: \(-55\frac{23}{64}\)

1. **Convert \(-55\frac{23}{64}\) to decimal**  
   - First, convert the fraction to decimal:  
     \[
     -55 + \frac{23}{64} = -55 + 0.359375 = -55.359375
     \]

2. **Convert \(-55.359375\) to binary**  
   - The integer part `55` in binary is:  
     \[
     55 = 110111_2
     \]
   - The fractional part `0.359375` in binary is:  
     \[
     0.359375 = 0.010111_2
     \]
   - So, \(-55.359375\) in binary is:  
     \[
     -55.359375 = 110111.010111_2
     \]

3. **Normalize the binary number**  
   - Normalize the binary to get:  
     \[
     110111.010111_2 = 1.10111010111 \times 2^5
     \]

4. **Determine the exponent**  
   - The exponent in binary (with a bias of 127) is calculated as:  
     \[
     5 + 127 = 132
     \]
   - So, the exponent is:  
     \[
     132 = 10000100_2
     \]

5. **Determine the mantissa**  
   - The mantissa is the fractional part after the decimal point in the normalized form:  
     \[
     1.10111010111_2 \quad \Rightarrow \quad \text{Mantissa} = 10111010111000000000000
     \]

6. **Determine the sign**  
   - Since the number is negative, the sign bit is `1`.

7. **Combine everything**  
   - **Sign bit**: 1  
   - **Exponent**: 10000100  
   - **Mantissa**: 10111010111000000000000  
   - Final IEEE 754 representation for \(-55\frac{23}{64}\):  
     \[
     1 \ 10000100 \ 10111010111000000000000
     \]
