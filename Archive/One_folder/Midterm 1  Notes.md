The assignment operator (`=`) is not a relational operator in C++. Relational operators are used to compare two operands and return either true or false values, whereas the assignment operator is used to assign a value to a variable, constant, array, or vector. It does not compare two operands but rather assigns the value on its right to the variable on its left

- Meaning that a relational operator is what compares to operands 

To call a member function, you first need to create an instance (or object) of the class. Then, you use the dot operator (`.`) to call the member function on that instance. If you're using a pointer to an object, you would use the arrow operator (`->`) instead.


For example, if you have a class `MyClass` with a member function `printInformation()`, you would call this function on an instance of `MyClass` like so:

```C++
MyClass myObject; // Create an instance of MyClass
myObject.printInformation(); // Call the member function on myObject
```

when using pointer 

```C++ 
MyClass* myObjectPtr = new MyClass(); // Create a pointer to an instance of MyClass
myObjectPtr->printInformation(); // Call the member function on the object pointed to by myObjectPtr
```


An instance in C++ is an object of a class, which means it's a specific realization of any abstract data type or class. When you create an instance of a class, you're creating an object that has its own copy of all the data members of the class.



- **Pass by Value**: When you pass a variable by value, a copy of the variable is made, and the function works with this copy. Any changes made to the variable inside the function do not affect the original variable. This method is considered safer as it preserves the original data [4](https://www.geeksforgeeks.org/difference-between-call-by-value-and-call-by-reference/)[5](https://www.geeksforgeeks.org/cpp-functions-pass-by-reference/).

- **Pass by Reference**: Passing by reference involves passing the address of the variable to the function. The function then works directly with the original variable, not a copy. This means that any changes made to the variable inside the function will be reflected in the original variable. This method is often used when you want the function to modify the original data. It's considered risky as it allows direct modification of the original data [4](https://www.geeksforgeeks.org/difference-between-call-by-value-and-call-by-reference/)[5](https://www.geeksforgeeks.org/cpp-functions-pass-by-reference/).

For loop : 

```C++
#include <iostream>

int main() {
    // Print numbers from 1 to 5
    for (int i = 1; i <= 5; i++) {
        std::cout << i << " ";
    }
    return 0;
}

```

While Loop:
```C++
#include <iostream>

int main() {
    int i = 1; // Initialize i to 1

    // Print numbers from 1 to 5
    while (i <= 5) {
        std::cout << i << " ";
        i++; // Increment i
    }
    return 0;
}
```

**For Loop**: Used when the number of iterations is known. It includes initialization, condition, and increment/decrement in its structure, making it concise and easy to use for counting or iterating over a range.

**While Loop**: Used when the number of iterations is unknown. It only requires a condition to check before each iteration, making it suitable for situations where the loop should continue as long as a certain condition is true.

Another for loop example: 

```C++
#include <iostream>
using namespace std;

int main() {
    int end = 0;
    for (int start = 20; start > end; start--) {
        cout << start;
    }
    return 0;
}

```

- **Accessor Function**: A function used to retrieve the value of a private or protected variable from a class. It's often named with the "get" prefix. Accessor functions do not take any arguments and return the value of the variable they access [1](https://ww2.cs.fsu.edu/~nienaber/teaching/python/lectures/classes.html#:~:text=Accessors%20and%20Mutators&text=An%20accessor%20method%20is%20a,data%20variable%20in%20some%20way.)[4](https://www.thoughtco.com/definition-of-accessor-958008)[5](https://ccm.net/computing/programming/1873-accessors-and-mutators-in-c/).

- **Mutator Function**: A function used to modify the value of a private or protected variable within a class. It's often named with the "set" prefix. Mutator functions take one argument, which is the new value to be assigned to the variable, and do not return any value [1](https://ww2.cs.fsu.edu/~nienaber/teaching/python/lectures/classes.html#:~:text=Accessors%20and%20Mutators&text=An%20accessor%20method%20is%20a,data%20variable%20in%20some%20way.)[4](https://www.thoughtco.com/definition-of-accessor-958008)[5](https://ccm.net/computing/programming/1873-accessors-and-mutators-in-c/).