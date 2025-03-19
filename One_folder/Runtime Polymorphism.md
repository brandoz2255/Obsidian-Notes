- **Polymorphic code** : is code that changes it structure each time or as it running the running method is called `runtime polymorphism` as for the `compile time polymorphism` changes once its compiled. 

```C++ 
#include <iostream>
#include <cstdlib>
#include <ctime>

// Base class
class Shape {
public:
    // Virtual function to calculate area
    virtual double area() const = 0;
};

// Derived class 1
class Circle : public Shape {
private:
    double radius;

public:
    Circle(double r) : radius(r) {}

    // Implementation of area calculation for Circle
    double area() const override {
        return 3.14159 * radius * radius;
    }
};

// Derived class 2
class Rectangle : public Shape {
private:
    double width;
    double height;

public:
    Rectangle(double w, double h) : width(w), height(h) {}

    // Implementation of area calculation for Rectangle
    double area() const override {
        return width * height;
    }
};

int main() {
    // Seed for random number generation
    srand(time(0));

    // Randomly create either a Circle or Rectangle object
    Shape* shape;
    if (rand() % 2 == 0) {
        shape = new Circle(5); // Creating a Circle object
        std::cout << "Creating a Circle." << std::endl;
    } else {
        shape = new Rectangle(4, 6); // Creating a Rectangle object
        std::cout << "Creating a Rectangle." << std::endl;
    }

    // Calculate and display the area
    std::cout << "Area: " << shape->area() << std::endl;

    // Cleanup
    delete shape;

    return 0;
}

```

- **Runtime Polymorphism**:  is when the program decides which function to call at what time typically used in conjunction to inheritance with classes and `OOP`
 - **Compile-time Polymorphism:** Similar to the Runtime in which the compiler decides which functions to call rather than the program  