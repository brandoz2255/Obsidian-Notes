**Data Structures**: These are programs that hold functions similar to what OOP is in which a program that makes up an object however it is a program that holds data for a much larger program such as multiple functions which OOP is a Data structure type. 

**Algorithms**: When a computer or program is being program to comlete a task this is different then making an object in which we are creating a object for  a bigger program this we have our computer do something complicated for us. like a math problem for example

# Introduction

**Computational Process**: The computational process could be described like how a wizard conjures spritis and spells. The computational process is something that we cannot see happen or has a physical form of it self but it is very real. 

- This process are abstract beings that inhabit the computer they manipulate things called **data** which are directed by a set of rules **the program**

- As mentioned before the computational process is like a spirit that a wizard conjures in of a sense it can control a lot and do a lot however we cannot see it but it is as real as you and me

## The elements of programming 
A programming  language is more than just a way to give a computer a list of instructions so it can complete a task. It is also a means to organize our ideas about processes. 

- There are three ways a powerfull programing laguage does this 

- **Primitive expressions:** represents the simple entites of the langauge 
	- This is using the basic primitive data types in a language we know this arelady refer to C++ in data types 
- **Means of combination**: which elements are built from simpler ones in other creating larger data structures with simpler data types. 
	- in other words combining data types for a larger program think of OOP is a good example of means of combination
- **Means of abstraction**: in which compound elements can be named or manipulated as units 
	-  In other words this is naming our functions and variables and classes for easy readability not only for a computer but for a human as well 

In Programming the two types of data we will be encountering is **Functions** and Data **the** *function* is how we *manipulate* the *data* and the **data** is the *stuff* we want to manipulate. 


## Expressions 

An expression is a statement that expresses in the programming language what the computer is sintructed to do 

- Operators combine one or more expressions togethers this is called **combinations** or **Operator combinations**  an operator tells the language (Javascript) how the expression is combined
- When dealing with **combinations** the interpreter or the compiler depending on the langauge will always be able to read it if typed out correctly however if a human was reading it it could be problematic if not done correctly 
- With math we can *separate expressions* with *parenthesis* or by moving it to another line the interpreter will always see it as is but ==humans can get== confused without the parenthesis or structure. 
- Math operators are typically left associated but mathimatical expression are read form left to right 
- This is usually called a **read evaluate loop**

## Naming and the Environment
- the naming of the enivrement is giving a variable a data types and naming said variable doing this is called a `const` which is short for *constant*

```Javascript
const number = 2;

// Now, you can use the 'number' variable, and its value cannot be changed.
console.log(number); // Output: 2

```

- As we can see in Javascript programming is the same structure of C++ 

- We can use the `const` how we want --> 

Example of **mathematical operations** 
```JavaScript
const number = 2;

// Performing mathematical operations
const doubledNumber = number * 2;
const squaredNumber = number ** 2;

console.log(doubledNumber); // Output: 4
console.log(squaredNumber); // Output: 4

```

Ex of Conditional Statments 
```Javascript 
const number = 2;

// Using in conditional statements
if (number > 0) {
    console.log("The number is positive.");
} else {
    console.log("The number is non-positive.");
}

```

Function Parameter

```JavaScript
const number = 2;

// Using as a parameter in a function
function multiplyByTwo(x) {
    return x * 2;
}

const result = multiplyByTwo(number);
console.log(result); // Output: 4

```

String and variable 

```JavaScript
const number = 2;

// Using in string concatenation
const message = "The number is: " + number;
console.log(message); // Output: The number is: 2

```

