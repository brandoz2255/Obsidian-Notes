
Did this assignment on Obsidian a notetaking application  So I could have these in my notes!

### **Question 1**

**Given:**

- `$s0 = 0x80000B60`

- `$s1 = 0xE0050230`    

#### **a. What is the value of $t0 for the following assembly code?**

`add $t0, $s0, $s1`

**Process:**

1. **Convert Hex to Binary:**


`$s0 = 0x80000B60 = 1000 0000 0000 0000 0000 1011 0110 0000_2`
`$s1 = 0xE0050230 = 1110 0000 0000 0101 0000 0010 0011 0000_2`

```
1000 0000 0000 0000 0000 1011 0110 0000 ($s0)
 + 1110 0000 0000 0101 0000 0010 0011 0000 ($s1) 
----------------------------------------------- 
1 0110 0000 0000 0101 0000 1101 1001 0000 (Result)
```

 The result has a 33rd bit (carry-out), which is discarded. The 32-bit result is taken. `$t0 = 0110 0000 0000 0101 0000 1101 1001 0000_2`

 **Convert Binary back to Hex:** `$t0 = 0x60050D90`

**Final Answer:** `$t0 = 0x60050D90`

#### **b. Is the result in $t0 the desired result, or has there been overflow?**

**Process:**

**Check Signs:** In two's complement, a leading '1' indicates a negative number and a leading '0' indicates a positive number.

- Sign of `$s0` (MSB is 1) -> Negative
- Sign of `$s1` (MSB is 1) -> Negative
- Sign of `$t0` (MSB is 0) -> Positive

**Determine Overflow:** Overflow occurs if the sum of two numbers with the same sign results in a number with the opposite sign.

- (Negative) + (Negative) = (Positive) -> **Overflow has occurred.**

**Final Answer:** Yes, there has been an overflow.

**Process:**

 **Find Two's Complement of `$s1`:** Subtraction is performed by adding the two's complement.

- Original `$s1`: `1110 0000 0000 0101 0000 0010 0011 0000`
-  Invert bits: `0001 1111 1111 1010 1111 1101 1100 1111`
- Add 1: `0001 1111 1111 1010 1111 1101 1101 0000`
- So, `-$s1 = 0x1FFADCD0`


Add `$s0` and `-$s1`:

```
1000 0000 0000 0000 0000 1011 0110 0000 ($s0) + 0001 1111 1111 1010 1111 1101 1101 0000 (-$s1) 
-----------------------------------------------
 1010 0000 0000 0000 0000 1001 0011 0000 (Result)
```

- `$t0 = 1010 0000 0000 0000 0000 1001 0011 0000_2`
    
- **Convert Binary back to Hex:** `$t0 = 0xA0000930`

**Final Answer:** `$t0 = 0xA0000930`

#### **d. Is the result in $t0 the desired result, or has there been overflow?**

**Process:**
**Check Signs:**
d
Sign of `$s0` (MSB is 1) -> Negative

The operation is `sub $s0, $s1`, which is `$s0 + (-$s1)`. Since `$s1` is negative, `-$s1` is positive.

The effective operation is (Negative) + (Positive).

Sign of result `$t0` (MSB is 1) -> Negative.


**Final Answer:** The result is the desired result; there has been no overflow.

### **Question 2**

**Given:**

 `$t0 = 0xAAAAAAAA`

 `$t1 = 0x12345678`


#### **a. What is the value of $t2?**

`sll $t2, $t0, 4` `or $t2, $t2, $t1`


**`sll $t2, $t0, 4`** (Shift Left Logical)

- `$t0` in binary: `1010 1010 1010 1010 1010 1010 1010 1010`

- Shift left by 4, adding zeros on the right: `1010 1010 1010 1010 1010 1010 1010 0000`

- Result in hex: `$t2 = 0xAAAAAAA0`

**`or $t2, $t2, $t1`** (Bitwise OR)

```
1010 1010 1010 1010 1010 1010 1010 0000 ($t2) | 0001 0010 0011 0100 0101 0110 0111 1000 ($t1)
 -----------------------------------------------
  1011 1010 1011 1110 1111 1110 1111 1000 (Result)
```

**Convert result to Hex:** `Result = 0xBABEFEF8`

**Final Answer:** `$t2 = 0xBABEFEF8`


#### **What is the value of $t2?**

`sll $t2, $t0, 4` `andi $t2, $t2, -1`

**Process:**

**`sll $t2, $t0, 4`**: Same as above, `$t2` becomes `0xAAAAAAA0`.
   
 **`andi $t2, $t2, -1`** (AND Immediate)

 The immediate value `-1` in 32-bit two's complement is `0xFFFFFFFF` (all ones).
   
