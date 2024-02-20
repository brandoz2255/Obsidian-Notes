- define a class how to in C++

# How to Class
- **`Classes`**: since we already know what a class is we will start with the basic information a block code that holds functions used to create objects in programming 
	- Each function within the class is called a member 
	- we call a function by `nameOfClass.nameOfMember`

For example : 

```C++ 
#include <iostream>

// Define the class
class MyClass {
public:
    // Member variables
    int myNumber;
    float myFloat;

    // Member functions
    void doSomething() {
        // Do something cool here
        std::cout << "Doing something cool!" << std::endl;
    }
};

int main() {
    // Create an object of MyClass
    MyClass myObject;

    // Access and modify member variables
    myObject.myNumber = 42;
    myObject.myFloat = 3.14;

    // Call member function
    myObject.doSomething();

    return 0;
}
```

**`Note:`** Also classes usually good practice in programming to have the classes to start in a Capital letter when contrast to functions they start in lowercase. 

- constructor what is and how its used and what does this mean in a class and where it is appropriate to use
# How to constructor 

```C++
#include <iostream>

class MyClass {
public:
    // Constructor with no parameters
    MyClass() {
        std::cout << "Constructor called!" << std::endl;
        // Initialize variables or do other setup here
    }

    // Constructor with parameters
    MyClass(int num, float f) {
        std::cout << "Parameterized constructor called!" << std::endl;
        myNumber = num;
        myFloat = f;
    }

    // Member variables
    int myNumber;
    float myFloat;
};

int main() {
    // Using the default constructor
    MyClass obj1; // This will call the constructor with no parameters

    // Using the parameterized constructor
    MyClass obj2(42, 3.14); // This will call the constructor with parameters

    return 0;
}
```

- As we can see here the constructor is the class with parameters 
- It can have no return types we can apply  it a different name in the main function as we see with `obj1` and `obj2` 

```C++
#include <iostream>

class Point {
public:
    // Constructor declaration
    Point(int x, int y);

    // Member function to display the coordinates
    void display();

private:
    int m_x; // x-coordinate
    int m_y; // y-coordinate
};

// Constructor definition outside the class declaration
Point::Point(int x, int y) {
    // Initialize the coordinates
    m_x = x;
    m_y = y;
}

// Member function definition
void Point::display() {
    std::cout << "Point coordinates: (" << m_x << ", " << m_y << ")" << std::endl;
}

int main() {
    // Creating an object of the Point class using the constructor
    Point myPoint(3, 4);

    // Calling the display function to show the coordinates
    myPoint.display();

    return 0;
}

```

This one uses an object resolution `::` is used when the class is outside the modules scope 
- used to define constructors ouside the class declorations itself 

better example usuage: 
```C++
// In your own code file

#include "OtherClass.h" // Include the header file that declares OtherClass

// Define member functions or constructors for OtherClass using ::
OtherClass::OtherClass(int param1, int param2) {
    // Constructor definition for OtherClass
    // Initialize member variables or perform setup
}

void OtherClass::someFunction() {
    // Definition of someFunction for OtherClass
    // Do something useful here
}

// Other functions or code in your file

```

- mutator 
- this -> `what is it?` 

## Mutator 
**`Mutator`** functions are also known as setter method which is a member function of a class that is used to modify the value of a private member variable of said class. 
- for example: 

```C++
#include <iostream>

class Rectangle {
private:
    int length;
    int width;

public:
    // Constructor
    Rectangle(int len, int wid) {
        length = len;
        width = wid;
    }

    // Mutator functions (setters)
    void setLength(int len) {
        length = len;
    }

    void setWidth(int wid) {
        width = wid;
    }

    // Accessor functions (getters)
    int getLength() const {
        return length;
    }

    int getWidth() const {
        return width;
    }

    // Function to calculate area
    int calculateArea() const {
        return length * width;
    }
};

int main() {
    // Create an object of the Rectangle class
    Rectangle rect(5, 3);

    // Display initial dimensions
    std::cout << "Initial dimensions:" << std::endl;
    std::cout << "Length: " << rect.getLength() << std::endl;
    std::cout << "Width: " << rect.getWidth() << std::endl;

    // Use mutator functions to modify dimensions
    rect.setLength(7);
    rect.setWidth(4);

    // Display modified dimensions
    std::cout << "\nModified dimensions:" << std::endl;
    std::cout << "Length: " << rect.getLength() << std::endl;
    std::cout << "Width: " << rect.getWidth() << std::endl;

    return 0;
}
```



$$d \propto v^2$$