 * creating a source file essentially you need to create a text file that has the code within it in order for C++ to be compiled essentially jsut type the into vim or notepad for windows then it just compiles the code
* Example in vim
```C++
#include <cstdio>

int main(){
	printf("Hello,world!");
	return 0;
}
```

- Every C++ program has a [entry point] this is defined by the [main] function
- A [Entry point] is a function that executes when a user runs a program. [Functions] as we know already are blocks of code that can take inputs and then executes the instructions  given to it
- Within [main] you then call the function [printf] which just prints the string and every string ends with a [;] in C++ 
- Then the program in this instance exits by returning with [return] function using the [exit code 0] to determine how well a program ran
- However having the return statement is optional when using main
- The [#include] is a librabry which essentially pulls code from external sources such as the python equivalent [import]

## The C++ type system 
-  the C++ language is an object oreinted language meaning that objects are abstractions with state and behavior think of a real world object and many things that can define that object 
- A [type] is similar to this analogy in C++ each object in C++ has a predefined data type
- C++ has a built in integer called [int] which is similar to the python if not equal to the python one same goes for the variables 
- [int] is the type which defines the variable [the_answer]
- ```
```C++
int the_answer;
```

- which is C++ version of `the_answer = int()` in python 

## Intitializing a variables state

```C++
int the_answer = 42;
```
- The equal sign just declares what the variable is in this state
- now you a variable with the contents of 42 in it jsut like python except its version would look like [the_answer = int(42)] so we know our shit we got this
- to print out the or use the variable we have set we could >>
```C++
int lucky_number = the_answer / 6;
```
- Keep in mind that every string ends with ; and has the same math symbols as python so we good homie
- there is a whole program that does nothing but [if] statements make a comback
```C++
if (boolean-expression) statement
```

- The difference here is that the statement is what runs if the boolean expression is true  
- to have multiple you can 
```C++
if (boolean-expression){
statement1;
statement2;
 --snip--
}
```
- statement 1 and 2 both run if the expression is true 
- else and else if is used the same way just like python however the syntax is expression then variable 



[[perm.vid_1 1]]
[[Functions]]