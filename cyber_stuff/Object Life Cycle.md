When we create a variable in C++ it is simply an object with a name which an object is something that holds data in it . 


## Allocation, Deallocation and lifetime

- When you create a variable you allocating storage to that obeject (variable) which  is called **allocation** 
- when you done with the object it removes the data from that object which is called **`deallocation`** 
- `Lifetime` is the process that holds the storage of the object until `deallocation` is commenced 

## Life cycle 

- begins when it is allocated 
- constructor is called 
- life time begins 
- use object 
- storage ends 
- life time ends 
- constructor is called 
- storage `dealllocated` 

## Memory management 
The memory management in languages used for application dev use a `garbage collector` they throw away the allocated object so that the programmer doesn't need to worry about them anymore 

- However in C++ the compiler must have `specific knowledge` on the *life cycle of the object* otherwise the GB collector will be used ineffectively 

## auto strorage duration 
Function parameters are examples of objects that get a life cycle automatically meaning we don't have to give it a life cycle. 

```C++
void functionEx(functionParameter, ){
//function parameter storage is allocated on its own as well as life cycle 
	string exampleUsage;
	std::cout << "this does nothing!" << endl;
}
```

### Static 
Static storage is made when you create a variable the global `static objects` have a life cycle from beginning of program till the end 

```C++
#include <iostream>

void exampleFunction() {
    // Declare a static variable inside the function
    static int staticVariable = 0;

    // Increment the static variable on each function call
    staticVariable++;

    // Print the value of the static variable
    std::cout << "Static variable value: " << staticVariable << std::endl;
}

int main() {
    // Call the function multiple times
    exampleFunction();
    exampleFunction();
    exampleFunction();

    return 0;
}
```

- you must declare it with a `static` 
- you can also use `extern` which is similar to static except can be used outside of the program onto others kinda confusing but we need learn on the job with that one 
- However `Local static` is just the same as static in stead it can only be used in the same function  the example above is local `global` can be used out side a function 

```C++
#include <iostream>

// Declare a global static variable (limited to this translation unit)
static int globalStaticVariable = 0;

int main() {
    // Increment the global static variable
    globalStaticVariable++;

    // Print the value of the global static variable
    std::cout << "Value of globalStaticVariable in main.cpp: " << globalStaticVariable << std::endl;

    // Call a function from another file
    externalFunction();

    return 0;
}
}
```

## Static member 
This is just like the static function or static variable just on the class scale must be used in `::` namespace for ex

```C++
#include <iostream>

class MyClass {
public:
    // Static member variable
    static int staticVariable;

    // Member function to access the static variable
    void printStaticVariable() {
        std::cout << "Static variable value: " << staticVariable << std::endl;
    }
};

// Initialize the static variable outside the class definition
int MyClass::staticVariable = 0;

int main() {
    // Create two instances of MyClass
    MyClass obj1, obj2;

    // Access and modify the static variable through any instance
    obj1.staticVariable = 42;

    // Both instances share the same static variable
    obj1.printStaticVariable();  // Output: Static variable value: 42
    obj2.printStaticVariable();  // Output: Static variable value: 42

    return 0;
}

```

