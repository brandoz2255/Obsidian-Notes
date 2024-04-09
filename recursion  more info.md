Recursion is calling a function within a function to break down a problem into smaller manageable parts to solve the problem it self 

# what not to do
- Recursion can be particularly problematic when used to process large amounts of data or when the depth of recursion is very high,
- as each recursive call adds a layer to the call stack. 
- This can quickly exhaust the stack space, leading to a stack overflow exception.
- **For example**, using recursion to traverse a very deep tree structure without proper tail call optimization (TCO) can lead to stack overflow.'
- TCO is a technique where the compiler or interpreter optimizes recursive calls to avoid adding a new stack frame for each call, thus reducing the risk of stack overflow. 
- However, not all programming languages or environments support TCO, making recursion risky for deep or large-scale data processing tasks [1](https://stackoverflow.com/questions/41469031/is-recursion-a-bad-practice-in-general).


## Other Types of Recursion 

**Recursion** in computer science can be categorized into two main types: **direct recursion** and **indirect recursion**. 


- **Direct Recursion**: This occurs when a function calls itself directly within its own body. It's a straightforward form of recursion where the function is the one making the recursive call.


- **Indirect Recursion**: This type of recursion involves at least two functions where one function calls another, and that other function calls the first function again. **AKA: Mutual recursion**
	- This creates a cycle of function calls between two or more functions.
	- Indirect recursion is useful in scenarios where a problem can be naturally divided into smaller sub-problems that are solved by different functions.

An example of **indirect recursion** is the **Tower of Hanoi problem**, where one function moves a tower of disks from one peg to another, and another function moves the rest of the disks.

```C++
#include <iostream>
using namespace std;

// Function A calls Function B
void funA(int n) {
    if (n > 0) {
        cout << n << " ";
        funB(n - 1); // Function A calls Function B
    }
}

// Function B calls Function A
void funB(int n) {
    if (n > 1) {
        funA(n / 2); // Function B calls Function A
    }
}

int main() {
    funA(20); // Starting point
    return 0;
}
```

