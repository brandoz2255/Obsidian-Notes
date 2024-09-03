# How to
### Runtime Stack 

(also known as the call stack)

- Runtime stack like a stack of plates in a cafeteria. 
- When you add a new plate, it goes on top, and when you take a plate to use, you also take it from the top.
- You can't just pull out a plate from the middle or bottom without causing a mess.

In other words its data structure that stores information of the active subroutines of a computer program

- Important for keeping track of each function 
- the runtime stack is used every time you call a function.
- When a function is called, its return address and arguments are pushed onto the stack.
- Each time a function is called it gets put into a `frame` called **function frames** 


```C++
Initial stack with just main():

|     main     |
|--------------|
|     ...      |  <-- Bottom of Stack (first frame)

After main() calls Function1():

|   Function1  |  <-- Top of Stack (newest frame)
|--------------|
|     main     |
|--------------|
|     ...      |

After Function1() calls Function2():

|   Function2  |  <-- Top of Stack (newest frame)
|--------------|
|   Function1  |
|--------------|
|     main     |
|--------------|
|     ...      |

After Function2() calls Function3():

|   Function3  |  <-- Top of Stack (newest frame)
|--------------|
|   Function2  |
|--------------|
|   Function1  |
|--------------|
|     main     |
|--------------|
|     ...      |

Function3() completes and is popped off:

|   Function2  |  <-- Now at the top again
|--------------|
|   Function1  |
|--------------|
|     main     |
|--------------|
|     ...      |

Function2() completes and is popped off:

|   Function1  |  <-- Now at the top again
|--------------|
|     main     |
|--------------|
|     ...      |

Function1() calls Function3() again:

|   Function3  |  <-- Top of Stack (newest frame)
|--------------|
|   Function1  |
|--------------|
|     main     |
|--------------|
|     ...      |

Function3() completes and is popped off:

|   Function1  |  <-- Now at the top again
|--------------|
|     main     |
|--------------|
|     ...      |

Finally, Function1() completes and is popped off, leaving only main():

|     main     |  <-- Now at the top again
|--------------|
|     ...      |

And when main() returns, the stack is completely cleared.

```


```C
+---------------------+
|       Person        |
+---------------------+
| - Private Section   |
| - name: string      |
| - age: int          |
+---------------------+
| # Protected Section |
| # id: int           |
+---------------------+
| + Public Section    |
| + getName(): string |
| + setName(name: string): void |
| + getAge(): int     |
| + setAge(age: int): void |
+---------------------+
           ^
           |
           |
+---------------------+
|       Student       |
+---------------------+
| - Private Section   |
| - studentID: int    |
+---------------------+
| # Protected Section |
| # schoolName: string|
+---------------------+
| + Public Section    |
| + getStudentID(): int |
| + setStudentID(studentID: int): void |
| + getSchoolName(): string |
| + setSchoolName(schoolName: string): void |
+---------------------+
```


Explanation:  

1. **`main()` is Called:** The stack starts with the `main()` frame.
    
2. **`Function1()` is Called by `main()`:** `Function1()` is added on top of the `main()` frame in the stack.
    
3. **`Function2()` is Called by `Function1()`:** `Function2()` is added on top of `Function1()`.
    
4. **`Function2()` Finishes Execution:** After `Function2()` finishes, its frame (the top "book") is removed, leaving `Function1()`'s frame on top.
    
5. **`Function1()` Finishes Execution:** Once `Function1()` is done, its frame is removed, and we're back to the `main()` frame.
    
6. **`main()` Reaches the End:** Finally, `main()` finishes, and its frame is removed, emptying the stack.



## Const

Creates a unchangeable variable 

### offstream: out put file stream 
```C++
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main() {
    ofstream outFile("output.txt"); // Opening the file "output.txt" for writing

    if (!outFile) {
        cout << "Unable to open file output.txt" << endl;
        return 1; // Simple error message if the file cannot be opened
    }

    // Writing five lines to the file using a for loop
    for (int i = 0; i < 5; i++) {
        outFile << "Line " << i + 1 << ": This is a test line." << endl;
    }

    outFile.close(); // Close the file
    return 0;
}

```


