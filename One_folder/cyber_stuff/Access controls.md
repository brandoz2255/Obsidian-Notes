An access controls allows the use of the main function or other functions to allow access to members in a class or methods in a class. 

- Basically if a chunk of code is titled with private only whats in the class can use that chunk of code nothing outside can access it
- When its titled with Public the reverse happens in which anyone outside the class can use anything within that chunk of code with the public title
- I just found out in C++ there are three levels to the access controls

	- private: can only be accessed within the same class
	- public: can be accessed from any part of the program/code
	- protected: Only other classes can interact with the code not outside the classes

C++ Example:

``` C++
#include <iostream>

class MyClass {
public:
    // Public members
    int publicVar;

    // Public member function
    void publicMethod() {
        std::cout << "Inside publicMethod()\n";
    }

private:
    // Private members
    int privateVar;

    // Private member function
    void privateMethod() {
        std::cout << "Inside privateMethod()\n";
    }

protected:
    // Protected members
    int protectedVar;

    // Protected member function
    void protectedMethod() {
        std::cout << "Inside protectedMethod()\n";
    }
};

class DerivedClass : public MyClass {
public:
    // Access publicVar and publicMethod from the base class
    void accessPublicMembers() {
        std::cout << "Inside DerivedClass - accessing publicVar: " << publicVar << "\n";
        publicMethod();
    }

    // Access protectedVar and protectedMethod from the base class
    void accessProtectedMembers() {
        std::cout << "Inside DerivedClass - accessing protectedVar: " << protectedVar << "\n";
        protectedMethod();
    }

    // Attempting to access privateVar and privateMethod from the base class will result in a compilation error
    // void accessPrivateMembers() {
    //     std::cout << "Inside DerivedClass - accessing privateVar: " << privateVar << "\n";
    //     privateMethod();
    // }
};

int main() {
    MyClass obj;

    // Access publicVar and publicMethod directly
    obj.publicVar = 42;
    obj.publicMethod();

    // Attempting to access privateVar and privateMethod directly will result in a compilation error
    // obj.privateVar = 10;
    // obj.privateMethod();

    // Attempting to access protectedVar and protectedMethod directly will result in a compilation error
    // obj.protectedVar = 20;
    // obj.protectedMethod();

    DerivedClass derivedObj;

    // Access publicVar and publicMethod from the base class
    derivedObj.accessPublicMembers();

    // Access protectedVar and protectedMethod from the base class
    derivedObj.accessProtectedMembers();

    return 0;
}
// the comments are crazy in this 
```

***Note***: *In C Since there is no classes and only a `struct` this means there is no ability to declare an access control in which we can add members to a struct and it will always be public. *

C example

```C
struct MyStruct {
    int publicVar; // Public data member
};

void publicFunction(struct MyStruct *s) {
    // Access publicVar here
}

```

#### Class keyword
- The class keyword is the default in C++ but in the book it explains when you use this the members and methods are private by default unless specified otherwise and when using struct they are public by default since it comes from C 

## Initializing members

- these are ways to stitch methods together in C++ there are multiple ways to do this here is an example of one 

```C++
class MyClass {
public:
    // Default member initializers
    int intValue = 42;
    double doubleValue = 3.14;
};

```

Note: In C we cant intitialize members or methods since struct only holds information that can be accessed if we want to do this we would need to do it in the main function or create another function that does this 

Ex:
``` C 
#include <stdio.h>

// Define a simple struct
struct Point {
    int x;
    int y;
};

int main() {
    // Declare an instance of the struct
    struct Point myPoint;

    // Initialize the members individually
    myPoint.x = 10;
    myPoint.y = 20;

    // Access and print the values
    printf("Coordinates: (%d, %d)\n", myPoint.x, myPoint.y);

    return 0;
}

```

Creating another function to do it EX:
```C 
#include <stdio.h>

struct Point {
    int x;
    int y;
};

// Function to initialize a Point struct
struct Point initializePoint(int x, int y) {
    struct Point newPoint;
    newPoint.x = x;
    newPoint.y = y;
    return newPoint;
}

int main() {
    // Initialize a Point using the function
    struct Point myPoint = initializePoint(10, 20);

    // Access and print the values
    printf("Coordinates: (%d, %d)\n", myPoint.x, myPoint.y);

    return 0;
}

```

## Constructors 
A constructors is a special version of what a method is these are methods that don't have a return type. 

- A constructor has the same name of the class but to avoid identity issues its called upon differently 

Syntax example:

``` C++
class MyClass {
public:
    // Default constructor
    MyClass() {
        // Initialization code goes here
    }

    // Parameterized constructor
    MyClass(int value) {
        // Initialization code with parameter goes here
    }
};
```

- By default when you don't provide a constructor the compiler will just do it for you and add one but empty with no code 
- We can add parameters 

[[Initialization]]