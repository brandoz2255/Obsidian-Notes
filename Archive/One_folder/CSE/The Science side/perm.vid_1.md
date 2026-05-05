# C++
in order to run a program in C++ the first step must always be what we know which is the process of making the program which involves building the code from the ground up then having it compiled in order for it to run 
```C++
#include <iostream>

using namespace std;

int main()
{
	cout<<"Hello world" << endl;
	return 0;
}
```
- This example of a C++ code is a very basic lines of code that just print out the  statement `Hello world!` what I am going to do is break down essentially what this code it telling the computer to do 
- `#include <iostream>` this is telling the computer that the langauge is C++ and is using the library of statements contained in the iostream 
- `using namespace std;` is just telling C++ to use the namespace provided to tell the computer what to do
- `int main()` This tells C++ that the function has blocks of code which are instructions that tells the computer what to do
- `cout` prints out the statement of hello world `endl` ends that line of code
- `return 0` ends the whole code block
Essentially in C++ every statement in this code tells the computer an exact instruction to follow so that it could do what it was instructed to do

# Drawing a simple shape with cout

The next lesson then has us draw a simple shape in C++ using the `iostream` library simiarly how we printed out the statement `hello world` 
```C++
#include <iostream>

using namespace std;

int main()
{
	cout<<"   / |" << endl;
	cout<<"  /  |" << endl;
	cout<<" /   |" << endl;
	cout<<"/____|    " << endl;
	return 0; 
}
```
- In this challenge we used the same statement to print out the string `hello world` but rather than that simple string we used it to recreate a triangle 
- We just used mutliple `cout` arguments and moved the characters in a specified location to have them shape out this triangle

# Variables 
using variables in C++ is essentially easy in which it requires us to state what type of data we want to store in the variable and then we store the data we want to store within the variable
- There are alot of different types of data however we are only going to focus on two for this example which is` string` and `int`
- a `string` data type tells C++ that the type of data within the variable is  basically just text
- A `int` data type tells C++ that the data type we have within the variable is a integer which stores numbers and only whole numbers
**What makes using variables essentially easier than most statements is that it stores what you want to use in future reference like if you have multiple lines that reference a single string that is what the variable is there for in case you go and change your mind you wont need to manually go in and change the whole thing**
example:
```C++
string characterName = "John";
```
- Here we can see that the data type is specified in string and `John` is strored in the `characterName` variable 
```C++
int charactersAge;
characterAge = 35;
```
This is an example of how the integer data type would be specified and stored within the `characterAge` variable 
```C++
#include <iostream>

using namespace std;
int main()
{
	string characterName = "John";
	int characterAge;
	characterAge = 35;
	cout << "there once was a man named " << characterName << endl;
	cout << "he was "<< characterAge <<" years old" << endl;
	cout << "he liked the name " << characterName << endl;
	cout << "he was did not like being "<< characterAge << endl;
}
```

- Here is how its used overall in the code we use the `<<` arguments to specify where we want the variable to be printed which is at the string input in the end 
- As for the one in between we need to specify where in between we want it at using two `<<` to aim where we want it in our code such as in `<< characterAge <<`
 We can also change the variable anytime we want we would just need to modify what is in the variable such as where it says = `John` and = `35` we could jsut change it to whatever we want and then it just updates the code for us 
 - We can also change the variable halfway in the code to change the story midway through the story to just confuse the audience like this -->
```C++
#include <iostream>

  

using namespace std;

int main()

{

string characterName = "John";

int characterAge;

characterAge = 35;

cout << "there once was a man named " << characterName << endl;

cout << "he was "<< characterAge <<" years old" << endl;

  

characterName = "Mike";

cout << "he liked the name " << characterName << endl;

cout << "he was did not like being "<< characterAge << endl;

  

return 0;

  

}
```

Here we just changed the story halfway to essentially confuse the audience or for whenever we want to change the story we are making theatrically speaking this would be useful

- Also remember we left of off at [32:01](https://www.youtube.com/watch?v=vLnPwxZdW4Y)
