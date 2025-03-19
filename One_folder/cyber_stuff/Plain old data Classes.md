# POD 
A POD is the acronym for the Plain old data classes which essentailly is the same thing in python when it comes to classes it is a block of code that holds functions except in C++ the functions are called members of the classes

```C 
struct book {
	// This contains the char array called
	char name[256];
	// int year variable 
	int year;
	//int pages variable
	int pages;
	//a bool handcover if you dont remember bool review data types
	bool handcover;
};
```

``` C 
#include <stdio.h>
#include <string.h> // For C string functions

// Define a Plain Old Data (POD) structure - Person
struct Person {
    // Member variables
    char name[50];
    int age;
    float height;
};

int main() {
    // Create instances of the Person structure
    struct Person person1 = {"John Doe", 25, 1.75};
    struct Person person2;

    // Copy person1 to person2
    person2 = person1;

    // Display information
    printf("Person 1: %s, %d years old, %.2f meters tall\n", person1.name, person1.age, person1.height);
    printf("Person 2: %s, %d years old, %.2f meters tall\n", person2.name, person2.age, person2.height);

    return 0;
}

```

- Since Part one teaches C in the C programming language we must identify a Class as a struct instead of naming it a class like we would in C++ 
naming

# Unions 

These are dangerous class types in C++ and C essentially it is the cousin of the POD class in which instead it just shares the same memory space allowing for less memory usage 

- It works by using the same memory location for different members 
- This is how it saves storage in C and C++ 
- The danger here is if so many members share the same stroge it can have disastrous consequences 

Example if usage
```C 
#include <stdio.h>

union MyUnion {
    int intValue;
    float floatValue;
    char charValue;
};

int main() {
    union MyUnion myUnion;

    myUnion.intValue = 42;
    printf("Integer value: %d\n", myUnion.intValue);

    myUnion.floatValue = 3.14f;
    printf("Float value: %f\n", myUnion.floatValue);

    myUnion.charValue = 'A';
    printf("Char value: %c\n", myUnion.charValue);

    // The values of other members may be corrupted, only one member should be accessed at a time
    printf("After setting charValue, intValue is now: %d\n", myUnion.intValue);

    return 0;
}

```

- Similar to python we use the `.` notation to call upon a class 

Think of unions as a storage compartment containing all kinds of stuff such as books or toys or money however we can only get on thing from this compartment at a given time since getting one of each damages the other. 


## Methods 
We can already infer what a Method since A method in python is the Functions within a class. And we already know that the functions within a class are called members.  In C/C++ they are member functions. haha get it lol

- In C++ methods are function that are stored within a class that interact with the members of a class 
- For example the members are just variables containing data and the methods are the functions using those members to create a situation
- Since in C the class concept doesnt exist only as in `struct` the Methods operate very similar 

``` C 
#include <stdio.h>

struct Person {
    char name[50]; // Member variable
    int age;       // Member variable
    float height;  // Member variable
};

// In C the Methods are stored outside the struct operation
void introduce(struct Person *p) {
    printf("Hi, I'm %s, and I'm %d years old.\n", p->name, p->age);
}

void celebrateBirthday(struct Person *p) {
    p->age++;
    printf("Happy Birthday! Now I'm %d years old.\n", p->age);
}

int main() {
    struct Person person1 = {"John Doe", 25, 1.75};
    
    introduce(&person1);
    celebrateBirthday(&person1);

    return 0;
    // keep in mind the voids are just functions in this case since C doesnt have classes 
}

```

- In C specifically the Methods are stored out side of the struct operation this simulates the explanation used before here an example of methods in C++ 
- One thing to keep in mind then is that C doesn't have classes and the closest thing to it is a the struct and can only store members 

``` C++
class Person {
public:
    std::string name; // Member variable
    int age;          // Member variable
    float height;     // Member variable

    void introduce() {
        std::cout << "Hi, I'm " << name << ", and I'm " << age << " years old.\n";
    }

    void celebrateBirthday() {
        age++;
        std::cout << "Happy Birthday! Now I'm " << age << " years old.\n";
    }
};
// remeber we can use using namespace std for simple progams 
```

[[Access controls]]