Performing a bitwise AND with a mask of all ones does not change the original value.

**Final Answer:** `$t2 = 0xAAAAAAA0`

c. What is the value of $t2?

`srl $t2, $t0, 3` `andi $t2, $t2, 0xFFEF`


**`srl $t2, $t0, 3`** (Shift Right Logical)

`$t0`: `1010 1010 1010 1010 1010 1010 1010 1010`

Shift right by 3, adding zeros on the left: `0001 0101 0101 0101 0101 0101 0101 0101`

Result in hex: `$t2 = 0x15555555`

**`andi $t2, $t2, 0xFFEF`** (AND Immediate)

The 16-bit immediate `0xFFEF` is zero-extended to `0x0000FFEF`.

```
0001 0101 0101 0101 0101 0101 0101 0101 ($t2) & 0000 0000 0000 0000 1111 1111 1110 1111 (0x0000FFEF) 
-----------------------------------------------
 0000 0000 0000 0000 0101 0101 0100 0101 (Result)
```

**Convert result to Hex:** `Result = 0x00005545`

**Final Answer:** `$t2 = 0x00005545`


##### **Question 3**

**Given:**

`$t0 = 0x00101000`

**`slt $t2, $0, $t0`**:

"Set on Less Than". Sets `$t2` to 1 if `$0 < $t0`.
 `0 < 0x00101000` is true.
  `$t2` becomes `1`.

**`bne $t2, $0, ELSE`**:

"Branch if Not Equal". Jumps to the `ELSE` label if `$t2 != $0`.

`1 != 0` is true.
   
The program branches to `ELSE`.

**`j DONE`**:

This instruction is skipped due to the branch.

**`ELSE: addi $t2, $t2, 2`**:

"Add Immediate". Adds 2 to `$t2`.

`$t2 = 1 + 2 = 3`.

**`DONE:`**:

**Final Answer:** `$t2 = 3`


##### **Question 4**

**Translate C code to MIPS assembly:**

**C Code:**

``` C
for(i=0; i<a; i++)
    for(j=0; j<b; j++)
        D[4*j] = i + j;
```

**Register Mapping:**

- `a`: `$s0`
- `b`: `$s1`
- `i`: `$t0`
- `j`: `$t1`

- `base address of D`: `$s2`

MIPS Assembly Code:

```asm
    # i = 0
    move $t0, $zero              # Initialize i ($t0) to 0

FOR_I:
    # for (i = 0; i < a; i++)
    slt $t3, $t0, $s0            # $t3 = 1 if i < a, else 0
    beq $t3, $zero, EXIT_I       # if (i >= a), exit outer loop

    # j = 0
    move $t1, $zero              # Initialize j ($t1) to 0

FOR_J:
    # for (j = 0; j < b; j++)
    slt $t3, $t1, $s1            # $t3 = 1 if j < b, else 0
    beq $t3, $zero, END_FOR_J    # if (j >= b), exit inner loop

    # Calculate address of D[4*j]
    sll $t4, $t1, 4              # $t4 = j * 16. The index is 4*j, and each
                                 # integer is 4 bytes, so offset = (4*j)*4 = 16*j
    add $t5, $s2, $t4            # $t5 = base address + offset

    # Calculate value: i + j
    add $t6, $t0, $t1            # $t6 = i + j

    # Store value in memory
    sw $t6, 0($t5)               # D[4*j] = i + j

    # j++
    addi $t1, $t1, 1             # Increment j
    j FOR_J                      # Loop back to FOR_J

END_FOR_J:
    # i++
    addi $t0, $t0, 1             # Increment i
    j FOR_I                      # Loop back to FOR_I

EXIT_I:
    # End of program

```

### **Question 5**

**Translate MIPS assembly to C:**

**Register Mapping:**

- `i`: `$t1`
- `result`: `$s2`
- `base address of MemArray`: `$s0`

MIPS code analysis 

- `addi $t1, $0, $0` -> `i = 0;`
- `LOOP:` -> Marks the start of a loop.
- `lw $s1, 0($s0)` -> Loads the integer at the current memory address into a temp register.
- `add $s2, $s2, $s1` -> Adds that integer to `result`.
- `addi $s0, $s0, 4` -> Increments the memory address by 4 bytes (to the next integer).
- `addi $t1, $t1, 1` -> `i++`.
- `slti $t2, $t1, 100` -> Checks if `i < 100`.
- `bne $t2, $zero, LOOP` -> If the condition is true, loop again.

The equivalent C code 