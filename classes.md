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


## UML
- UML (unified Modeling Language ):  is the standardized modeling language in the field of software engineering. 
	- used to visualize ,construct and document artifacts of a software system

UML is used for a variety of purposes, including:

1. **Designing the architecture of a system**: UML diagrams can help in designing the overall structure of a system, including its components and their relationships.

2. **Designing the behavior of a system**: UML can be used to model the dynamic behavior of a system, including the interactions between objects and the sequence of events.

3. **Designing the structure of a system**: UML can be used to model the static structure of a system, including the classes, attributes, and relationships between classes.

4. **Documenting the system**: UML diagrams can serve as a form of documentation, providing a visual representation of the system's design and behavior.

5. **Communicating the design**: UML diagrams can be used to communicate the design of a system to stakeholders, including developers, managers, and clients.

The More specific use is for its design in the use of classes. Mainly a Blueprint for the classes we are trying to make

``` Python
+-----------------------------------+
|          <<class>>               |
|          Library                 |
+-----------------------------------+
| -books: vector<Book>             |
| -members: vector<Member>         |
+-----------------------------------+
| +addBook(book: Book): void       |
| +addMember(member: Member): void |
| +removeBook(book: Book): void    |
| +removeMember(member: Member): void |
| +findBook(title: string): Book   |
| +findMember(name: string): Member|
+-----------------------------------+

+-----------------------------------+
|          <<class>>               |
|          Book                    |
+-----------------------------------+
| -title: string                   |
| -author: string                  |
| -isbn: string                    |
+-----------------------------------+
| +getTitle(): string              |
| +getAuthor(): string             |
| +getISBN(): string               |
+-----------------------------------+

+-----------------------------------+
|          <<class>>               |
|          Member                  |
+-----------------------------------+
| -name: string                    |
| -id: string                      |
+-----------------------------------+
| +getName(): string               |
| +getID(): string                 |
+-----------------------------------+
```

The UML Diagram ^ 

Here is the implementation 

``` C++
#include <iostream>
#include <vector>
#include <string>

// Forward declaration of Book and Member classes
class Book;
class Member;

class Library {
private:
    std::vector<Book> books;
    std::vector<Member> members;

public:
    void addBook(const Book& book) {
        books.push_back(book);
    }

    void addMember(const Member& member) {
        members.push_back(member);
    }

    void removeBook(const Book& book) {
        // Implementation to remove a book
    }

    void removeMember(const Member& member) {
        // Implementation to remove a member
    }

    Book findBook(const std::string& title) {
        // Implementation to find a book by title
        return Book(); // Placeholder return
    }

    Member findMember(const std::string& name) {
        // Implementation to find a member by name
        return Member(); // Placeholder return
    }
};

class Book {
private:
    std::string title;
    std::string author;
    std::string isbn;

public:
    Book(const std::string& title, const std::string& author, const std::string& isbn)
        : title(title), author(author), isbn(isbn) {}

    std::string getTitle() const {
        return title;
    }

    std::string getAuthor() const {
        return author;
    }

    std::string getISBN() const {
        return isbn;
    }
};

class Member {
private:
    std::string name;
    std::string id;

public:
    Member(const std::string& name, const std::string& id)
        : name(name), id(id) {}

    std::string getName() const {
        return name;
    }

    std::string getID() const {
        return id;
    }
};

int main() {
    Library library;
    Book book("The Catcher in the Rye", "J.D. Salinger", "9780316769789");
    Member member("John Doe", "123456");

    library.addBook(book);
    library.addMember(member);

    // Further operations...

    return  0;
}
```

# Vector 
This is a dynamic array that can grow or shink as needed part of the` STL lilbrary Standard Template Library` 

### Key Features of `vector` in C++:

1. **Dynamic Size**: Unlike arrays, which have a fixed size determined at compile time, vectors can grow and shrink at runtime. This is particularly useful when the number of elements is not known in advance.

2. **Random Access**: Elements in a vector can be accessed directly using the index, just like in an array. This allows for efficient access to any element in the vector.

3. **Insertion and Deletion**: Vectors support insertion and deletion of elements at any position. This is done efficiently, with the underlying array being resized as needed.

4. **Automatic Memory Management**: Vectors manage their own memory, automatically allocating and deallocating memory as elements are added or removed. This helps prevent memory leaks and makes the code safer and easier to manage.

5. **STL Compatibility**: Vectors are part of the Standard Template Library (STL), which means they can be used with other STL components like algorithms and iterators, making them a versatile tool for many programming tasks.

```C++
#include <iostream>
#include <vector>

int main() {
    // Creating a vector of integers
    std::vector<int> numbers;

    // Adding elements to the vector
    numbers.push_back(1);
    numbers.push_back(2);
    numbers.push_back(3);

    // Accessing elements
    std::cout << "First element: " << numbers[0] << std::endl;

    // Iterating over the vector
    for (int num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;

    // Removing the last element
    numbers.pop_back();

    // Checking the size of the vector
    std::cout << "Size of the vector: " << numbers.size() << std::endl;

    return  0;
}

```