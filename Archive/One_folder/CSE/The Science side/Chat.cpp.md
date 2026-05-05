- This prorgam essetntially takes the C library of code that the C language is of course used to a old librbary that doesn't match the newer ones but this is just for practice
```C++
#include <cstdio>

int main(){
	int num;
	
	printf("Enter an integer: ");
	scanf("you entered: %d\n",num)
	
	return 0;
}
```

- The librabries can only be used in the #include statement with this state we get access to other statements and functions 
- Statements and Functions such as `printf` or `scanf` 
- The line of code that defines the main function is the `int main(){` line which is the entry point in every code in C++ 
- `int num;` the same way it defines the main function this defines the `num` variable essentially allowing C++ to recongnize the input number that the user inputted 
- we already know what printf does its the same as in python 
- the `scanf("%d",&num);` The scanf function reads the integer from the users input and stores it in the num variable. The %d formats the what the user input
- the `&num` is used to pass the address of the num variable allowing the `scanf` to store the input there
- The  second `prinf` statement just prints the message with the variable and the format string is re used so that just again formats what the user put 
- `return 0;` essentially just ends the main function

```C++
#include <iostream>

int main() {
    std::cout << "Hello, C++ World!" << std::endl;
    return 0;
}

```
- These lines of code are using the newer libraries that were inroduced in the standard library for C++ 11
- std:cout is a input stream
- Essentially what I have figured out is that every library is similar to the python program in which is uses the similar structure but the difference in that is the functions and statements in each library
- we could just see it as a python program and translate it in our head
- essentially a program that i already written in python but turn into C++ 
- essentially it uses if elif and else statements in the C++ language a while loop that allows the user to talk to the program
```C++
#include <iostream>
#include <string>

int main() {
    std::string user_input;

    std::cout << "Hello! Let's have a conversation. Type 'quit' to exit.\n";

    while (true) {
        std::cout << "> ";
        std::getline(std::cin, user_input);

        if (user_input == "quit") {
            std::cout << "Goodbye! Conversation ended." << std::endl;
            break;
        } else if (user_input == "hello") {
            std::cout << "Hello there! How can I assist you today?" << std::endl;
        } else if (user_input == "how are you") {
            std::cout << "I'm just a computer program, so I don't have feelings, but I'm here to help!" << std::endl;
        } else {
            std::cout << "I'm not sure how to respond to that. Please ask another question or type 'quit' to exit." << std::endl;
        }
    }

    return 0;
}


```

- The std cout is the same as the print in python here is the python version of the C++ program
```Python
print("Hello! lets have a conversation")

  

while True:

userinput = input("> ")

if userinput == "hello":

print("Hi there what can I fo for you today")

print("please enter the correct options since my enlgish is limited")

elif userinput == "how are you":

print("I cant feel anything Im a dead computer program")

elif userinput =="what else can you do":

print("oh well you know not much just a simple computer progam")

elif userinput =='quit':

print("Good Bye Conversation has ended Have a great day!!")

break

else:

print("What the fuck did you say I already told you my english is limited!"

```

- The differences between these codes essentially is the std cout and the std cout endl what it does is that it ends the string and moves on to the next 
- `std::string user_input;` Declares the varaible to stores the users input 
- std:cout <<"Hello! Lets Have a conversation. " is esssntially just the C++ version of print 
- `std::cout << "> ";` this line just tells the program that the user should just essentially  do something like as an input or literalyy anything right after the std::cout
- we know what the while true does and the if and else if and else does 
- the break breaks we know this we could try making our own completely 
- ``std::getline(std::cin, user_input);`` this line however reads a line of text from the standard input and variable which is whats stored in the user_input variable 