### ifstream : input file stream 
```C++
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main() {
    ifstream inFile("input.txt"); // Opening the file "input.txt" for reading
    string line;

    if (!inFile) {
        cout << "Unable to open file input.txt" << endl;
        return 1; // Simple error message if the file cannot be opened
    }

    while (getline(inFile, line)) { // Read lines from the file until the end
        cout << line << endl; // Output each line to the console
    }

    inFile.close(); // Close the file
    return 0;
}

```


### Incrementing 

```C++
#include <iostream>
using namespace std;

int main() {
    // For loop from 1 to 5
    for (int i = 1; i <= 5; i++) {
        cout << "Value of i: " << i << endl;
    }
    return 0;
}

```



```C++
#include <iostream>
using namespace std;

int main() {
    int j = 1; // Initialize j to 1

    // While loop continues as long as j is less than or equal to 5
    while (j <= 5) {
        cout << "Value of j: " << j << endl;
        j++; // Increment j by 1
    }
    return 0;
}
```

- Remember could also be i + 1 and j + 1 but j++  and i++ works just as fine 


### Binary Search 

```C++
#include <iostream>
#include <vector>

int binary_search(const std::vector<int>& arr, int target) {
    int low = 0;
    int high = arr.size() - 1;

    while (low <= high) {
        int mid = low + (high - low) / 2; // Calculate mid point of the search range
        int guess = arr[mid]; // Element at mid index

        if (guess == target) {
            return mid; // Return the index of the target
        }
        if (guess > target) {
            high = mid - 1; // Search the left half, target must be in the lower part
        } else {
            low = mid + 1; // Search the right half, target must be in the upper part
        }
    }

    return -1; // Target is not in the array
}

int main() {
    std::vector<int> sorted_list = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19};
    int target_number = 7;

    int result = binary_search(sorted_list, target_number);
    if (result != -1) {
        std::cout << "Target found at index: " << result << std::endl;
    } else {
        std::cout << "Target not found." << std::endl;
    }

    return 0;
}
```

### Important
```C++

        if (number_to_search_for > array[mid]) {
            low = mid + 1; // Search the right half
        } else {
            high = mid - 1; // Search the left half
        }
    }
```

## Pointers 

```C++
#include <iostream>
using namespace std;

class Dog {
private:
    int age;
public:
    Dog() : age(0) {} // Default constructor to initialize age

    void setAge(int a) {
        age = a;
    }

    int getAge() const {
        return age;
    }

    void printAge() const {
        cout << "The dog's age is: " << age << endl;
    }
};

int main() {
    Dog rex;            // Create a Dog object
    Dog* p = &rex;      // Pointer to the Dog object

    // Accessing member function using pointer and dereferencing operator (*p)
    (*p).setAge(5);     // Equivalent to p->setAge(5)
    cout << "Age set using (*p).setAge(5): ";
    rex.printAge();     // Direct call on the object to print age

    // Alternatively, using the arrow operator, which is more common
    p->printAge();      // Prints age using the pointer and arrow operator

    // Setting new age to demonstrate the use of (*p).getAge()
    (*p).setAge(7);
    cout << "New age obtained using (*p).getAge(): " << (*p).getAge() << endl;

    return 0;
}
```


Also 
```C++
#include <iostream>
using namespace std;

int main() {
    int num = 10;        // Declare an integer variable
    int *p = &num;       // Declare a pointer and initialize it with the address of `num`

    cout << "Original value of num: " << num << endl;          // Output the original value of `num`
    cout << "Value of num via pointer: " << *p << endl;        // Dereference `p` to get the value of `num`

    *p = 20;             // Modify the value of `num` through the pointer by dereferencing `p`
    cout << "New value of num via direct access: " << num << endl;     // Output the new value of `num` directly
    cout << "New value of num via pointer dereference: " << *p << endl; // Output the new value by dereferencing `p`

    // Additional usage: Using a pointer in expressions
    *p += 5;             // Modify `num` through the pointer by adding 5
    cout << "Value of num after adding 5 via pointer: " << *p << endl;  // Output the modified value

    // Using pointer arithmetic (advanced example)
    int values[3] = {10, 20, 30};
    int *ptr = values;  // Pointer to the first element of the array
    cout << "First element of the array via pointer: " << *ptr << endl; // Dereference to get the first element
    ptr++;              // Move to the next element
    cout << "Second element of the array via pointer: " << *ptr << endl; // Dereference to get the second element

    return 0;
}
```



