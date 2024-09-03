# Pointers
Pointers in C++ are a way that we can give an object a memory address in which that C++ remembers where we stored that variable. The same goes for C it is essentialyy the same concept it points an address to the variable in C/C++. 

- This allows for dynamic memory allocation in these languages 
- And the manipulation of data directly in the memory 

To use a pointer we must assign a variable with a asterisk `*` 

```C
int x = 10;  // A regular variable
int *ptr;    // Declaration of a pointer
ptr = &x;    // Initialization: ptr now points to the address of x

printf("Value of x: %p\n", *ptr);  // Dereferencing ptr to get the value at its address

```

-  The format specifier for the pointers is **%p**

**Address Space layout Randomization**: *This is a security feature that is in C++ in which the memory address is random each time the program runs this was to counter attack the exploit of return oriented program*
## Dereferencing pointers 
This is how we can modify a already pointed to variable in C/C++ in which we bring back the pointer used to assign a variable a memory. 
- We use the de-referencing pointer to modify it we use the `*` to do this for example:

```C
#include <stdio.h>

int main() {
    int x = 10;
    int *ptr = &x; // ptr now holds the address of x

    printf("Value of x: %d\n", x);
    printf("Value pointed to by ptr: %d\n", *ptr); // Dereferencing ptr to access the value

    *ptr = 20; // Modifying the value through the pointer only add it via pointer 
    printf("Updated value of x: %d\n", x);

    return 0;
}
```

C++ Version

```C++
#include <iostream>

int main() {
    int x = 10;
    int *ptr = &x; // ptr now holds the address of x

    std::cout << "Value of x: " << x << std::endl;
    std::cout << "Value pointed to by ptr: " << *ptr << std::endl; // Dereferencing ptr to access the value

    *ptr = 20; // Modifying the value through the pointer
    std::cout << "Updated value of x: " << x << std::endl;

    return 0;
}

```

- There is no need for format specifier in C++Remember this
## Member of a pointer operartor 
This is another method used to modify an already pointer variable instead of using a asterisk `*` we would use the `->` to do this . 

- Allthough this method is mostly and only used when we want to change the memory of a variable from a `struct` or a class
- In C however it would only be used to access it through a struct rather than a class

``` C++
#include <iostream>

class Person {
private:
    std::string name;
    int age;

public:
	// adds the parameter to the class 
    Person(const std::string& n, int a) : name(n), age(a) {}

    void displayInfo() {
        std::cout << "Name: " << name << ", Age: " << age << std::endl;
    }
};

int main() {
    Person person1("Alice", 25);
    
    // Pointer to a Person object
    Person *ptrPerson = &person1;

    // Accessing members using the -> operator
    ptrPerson->displayInfo();

    return 0;
}
```

Same code in C

``` C
#include <stdio.h>

struct Person {
    char name[50];
    int age;
};

void displayInfo(struct Person *person) {
    printf("Name: %s, Age: %d\n", person->name, person->age);
}

int main() {
    struct Person person1 = {"Alice", 25};
    
    // Pointer to a Person structure
    struct Person *ptrPerson = &person1;

    // Accessing members using the -> operator
    displayInfo(ptrPerson);

    return 0;
}

```


### pointers and arrays 
The book essentially explains the differences and similarities of arrays and pointers in which an array has a fixed size and is given memory during compile time and pointers can be given memory sizes and can be altered. 

- Arrays are also initialized with a bracket [] 
- Where pointers use asterisks `*` 

##### Handling decay
- When a pointer is used on a array it breaks it down and simplifies it to the first nth value of the array 
- The pointer affects how long the array is going to be in C/C++ and using a for loop to iterate through the whole array and print out the information

``` C++
#include <iostream>

// Function that takes an array and its size
void printArray(int arr[], int size) {
    for (int i = 0; i < size; ++i) {
        std::cout << arr[i] << " ";
    }
    std::cout << std::endl;
}

int main() {
    int myArray[] = {1, 2, 3, 4, 5};
    int arraySize = sizeof(myArray) / sizeof(myArray[0]);

    // Using the array directly
    std::cout << "Array elements using array name: ";
    printArray(myArray, arraySize);

    // Using a pointer to the array
    int *ptrToArray = myArray; // array-to-pointer decay
    std::cout << "Array elements using pointer: ";
    for (int i = 0; i < arraySize; ++i) {
        std::cout << ptrToArray[i] << " ";
    }
    std::cout << std::endl;

    return 0;
}
```
##### Arithmetic
-  An arithmetic of the pointer and the arrays is how we can get a nth value of the array we want with a pointer instead of using all the information when using the for loop 
- We would use this basic syntax using brackets [] and the `&` operator 

```C++
college* third_college_ptr = &oxford[2];
```


### Dangers 
Remember we cant convert a pointer to an array the compiler simply cant do this however this would stop our program for doing this so it could be dangerous


#### Analogy 
Think of pointers like a GPS it provides coordinates of where a house(variable) is given the town(memory in the computer) a way to keep track of the address of a house(variable) which the houses constants people(data) 

[[Buffer Overflows]]