# Types
A type in C++ is  **how an Object will be used and compiled by the C++ language.** Every Object in the C++ language has a **type** and for **each type has different set of rules that need to be specified for the compiler to read and perform**.  This chapter goes over the Fundamental types and the user specified types as well control flow structures 

# Fundemental types
A fundamental type in C++ are the basic types  that comes with the C++ language. Some programmers refer to these types as the primitive types or built-in types 

- These types are such the *floating point , integer , character, Boolean , byte , size_t, and void *
- These types will work on any platform however their features depend on the programmers implementations of these types 
- Fundamental types provide a balance in which they have a direct relationship with the compiler hardware and cross platform code allow it to work on many platforms

## Integer types 
As we know by now an integer type is just how C++ compiles and reads the given number that the programmer programs. However one key thing to remember is that a integer is of course a whole number in order to use a decimal we must specify it as a float but that's for later. 

- An `int` statement defines the data type to be an integer in C++ so that the compiler can read as a int
- There are four sizes in integer types in C++ these are **short int, int, long int, long long int**
- Either of these variations can be assigned or unsigned the difference between both statements is 
- a signed variable can **be positive, negative or zero**
- An un signed variable **must be a non negative integer**
- By default they are signed as `int` so in this case we can **short int, int, long int, long long int** without stating the **int**

|               | Signed | Windows | Linux/Mac | Windows 64-bit | Linux 64-bit | Printf Format |
|---------------|--------|---------|-----------|----------------|--------------|---------------|
| **Type**      |        | 32-bit  | 32-bit    | 64-bit         | 64-bit       | Format Specifier   |
| short         | Yes    | 2       | 2         | 2              | 2            | %hd             |
| unsigned short| No     | 2       | 2         | 2              | 2            | %hu             |
| int           | Yes    | 4       | 4         | 4              | 4            | %d              |
| unsigned int  | No     | 4       | 4         | 4              | 4            | %u              |
| long          | Yes    | 4       | 4         | 4              | 8            | %ld             |
| unsigned long | No     | 4       | 4         | 4              | 8            | %lu             |
| long long     | Yes    | 8       | 8         | 8              | 8            | %lld            |
| unsigned long long| No  | 8       | 8         | 8              | 8            | %llu            |


Here we can see that the int types varies across platforms the 64 bit windows is different when compared too Linux and mac. If we format it wrong for the following platforms the compiler may or may not warn you about the format but this is a good thing to keep note of when **debugging** in case. 
	- If we want our integer sizes guaranteed we can use the` <cstdint> `library in this if we need a **integer with an exact number of bits we would** `int#_t` where the number signed is the actual number you would use 

A literal in C++ is a hardcoded value withing a program such as:
- **binary** - `0b`
- **octal** - `0`
- **decimal** -*this is on by default*
- **hexadecimal** - `0x`

These are four different ways of writing the same set of whole numbers  in C++

```C++
#include <cstdio>

int main() {

	unsigned short a = 0b10101010;

	printf("%hu\n", a);

	int b = 0123;

	printf("%d\n", b);

	unsigned long long d = 0xFFFFFFFFFFFFFFFF;
	
	printf("%llu\n", d);

}
```

This code essentially assigned several integer variables and prints them with the appropriate format specifier. This utilizes many of the different non-decimal integer forms representation (binary,octal,hexadecimal)

**integer literals can contain any number of single quotes such as 1000000 is the same as 1'000'000 however C++ will ignore this just makes it easier to read on our end.**


Sometimes in some scenarios it is easier to print unsigned integers in the hexadecimal format or rarely its octal format this we need to code in the correct specifiers such as %x %o 

```C++
#include <cstdio>

int main() {

	unsigned int a = 3669732608;

	printf("Yabba %x!\n", a);

	unsigned int b = 69;

	printf("there are %u ,%o leaves here.\n",b ,b);

}
```


The hexadecimal representation of  the integer *3669732608* is of course dabad00 which would printed in the first  line of this out put because of the format specifier `printf("Yabba %x!\n", a);` . 

- Then with the second print statement we have the variable b being formatted in the hexadecimal form and the octal form giving the results of there are 69, 105 leaves here. 

By default when using Integers in C++ we have the options of int long, long long, and integer literal which  the smallest of the three types. If we want more control with our integers we can apply suffixes however these are case sensitive. 

- unsigned = u or U
- long = l or L
- long long = ll or LL

These are the suffixes that once can use when dealing with integer literal. 

[[Types part two]]










