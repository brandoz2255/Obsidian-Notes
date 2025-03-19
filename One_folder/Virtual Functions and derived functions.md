#### Fleet 
- [x] Virtual Functions ✅ 2024-04-30
- [x] Derived Functions ✅ 2024-04-30
- [x] Provide Example ✅ 2024-04-30
- [x] Derived Classes ✅ 2024-04-30
- [x] Dynamic binding ✅ 2024-04-30
- [x] Polymorphism : My favorite ✅ 2024-04-30
- [x] Can you have an array that can hold two objects ✅ 2024-05-01
- [x] Is C++ used in the industry? ✅ 2024-05-13
- [x] Different types of polymorphism ✅ 2024-04-30
- [x] Abstract classes ✅ 2024-05-01
- [x] Pure virtual ✅ 2024-05-05
- [ ] Stack : compile time 
- [ ] Heap : runtime 
- [ ] Stack over flow why with in relation to stack and heap 


# Virtual Functions and Derived Functions

- ***Derived classes***: are classes that inherit properties and behaviors from a base class but can also include additional properties and behaviors:
	- In other words the subclass 

```C++
class Dog : public Animal {
    public:
    void bark() {
        cout << "Woof!" << endl;
    }
};

```

- **Virtual Functions**: A virtual function is a member function in a base class that you expect to override in derived classes.
	- The main use of virtual functions is to allow a function to be overridden in derived classes to perform a behavior that's more specific to the derived class.
	- Polymorphism at it's finest

## Dynamic Binding

- **Dynamic binding** is a mechanism by which a call to an overridden function is resolved at runtime, rather than compile time. 
	- This is in contrast to static binding (early binding), where the function called is determined at compile time.

- **Concept**: Dynamic binding is a mechanism by which a call to an overridden function is resolved at runtime, rather than compile time.
	- This is in contrast to static binding (early binding), where the function called is determined at compile time.
	- Dynamic binding uses pointers or references to objects to determine which function to call.
	- Only works wehn a base class is declared as `virutal` 
	- Once it is marked as `virtual` C++ maintains a Virtual table

- **Virtual Table**: When a class is instantiated, the compiler adds a hidden pointer to the vtable, usually called a `vptr`. 
	- The `vptr` points to the vtable of the class.

```C++
class Base {
    public:
    virtual void print() { cout << "Print base class" << endl; }
    void show() { cout << "Show base class" << endl; }
};

class Derived : public Base {
    public:
    void print() { cout << "Print derived class" << endl; }
    void show() { cout << "Show derived class" << endl; }
};

int main() {
    Base* b;
    Derived d;
    b = &d;

    b->print();  // Calls Derived's print()
    b->show();   // Calls Base's show()
}
```

In this example, `b->print()` dynamically binds to the `print()` method in `Derived` because it is declared as `virtual` in the base class. However, `b->show()` statically binds to the `show()` method in `Base` since it's not virtual.

- **Advantages**:
    
    - Flexibility: Dynamic binding allows for more flexible and reusable code.
    - Polymorphism: It supports polymorphism, enabling the use of a unified interface for objects of different classes.

# Polymorphism Definition 

**Polymorphism**: It is the ability of a function, object, or reference to take on many forms. 

- The most common use of polymorphism in OOP occurs when a parent class reference is used to refer to a child class object.
- Which in other words Polymorphism is the ability to change the parent class to what ever you want using the parent class 

For example: 

```C++
Imagine you have a magic box that can change into many different toys. One day, it turns into a robot; another day, it can be a car or even a dinosaur. You don’t need to get a new box to play with a new toy because your magic box can "transform" into any toy you want. Polymorphism in programming is like this magic box—it lets programmers use one type of thing (like a box) in many forms (like toys).
```


### Different Types of PolyMorphism

- Compile time **Polymorphism**: This type is determined at compile time. In C++ this is primarily achieved through function overloading and operator overloading. 

- **Dynamic Binding (which is Run-time Plolymorphism):** This is the type determined at runtime and is implemented by method overriding using virtual functions. 
	- It’s like a call center script where the response varies depending on the caller’s question, even though the person answering the call is the same.

- **Ad-hoc Polymorphism**: This refers to polymorphic functions that can be applied to arguments of different types, but behave differently depending on the type of arguments they are applied to.

-  **Remember**: `tuples` on C++ is an array that can hold multiple data types in one array like a `int`, `string` , `char`, `double` all in one array. 

- **Struct**: is a "container" that holds different variables of different data types  together in one unit. 

```C++
#include <iostream>
#include <string>
using namespace std;

// Define a struct to represent a book in a library
struct Book {
    string title;
    string author;
    int yearPublished;
    bool isCheckedOut;
};

int main() {
    // Create an instance of Book
    Book myBook = {
        "The Great Gatsby",
        "F. Scott Fitzgerald",
        1925,
        false
    };

    // Access and print details about the book
    cout << "Book Details:" << endl;
    cout << "Title: " << myBook.title << endl;
    cout << "Author: " << myBook.author << endl;
    cout << "Year Published: " << myBook.yearPublished << endl;
    cout << "Checked Out: " << (myBook.isCheckedOut ? "Yes" : "No") << endl;

    // Update book status
    myBook.isCheckedOut = true;

    return 0;
}
```


## Abstract classes

- An **Abstract Class**: is a class that contains one or more abstract methods 
	- Kinda like a struct where its a unit holding variables 
	- Except the abstract class is a class that holds methods that don't have any functionality the functionality
	- must implemented in another module or a subclass that is using the abstract class it self


# Pure Virtual

- When a class contains function that do nothing unless a subclass has implemented the logic. 



