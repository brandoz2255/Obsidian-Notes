
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



# Arrays and such
# Multidimensional Arrays 

- **2D Arrays**: It's basically a Multidimensional Array is just an array of arrays. These are used to represent tables or matrices (Linear Algebra) the two dimensional is the simplest form of this array. 
	- This one is visualized as a tow of columns like a grid. 

```C++
#include <iostream>

int main() {
    // Declare a 2D array with 3 rows and 4 columns
    int myArray[3][4] = {
        {1, 2, 3, 4},
        {5, 6, 7, 8},
        {9, 10, 11, 12}
    };

    // Access elements from the array
    for(int i = 0; i < 3; i++) {
        for(int j = 0; j < 4; j++) {
            std::cout << myArray[i][j] << " ";
        }
        std::cout << std::endl;
    }

    return 0;
}
```

- **3D Arrays**: 3D array is more deeper than the 2D one where 2D is `an array of an array` A three dimensional is `an array of arrays of arrays` **`per dimension represents how many arrays the arrays holds. `** '

Example: 

```C++
#include <iostream>

int main() {
    // Creating a 3D array with 2 layers, each layer having 3 rows and 4 columns
    int array3D[2][3][4] = {
        {   // Layer 1
            {1, 2, 3, 4},      // Row 1
            {5, 6, 7, 8},      // Row 2
            {9, 10, 11, 12}    // Row 3
        },
        {   // Layer 2
            {13, 14, 15, 16},  // Row 1
            {17, 18, 19, 20},  // Row 2
            {21, 22, 23, 24}   // Row 3
        }
    };

    // Accessing elements from the 3D array
    for(int i = 0; i < 2; i++) {       // Layers
        std::cout << "Layer " << i+1 << ":\n";
        for(int j = 0; j < 3; j++) {    // Rows
            for(int k = 0; k < 4; k++) { // Columns
                std::cout << array3D[i][j][k] << " ";
            }
            std::cout << std::endl;
        }
        std::cout << std::endl;
    }

    return 0;
}
```

Visual of 3D arrays:

```C++
 Layer 1:                Layer 2:
+------+------+------+  +------+------+------+
| 1    | 2    | 3    |  | 13   | 14   | 15   |
|      |      |      |  |      |      |      |
+------+------+------+  +------+------+------+
| 5    | 6    | 7    |  | 17   | 18   | 19   |
|      |      |      |  |      |      |      |
+------+------+------+  +------+------+------+
| 9    | 10   | 11   |  | 21   | 22   | 23   |
|      |      |      |  |      |      |      |
+------+------+------+  +------+------+------+
```


# Linear-izing Mulitdimensional Data 

- **Linearization**: Also known as `flattening`  This process evolves transforming a multidimensional array into a one-dimensional array. 
	- this process is done but taking the elements and placing them into a single continuous (array). this can be useful to access other element's without dealing with the multiple `indices` 

### How It Works

- Linearizing takes the elements from the multidimensional structure and arranges them sequentially in memory. 
- The exact order can depend on row-major or column-major ordering:

- **Row-major ordering**: This stores all the elements for a given row continuously in memory before moving onto the next row. 
	- **For example**, in a 2D array, you process all elements of the first row, then all elements of the second row, and so on.
- **Column-Major ordering**: This stores all the elements of a column continuously before moving down to the next column  

Example: 

**OG 2D Array:**

```code
1 2 3
4 5 6
7 8 9
```

**Linearized Array(Row-major): **

```Code
1 2 3 4 5 6 7 8 9
```

```C++
#include <iostream>
#include <vector>

using namespace std;

void linearize2D(const vector<vector<int>>& multi, vector<int>& linear) {
    for (const auto& row : multi) {
        for (int elem : row) {
            linear.push_back(elem);
        }
    }
}

int main() {
    vector<vector<int>> twoDArray = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    };
    vector<int> linearArray;

    linearize2D(twoDArray, linearArray);

    std::cout << "Linearized Array: ";
    for (int value : linearArray) {
        cout << value << " ";
    }
    cout << endl;

    return 0;
}

```

### Application and Considerations

- **Memory Layout**: Understanding how arrays are laid out in memory can be crucial for performance, especially when dealing with large datasets or high-performance computing.
- **Data Processing**: Linearized data is easier to pass to functions or libraries that expect a flat data structure, such as certain mathematical libraries or when interfacing with hardware.
- **Simplicity vs. Performance**: While linearizing can simplify the handling of data, it might not always be the most efficient way to process multidimensional data due to potential cache inefficiency.

#### 5 year old explanation 

Think of Multidimensional data as a box of toys holding different toys each toy categorized into different categories such as legos stuffed animals etc(different Arrays). 

The Process of linearization is getting all those toys out of the box and placing them in a straight line so that it makes it easier to count them. 


# Passing Multidimensional arrays

**Passing**: When passing multidimensional Arrays it involves a few concepts such as `formal Parameters` and `actual parameters` which often envolves a formula for accessing array elements. 

- **Formal parameter**: This is the variable as it appears in the function declaration.  In order top pass a multidimensional array to a function the formal parameter must be set in order to specify the array dimensions. 

Example with 2D array:

```C++
void printArray(int arr[][3], int rows) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < 3; j++) {
            std::cout << arr[i][j] << " ";
        }
        std::cout << std::endl;
    }
}
```

- Here, `int arr[][3]` is a formal parameter for a two-dimensional array where the number of columns (`3`) must be specified.

- **Actual Parameter**: this is a specific array or variable that yopu pass to thye function when you call it. `Esssentially the real data that the function will manipulate or read!` 

```C++
int main() {
    int myArray[2][3] = {{1, 2, 3}, {4, 5, 6}};
    printArray(myArray, 2);  // Passing myArray as an actual parameter
    return 0;
}
```

- Here, `myArray` is the actual parameter being passed to the `printArray` function.

Formula for accessing Multidimensional Arrays 

$$index = i * C + j
$$

This is how you calculate the linear index in a row-major storage scheme (like in C++).

Example: 

```C++
int main() {
    int myArray[2][3] = {{1, 2, 3}, {4, 5, 6}};
    int* ptr = &myArray[0][0]; // Pointer to the first element of the array
    int numRows = 2;
    int numCols = 3;

    for (int i = 0; i < numRows; i++) {
        for (int j = 0; j < numCols; j++) {
            // Accessing each element by calculating the index
            std::cout << *(ptr + i * numCols + j) << " ";
        }
        std::cout << std::endl;
    }

    return 0;
}
```

