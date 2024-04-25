```C++
#include <iostream>
#include <vector>

std::vector<double> smooth(const std::vector<double>& data, int windowSize) {
    std::vector<double> smoothed(data.size());
    int halfWindow = windowSize / 2;

    for (size_t i = 0; i < data.size(); i++) {
        double sum = 0;
        int count = 0;

        for (int j = -halfWindow; j <= halfWindow; j++) {
            int k = i + j;
            if (k >= 0 && k < data.size()) {
                sum += data[k];
                count++;
            }
        }

        smoothed[i] = sum / count;
    }

    return smoothed;
}

int main() {
    std::vector<double> data = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    std::vector<double> result = smooth(data, 3);

    for (double v : result) {
        std::cout << v << " ";
    }

    return 0;
}

```


^ this is the process of smoothing a function

- In this code, the `smooth` function calculates the moving average for a set window size around each point in the data array.****

# Data Types 

- **Compound Data**: Building more complex data structures from simpler ones.
	- Compound data can be understood as a way to group multiple values which may be of different types into a single unit.
	- Common examples include **arrays, lists, structures, and objects**.

### Examples:

1. **Arrays**: An array is a compound data type that consists of elements of the same type placed in contiguous memory locations. It allows you to store a collection of data, but all must be of the same type.
	1. However it is a fixed amount of space for this data structure 
	2. **Vector** is the same however is not strict on a fixed size similar to a list in python that grows as you add more 
    
2. **Structures**: In languages like C and C++, a `struct` is a classic example of a compound data type. It allows you to package different types of data elements together into a single unit.
	1. basically a class for variables  can hold as many variables that belong to a data group and can be of different data types 
    
3. **Classes**: In object-oriented programming, classes are used to create complex data types that encapsulate both data (in the form of fields) and operations on data (in the form of methods).
	1. containers for functions 
    
4. **Tuples**: Available in languages like Python, a tuple is an immutable compound data type that can contain elements of different types. It's useful for fixed collections of items.
	1.  Tuples an array that can hold different data types into one list/array/vector what ever you want to call it 
	1. **Immutable:** Once created, the contents of a tuple cannot be changed. This means you cannot add, remove, or modify elements in a tuple, making them useful for read-only or constant data storage.
	2. **Ordered:** The elements in a tuple have a specific order, and you can access them by their position. This is similar to accessing elements in an array or a list.
	3. **Heterogeneous:** The elements of a tuple can be of different types, as you mentioned, like a combination of strings, integers, floats, or even other complex objects.

```Python
# Defining a tuple with different data types
my_tuple = ("Rex", "dog", 5, True)

# Accessing elements of the tuple
print(my_tuple[0])  # Outputs: Rex
print(my_tuple[1])  # Outputs: dog
print(my_tuple[2])  # Outputs: 5
print(my_tuple[3])  # Outputs: True
```

### Compound Data Objects

**Combination of Diverse Data Types:** Compound data objects can include various types of data, such as integers, strings, floats, arrays, or even other objects. This diversity allows developers to model complex entities from the real world more effectively.

#### Python

```Python 
# Tuple: Immutable and can hold mixed data types
person = ("John Doe", 30, True)

# List: Mutable and can hold mixed data types
colors = ["red", "green", "blue", 123]

# Dictionary: Key-value pairs
car = {
    "make": "Ford",
    "model": "Mustang",
    "year": 1964
}

# Class: User-defined compound object
class Dog:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def bark(self):
        print(f"{self.name} says woof!")

my_dog = Dog("Rover", 5)
my_dog.bark()  # Outputs: Rover says woof!
```

#### C++
```C++
#include <iostream>
#include <string>

// Define a struct
struct Car {
    std::string make;
    std::string model;
    int year;
};

// Define a class
class Book {
private:
    std::string title;
    std::string author;
    int pages;

public:
    Book(std::string t, std::string a, int p) : title(t), author(a), pages(p) {}

    void displayInfo() {
        std::cout << "Book: " << title << ", Author: " << author << ", Pages: " << pages << std::endl;
    }
};

int main() {
    Car myCar = {"Toyota", "Corolla", 2020};
    Book myBook("1984", "George Orwell", 328);

    std::cout << "Car: " << myCar.make << " " << myCar.model << " " << myCar.year << std::endl;
    myBook.displayInfo();

    return 0;
}
```
Compound data objects are crucial for:

- **Modular programming:** They help in creating modular code where different parts of a program can be developed and tested independently.
- **Data management:** They make the management of large sets of data more organized and accessible.
- **Real-world modeling:** They allow programmers to model complex real-world entities in a structured and intuitive way.


### Data Absrtaction
- It is the process of hiding the complex reality while exposing only the necessary parts of objects or systems.
- This abstraction allows developers to handle complexities by reducing the amount of details they need to manage.

#### Key Aspects of Data Abstraction:

1. **Simplification:** It simplifies complex reality by modeling classes appropriate to the problem, and working at the most relevant level of inheritance for a particular aspect of the problem.
2. **Reduction of Complexity:** Developers can avoid redundant coding and increase reusability by focusing on the operational essentials.
3. **Increase in Efficiency:** By focusing on the necessary operations, data abstraction helps in increasing efficiency and effectiveness of the development process.

### Types of Data Abstraction:

1. **Procedural Abstraction:** The user interacts with the software through a series of procedures or actions, without needing to understand the specifics of how these actions are implemented.
    
2. **Data Abstraction:** Users operate on data collections through a defined interface without needing to understand the data's underlying form.

Examples of Data Abstraction:

```C++ 
class Animal {
protected:
    std::string name;
    int age;

public:
    Animal(std::string n, int a): name(n), age(a) {}
    virtual void makeSound() = 0; // Pure virtual function makes Animal an abstract class
};

class Dog : public Animal {
public:
    Dog(std::string n, int a): Animal(n, a) {}
    void makeSound() override {
        std::cout << "Woof!" << std::endl;
    }
};

int main() {
    Animal* myPet = new Dog("Rover", 5);
    myPet->makeSound(); // Outputs: Woof!
    delete myPet;
    return 0;
}
```


**In Database Systems:** The concept of abstraction is also applied in database systems through abstraction layers. Users interact with a high-level query language (like SQL) without needing to know how data is structured and stored in the database.


# Fleet to continue 
- abstracion barriers 
- techniques fore representing sequences and trees
- closure with compound data 
- conventional interfaces 
- symbolic expressions 
- generic operations 