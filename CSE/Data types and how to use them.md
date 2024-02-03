# Data types
Within The C++ programming language there are many ways to use different types of data that can be read by C++ and many different types of way that these information can be stored in C++ 
	- *It  can be stored as in a variable when storing it into a variable we must first tell C++ what type data type it is first in order for this data type to be used  and stored*
	- *There are also different uses when it comes to these data types since each data type is different each has their own library of functions to use*

### Storing data in variables 
To store many different types of data within a variable must be deined first in order C++ to see it and complle it. 
- For example If we want to jsut store a single character we must use the `char` statement followed by the name of variable in order to tell C++ that it is a character variable 
- Since it would also be just a single character we would only need to use the single quotations 
```C++
char variable_name = 'A';
```

For example ^

- For storing single string in C++ we would use the `string` statement which to tell C++ its a string
- A string is just a string of plain text 
```C++
string variable = "the string within the variable";
```

When dealing with numbers in C++ we must tell C++ that the data type we are using is an Integer which is recognized by the `int` statement

```C++
int variable2 = 63;
```

However with numbers in C++ there are two types of numbers we must identify first for a regular integer we use int but for a decimal we must specify that it is one 
	- There are two types of methods for this the first method is by using the `double` statement 
	- The other method is by referring to as an `float` but this one is mostly used for more complex decimals 
```C++ 
int variable2 = 63;
double variable3 = 2.6;
```

One Data  type that is unique to C++ is the boolean data type which in the theory of Computer is defined as the result of two possible outcomes. 

However how its used in C++ is just the idea that the results equals either false or true 

```C++ 
bool variable4 = true;
bool variable5 = false;
```

The different types of Data types that can be used in C++ for storing information as a variable are the boolean expressions ,String expressions ,Number expression which  are refereed to as integers, and the character expression which just store one character.

- This is how generally speaking it is going to look like when it is being used in the function -->

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

Every data type stored in a variable in the C++ coding space 

**constant**: A constant in C++ is a string or a data type that doesn't rely on a variable such as printing a string with the `""` straight up or typing the character and number straight up 


# Strings in depth

Working with the string data type of course the string data type is simply just plain text that can be printed out for the user to see. However it can also be used to store a line of code. 

- This is the most common data type in C++ 
- The `endl`  statement in C++ tells C++ that the line of code ends there so that it doesn't combine the two lines of code however the` \n `command will do the same thing 

We can use functions that comes with the `iostream` library for most of the string  operations however refer to this [[Functions]] for an in depth on whats a function. Essentially is just a statement that contains blocks of code 

- To use a function in C++ we must give it a `.` in front of it in order for C++ to see and compile the task
- For example the `.lenght()` function basically just used to print out the number of characters in a string variable
```C++
string variable_name = "yo what up biatch!";

cout << variablle_name.length()<< endl; 

```

- This would essentially print out the number of characters the string has or has used 

Using that information we can use another function with ease this function is the `.find()` function and we can do a cool trick

```C++
variable_name[0]
```

With what is specified in the `[]` like zero for example we can have C++ print us what the character located at 0 position is which in this case is 'y' 

- Know about using the find function we have this screenshot since we were watc hing a videoo but these snipbnits are better for time 
![[Screenshot from 2023-11-16 20-49-08.png]]

- Using the FInd  function we can speficiall look for phrases withing the string variable such as in this example *Academy* 
- We can type in the phrase in the x side of the parenthesis and the starting point in the y side 
![[Screenshot from 2023-11-16 20-49-57.png]]
- Similarly we can use the `substr` function to take a chunk from x to y from the given string variable 
- In this case position 8 to 3 

# Numbers
Working with numbers in C++ is essential since it allows us the programmer to do mathematical equations in a program or just store information in general as a number. In C++ and most programming languages numbers are refereed to as integers and in C++ it has two different types of integer the regular integer and the decimal 

- When working with integers generally speaking of course the `int` statement which tells C++ that the data is a basic integer 
- For working with decimals we must tell python that it is a decimal for non complex decimals we use the `double` statement for complex we use `float` 

### Math
When dealing with mathematical equations generally we just use the `cout` statement to get the calculations done for example 

```C++
cout << 5*7;

```

We can do equations such as multiplication, addition, subtraction, division for more complex math we must functions for that 
	- C++ also follows the PEMDAS rule in math\

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

-  We could also just simply increase the integer stored in a variable by using this command 
- We could also do other math equations like this as well 

Now to do the other mathematical equations mentioned earlier we must load up another module by importing it this would the `cmath` module

![[Screenshot from 2023-11-16 21-12-35.png]]

- The `pow` function is just basically taking 3 to the third power so when we run that it just does the math 
- Similarly if we replace it with `sqrt` function it would just take the square root of the integer