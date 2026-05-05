# Boolean Types
The Boolean type in C++ only has two types one where it equals **True and one** where it e**quals False** this ==goes hand and hand== with **integer types** when its **greater** than 0 its True **less** than or equal to 0 is False

### Boolean literals
- There is only two literals true and false 

### Format specifiers 
- There is no specific format specifier for a Boolean type
- We could however use the integer format specifier **%d** when working with Boolean
- Set the int value to 1 for True and int value 0 for False 
```C++
#include <cstdio>

int main(){
	bool b1 = true; //b1 is true
	bool b2 = false; //b2 is false
	printf("%d %d/n", b1, b2);
}
```

- b1 and b2 is True and False as seen on the code by formatting its int values we can print whether the statement is true or false

## Comparison Operators 
**Operators**: are functions in C++ and most programming languages that do **operands** which essentially is just an object. 

- Comparison operators are the idea in which using the signs to check for a statement like an error check in Python
- Comparison operators use the **`= =`, !=, >, <, <=,>= etc**
- For example:

```C++
code snipet on page 39
```

- Each comparison will result in a **bool** and **printf** just prints the bool as an **int**

## Logical Operators
**Logical Operators**: are operators that use boolean logic on different bool types

- How we characterize operators is based on how many operators and operand can take 
- For example unary operator takes one and binary takes two and ternary takes three and so and so for. 
- A negation unary operator on the other hand uses the ! statement and reads it as the opposite or prints out the opposite **!true** = false **!false** = true for example
- Logical operators on the other are binary in which they use **&&** and **||** they only work if both operands are true

```C++
Code snipet page 40
```

- Here we see the logical AND operator logical OR operator and negation operator

goes in depth on page 182 
# The STD:Byte type
As a programmer there might be a situation in which one has to work with the raw memory which is a collection of bits without a type to workaround this we must use the `<cstddef>`

- In those situations we would work with the `std::byte` type in chapter 7 it goes more in depth 
- Using `<cstddef>` and using the `std::byte`wouldn't work in C like everything else in that library would 
- `std::byte `doesn't support many operations like char and unsigned char or math 
- In C++ `std::`is just a namespace like `int main()` more info on **page 216** about namespaces

### Size_t
Also available in the `<cstddef>` header `size_t` type is to encode the size of objects. 

-  Essentially the size_t objects guarantee that the objects themselves are sufficient enough ro represent the size in bytes of all objects
- just like the unsigned long long on a 64 bit [[Chapter 2 Types]] 

Note: `size_t` is a C type in the c Library however in C++ we will see it like `std::size_t `like most things on the standard C++ library

#### Sizeof 
- The unary operator takes a type operator and then returns the size of that shape in bytes 
- sizeof operators always return a `size_t` for example `sizeof(float)` will return number of storage in float units.
#### Format specifiers 
- The usual format specifiers for the size_t are the %zd for a decimal and %zx for a hexadecimal 
- Here is how we could do such a thing 

```C++
code snipet on page 41
```

- Here we check our system for integer byte sizes
- here we printed out statements such as sixe of a char a short a int a long and a long long 
- we did so using the appropriate format specifiers however the results do change depending on the OS
### Void
-  A void in C++ is simply just an empty set of rules because of this C++ disallows void objects 
- We use void in special situations such as for return type functions that wont return any values **For example:**

```C++
#include <cstdio>

void taunt(){
	printf("hey, laser lips your mama was a snow blower.");
}
```

- More on the topic of voids in chapter 3 for the other void uses

[[Arrays]]