### Array example 
```C++
#include <iostream>

// Function to multiply each element in an array of size 5 by 2
void multiplyElementsByTwo(int elements[5]) {
    for (int i = 0; i < 5; i++) {
        elements[i] *= 2; // Multiply each element by 2
    }
}

int main() {
    int myArray[5] = {1, 2, 3, 4, 5}; // Example array

    multiplyElementsByTwo(myArray); // Call the function to modify the array

    std::cout << "The elements multiplied by 2 are: ";
    for (int i = 0; i < 5; i++) {
        std::cout << myArray[i] << " "; // Output the modified elements
    }
    std::cout << std::endl;

    return 0;
}

```


#### Classes
```C++
#include <iostream>
using namespace std;

// Base class
class Animal {
protected:
    string name;
    int age;

public:
    Animal(string n, int a) : name(n), age(a) {}

    void displayInfo() const {
        cout << "Name: " << name << ", Age: " << age << endl;
    }

    protected:
    void displaySecret() const {
        cout << "This is a protected method." << endl;
    }
};

// Derived class
class Dog : public Animal {
public:
    Dog(string n, int a) : Animal(n, a) {}

    // Overriding the speak function
    void speak() const {
        cout << name << " says: Woof!" << endl; // Accessing protected member 'name'
        displaySecret(); // Calling protected method
    }

    void testAccess() {
        displayInfo(); // Accessing public member function
    }
};

int main() {
    Dog myDog("Rex", 3);
    myDog.displayInfo(); // Accessing public method
    myDog.speak(); // Accessing overridden method which uses protected members
    myDog.testAccess(); // Testing access to public method

    return 0;
}
```

# what is 

- `ofstream` is a class in C++ used to write data to files. It's part of the C++ Standard Library, and allows you to output data just like you would to the console, but to a file instead.


- `ifstream` is a C++ class that provides the ability to read data from files. It's part of the C++ Standard Library and lets you input data from a file as easily as you would from standard input, like the keyboard.

#### Vectors 
- `Vectors` are dynamic arrays provided by the C++ Standard Library that can automatically resize as you add or remove elements. They offer convenient access to elements through methods and operators, making them a versatile choice for handling data that varies in size.

- `Arrays` in C++, on the other hand, are fixed-size collections of elements of the same type, allowing direct access via indices. They provide a simple and efficient way to store data for quick access but lack the flexibility of automatic resizing.

**Classes**: In C++, a class is a blueprint for creating objects that encapsulate data and functions. Classes define the structure and behaviors of the objects, allowing complex data types to be modeled in a program. They provide a foundation for object-oriented programming, which includes inheritance, encapsulation, and polymorphism.

**Public**: Public **members of a class are accessible from any part of the program where the object is visible**. They define the interface of the class, which means any function or object can interact with the public parts of a class. Using public members, one can manipulate and retrieve the object's data directly.

**Private**: Private members of a class are **only accessible within the class itself** and not from any other part of the program. They are crucial for encapsulation, as they prevent external parts of the program from directly changing the state of an object. Private members ensure that only class methods can access and modify them, maintaining integrity and security of the data.

**Protected**: Protected members of a class are similar to private members, but they are also accessible within any subclass (derived class) of that class. This **allows subclasses to inherit** and modify protected members, facilitating more flexible class designs. Protected is often used in situations where internal class data should be hidden from general access but still available to specialized extensions.

**Binary search**: is an efficient algorithm for finding a target value within a sorted array or list. It operates by repeatedly dividing the search interval in half, narrowing down the possible locations of the target at each step. To work, it compares the target with the middle element of the array: if they match, it returns the location; if the target is less, it searches the left half; otherwise, it searches the right half.

In **object-oriented programming**, particularly with inheritance in C++, the base (or original) class does not have knowledge of any members (functions or variables) that are added in its subclasses. This is because inheritance is a one-way relationship where the subclass knows about the base class, but the base class does not know about the subclass. This is crucial for maintaining the encapsulation principle in object-oriented design.

### Access Levels in C++ Inheritance:

