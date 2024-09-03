![[2024-04-15_16-36.png]]


### Big O  notation 

#Big_O_notation 

- In respect to the chart 
- This *chart* is **like a speedometer** for `algorithms`, measuring **how their running time or space requirements** grow as the size of the input increases. 
- Each **line represents a different "time complexity,"** which is a way of talking about how efficient an algorithm is.

In computer Science 
- time complexity is a way to quantify the time an algorithm takes to complete 
- In respect to the input
- Its about how an algorithm would perform as the size of the dataset increases 

``` C
you choose algorithms and data structures based on their time complexities to make sure your code runs fast even when the input is large.
``` 

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
#include <iostream>

// Forward declarations to make sure we can call the functions in any order.
void Function2();
void Function3();

// Function1: Calls Function2 and Function3
void Function1() {
    std::cout << "Entering Function1" << std::endl;
    
    // Notes in Function1
    std::cout << "Notes in Function1" << std::endl;

    // Function1 calls Function2
    Function2();

    // Function1 calls Function3
    Function3();

    std::cout << "Exiting Function1" << std::endl;
}

// Function2: Calls Function3
void Function2() {
    std::cout << "Entering Function2" << std::endl;
    
    // Notes in Function2
    std::cout << "Notes in Function2" << std::endl;

    // Function2 calls Function3
    Function3();

    std::cout << "Exiting Function2" << std::endl;
}

// Function3: Just contains notes
void Function3() {
    std::cout << "Entering Function3" << std::endl;
    
    // Notes in Function3
    std::cout << "Notes in Function3" << std::endl;

    std::cout << "Exiting Function3" << std::endl;
}

// Main function: Calls Function1
int main() {
    std::cout << "Entering main" << std::endl;

    // main calls Function1
    Function1();

    std::cout << "Exiting main" << std::endl;
    
    return 0;
}
```



ASCII explanation 

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

[[time complexities analogy]]

[[Runtime Stack]]

