User defined types can be put into **three different categories** but first these types are of course` self explanatory types that cane be defined by the user. `

- ***Enumeration***: This is the `simplest` user defined type in which these are types **restricted to set of possible values** which are *excellent* for ***categorical data***

- ***Classes***: These are the more featured types in which they give `you felxibilty on pair data and functions.` Also contain data called **plain-old-data classes. 

- ***Unions***: A boutique use define type easy to get lost and dangerous easy to misuse. All members share the memory location 

## Enumeration types
In order to delcare a user defined type  we must use key words such as `enum class` **followed by the type of data and the list of values**. 

- These values are basically integers however they allow you to write anythign using programmer defined types. 
- Literally anything for example --> 

```C++
enum class Race {
	Dinan, 
	Teklyn,
	Ivyn,
	Moiran,
	Camite, 
	Julian,
	Aidan,

};
```

- This is a class containg all the races form Neal Stephenson seveneves never read the book my self 
- We can call upon this class for a specific race using this syntax 

```C++
Race longoboard_race = Race::Aidan
```

- Essentially classes in the user defined types section is similar to the classes in python if not the same [[Classes.book]]

There are two types of classes scoped and un-scoped simply  remove class from the code and its un-scoped the difference is one is dangerous which unscoped so don't


### Switch statements 
A switch statement is essentially how control over one statement or several switch controls of a value of a condition 

- in other words its like a menu at a restaurant in which the` statements are options` on a **menu** and based on the different menu options it has `a list of seperate instruction`s for each menu option having `different ways to handle different situations` 

`Example`:

```C++
#include <cstdio>

int main() {
    // Declare variables to store operation and numbers
    char operation;
    double num1, num2;

    // Prompt the user to enter an operation (+, -, *, /)
    printf("Enter an operation (+, -, *, /): ");
    scanf("%c", &operation);

    // Prompt the user to enter two numbers
    printf("Enter two numbers: ");
    scanf("%lf %lf", &num1, &num2);

    // Use a switch statement to perform calculations based on the entered operation
    switch (operation) {
        case '+':
            // Addition
            printf("%.2f + %.2f = %.2f\n", num1, num2, num1 + num2);
            break;
        case '-':
            // Subtraction
            printf("%.2f - %.2f = %.2f\n", num1, num2, num1 - num2);
            break;
        case '*':
            // Multiplication
            printf("%.2f * %.2f = %.2f\n", num1, num2, num1 * num2);
            break;
        case '/':
            // Division with a check for division by zero
            if (num2 != 0) {
                printf("%.2f / %.2f = %.2f\n", num1, num2, num1 / num2);
            } else {
                printf("Error: Division by zero.\n");
            }
            break;
        default:
            // Handle an invalid operation
            printf("Invalid operation.\n");
    }

    return 0;
}

```

## Using a Class with switch statements 

- we are going to use our example earlier from the race class and use it to print out a conversation 

```C++
#include <cstdio>

// Enumeration to represent different races
enum class Race {
    Dinan,
    Teklyn,
    Ivyn,
    Moiran,
    Camite,
    Julian,
    Aidan,
};

int main() {
    // Default race is Dinan
    Race race = Race::Dinan;

    // Switch statement to perform actions based on the selected race
    switch (race) {
        case Race::Dinan:
            // If the race is Dinan
            printf("You work hard sir!");
            break;

        case Race::Teklyn:
            // If the race is Teklyn
            printf("You are very strong");
            break;

        case Race::Ivyn:
            // If the race is Ivyn
            printf("You are a great leader!");
            break;

        case Race::Moiran:
            // If the race is Moiran
            printf("My, how versatile you are!");
            break;

        case Race::Camite:
            // If the race is Camite
            printf("You're incredibly helpful!");
            break;

        case Race::Julian:
            // If the race is Julian
            printf("Anything you want!");
            break;

        case Race::Aidan:
            // If the race is Aidan
            printf("Wow, what a sigma!");
            break;

        default:
            // Handle the case of an unknown race
            printf("Error: Unknown race!");
    }

    return 0;
}


```

[[Plain old data Classes]]



[[C++ Classes]]
