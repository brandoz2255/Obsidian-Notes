**Initialization** or AKA **object initialization** is a method to bring an object to life using C++ 

## Initialization a type to a zero
There are 4 methods to initializare a fundemtal type to a zero In C++ here are the four methods 

``` C++
int a = 0; // initiializes to a zero (using literal)
int b{}; // initiializes to a zero (using braces)
int c = {}; // initiializes to a zero (declaring with not extra notation)
int d; // initiializes to a zero (maybe)
```

- Using braces is called **braced initialization** unrionically 

#### Initialize a type to a value

``` C++
int a = 42; // initiializes to a 42 (using literal)
int b{42}; // initiializes to a 42 (using braces)
int c = {42}; // initiializes to a 42 (declaring with not extra notation)
int d(42); // initiializes to a 42 (maybe)
```

- We can do the same with any  value in C++ using this syntax 
- Initializing a POD into a zero ex:

``` C++
// Example of zero initialization for a POD type (int)
int myInt = int();  // myInt is zero-initialized

```

And 

```C++
// Example of direct initialization for a POD type (int)
int myInt = 42;  // myInt is initialized to 42

```

And 

```C++
// Example of initialization in a constructor for a POD type (class)
class MyClass {
public:
    int value;

    // Constructor with member initializer list
    MyClass() : value(42) {}

    // Constructor with initialization in the body
    MyClass(int initialValue) {
        value = initialValue;
    }
};

MyClass obj1;          // obj1.value is 42
MyClass obj2(100);      // obj2.value is 100

```

- We can iniitiilize an array with a set of enclosed brackets {} for ex:

``` C++
// Example of array initialization with values
int numbers[] = {1, 2, 3, 4, 5};

```

For Zero is:

```C++
// Example of array zero initialization
int zeros[5] = {};  // All elements are initialized to 0

```