- **Public Members:** Can be accessed anywhere the object is accessible.
- **Protected Members:** Can be accessed within the class itself, any of its derived classes, and friends of these classes, but not outside these classes.
- **Private Members:** Can only be accessed within the class itself and by friends of the class (not by derived classes).

### Common Member Functions of `std::vector`

Vectors provide a wide range of member functions to manage their contents:

- **push_back(element)**: Adds an element to the end of the vector and increases the size by one.
- **pop_back()**: Removes the last element of the vector, reducing its size by one.
- **size()**: Returns the number of elements in the vector.
- **capacity()**: Returns the current capacity of the vector.
- **resize(n)**: Changes the size of the vector to n. If n is larger than the current size, new elements are added and initialized with a default value; if n is smaller, the vector is truncated.
- **reserve(n)**: Requests that the vector capacity be at least enough to contain n elements. This is useful for minimizing reallocations if you know in advance how many elements will be inserted.
- **operator[] (index)**: Accesses the element at the specified index without bounds checking.
- **at(index)**: Accesses the element at the specified index with bounds checking. Throws `std::out_of_range` if the index is out of bounds.
- **front()**: Returns a reference to the first element in the vector.
- **back()**: Returns a reference to the last element in the vector.
- **clear()**: Removes all elements from the vector, leaving it with a size of 0.
- **empty()**: Returns whether the vector is empty (i.e., its size is 0).
- **begin(), end()**: Return iterators to the start and past the end of the vector, respectively.

```C++
#include <iostream>
#include <vector>

int main() {
    std::vector<int> vec;  // Create a vector of integers

    // Add elements to the vector
    vec.push_back(10);
    vec.push_back(20);
    vec.push_back(30);

    // Access and print elements
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec.size(); ++i) {
        std::cout << vec[i] << " ";
    }
    std::cout << std::endl;

    // Remove the last element
    vec.pop_back();

    // Print the current size and capacity of the vector
    std::cout << "Size after pop_back: " << vec.size() << std::endl;
    std::cout << "Capacity: " << vec.capacity() << std::endl;

    // Access first and last element
    std::cout << "First element: " << vec.front() << std::endl;
    std::cout << "Last element: " << vec.back() << std::endl;

    return 0;
}
```

output:
```C
Vector elements: 10 20 30 
Size after pop_back: 2
Capacity: 4
First element: 10
Last element: 20
```



-  **Pass by value** means *passing a copy of the actual data to a function*,
	- In pass by value, a copy of the actual argument (value) is passed to the function. Changes made to the parameter inside the function have no effect on the original data.

- while **pass by reference** means *passing the memory address of the data to the function, allowing direct modification of the original data*.c
	- In pass by reference, instead of passing a copy of the variable, you pass its reference. Any change to this parameter in the function will affect the original variable.
		- can be done using a pointer 


**Time complexity Big O notation**:  Time complexity in computer science refers to the computational complexity that describes the amount of computational time taken by an algorithm to run, as a function of the size of the input to the program.
	- It is a measure of the time taken by an algorithm to run, as the input size grows.
	- **Big O notation**: is a mathematical notation used to describe the limiting behavior of a function when the argument tends towards a particular value or infinity.
		- the time complexity of linear search is *O(n)*, where *n* is the number of elements in the list. This
		- time complexity of binary search is *O(log n)*, indicating that the algorithm divides the list in half with each step, significantly reducing the number of elements it needs to check.

**recursion**: Recursion in computer science is a technique where a function calls itself directly or indirectly until a base condition is met.
	-  Useful for breaking down problems into smaller sub problems to solve the issue 
	- In C++ The function must have a base case to prevent infinite recursion and ensure that the recursion eventually stops.
	- The **base case** is a condition that, when met, stops the recursive calls and returns a value.

**Direct Recursion**: This occurs when a function calls itself directly within its own body. It's a straightforward form of recursion where the function is the one making the recursive call.


- **Indirect Recursion**: This type of recursion involves at least two functions where one function calls another, and that other function calls the first function again. **AKA: Mutual recursion**
	- This creates a cycle of function calls between two or more functions.
	- Indirect recursion is useful in scenarios where a problem can be naturally divided into smaller sub-problems that are solved by different functions.

Recursion goes hand and hand with the call time stack so remember that!  