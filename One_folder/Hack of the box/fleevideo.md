# Data types 
We are going to go over the differnt data types in C++ 
- Creatign a bunch of different variables is one of the easiest way to display the different types of variables
- TO store just one character in a variable we would essentially need to use the `char` statement this essentially tells C++ that our variable is jsut one character it also helps to remember that when using t his we only need to us the `''` statement since its one character 
- Always remember in C++ every line ends in `;`
-  the `string` statement is essentially the same just with dealing with a string
- we have different variables for different types of numbers like in python 
- for  general integers we use the `int` statements to tell C++ that it is a integer type variable 
- we arent restricted to   positive numbers we can use negative numbers for `int` statement 
- For decimal numbers we got to use either the `double` statement or the `float` statement which is similar to what python has it  at with their float statement as well 
- The difference generally speaking is that the a double is used for in situations that require less specific decimals or more complex decimals for more complex code
- We could also use negative and positive numbers with `double` 
-  One  uniq statement for a data type is the boolean it just tells C++ if a statement is true or false `bool` 
- we could print out the variable like usual using `cout` 

*constant*: A contsant in C++ is a string or a data type that doesn't rely on a variable such as printing a string with the `""` straightup or typing the character and number straight up 

```C++
#include <iostream>

using namespace std;

int main()
{

char variable_name = 'A';
string variable = "the string within the variable";
int variable2 = 63;
double variable3 = 2.6;
bool variable4 = true;
bool variable5 = false;

return 0;

}
```



# Working with Strings 
- This will go over the ins and outs of the string data type 
- It is the most common data type in C++
A string is an any type of plain text we already know this has to be in *""* or *''* depending on the complexity of the  string 
- `endl` in C++ is a statement that tells C++ we want to end the line and start a new one if we do twos strings without this  statement C++ will just  combine the two line together 
- The same thing can be done with the `/n` command in C++ just like in python 
Brings back the definiution of a **function**: which essentially is just blocks of code that contains blocks of code 
- Just like in python we would use a function with the `.` followed by the name of the function 
- `.lenght()` used with the string within a variable prints out the number of  characters in the string 
- Since we know how manny characters this string is we can also us the name of the variable followed by `[]` statement and command what character we want to print out specifically
- for example `[0]` would print out the first letter since computers start from 0 
- we could also modify the string using this same logic 
- we could use the `.find()`statement to find a specific phrase form a string 
- we could also speficy where in the strings positon does this phrase begin in with this `.find("phrase , 0")` 
- `.ssubstr()` just basically splits the string by how many we would want to grab 
- we caould also store a string of code in another variable 

# Working  with numbers 
We could do mathematical equations in C++ of course im pretty sure we could do this in alll programming languages 

- There are two different types of numbers as mentioned before the integer and decimal but t here are three ways to use this  
- similar in python however instead of saying hey print equation we would say cout equation 
```C++
cout << 5*7;

```
- Of course we can use any type of mathmatical equation guessing  useing the same commands as py
- Yea just like python * for mult and + for addition / for division and - for subtration 
- However using the modulus is different we would use the % instead of // as we would in python 
 - C++ follows the pemdas rule in math just basic rules in math 
 - 
 - we can also increase the value of an integer stored in a variable for example 
```C++
#include <iostream>
using namespace std;
int main()
{
	int numbervarible = 5;
	numbervariable++;
	return 0;
}
```

- we could do the same thing with any math equations like decrease it or expand exonentially 
- we could also add a spefic amount such as `variable += 80` which would just add 80 
- Doing math in C++ with just two integers the answer will be always an integer at least or both of the operations have to be a decimal for it display one 
- we could functions to do math 
- We need to import it for this example we would import the cmath module 
- With this we can do $$3^3$$
- using the `pow` statement in C++ differnly than python 
- it would be done like `pow(3,3)` 
- the `sqrt()` function basically just t takes the square root of a number 
- `round` just rounds the decimal up followss normal rounding numbers 
- `ceil` roundss it up to the nearest whole number 
- `floor` rounds down 
- `fmax` takes two numbers and returns the bigger number withing the parenthesis 

- we left off at *33* minute 
- for literature read chpt 2 in book 