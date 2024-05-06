```C++
#include <vector>
#include <iostream>

template<typename T>
int iterativeSearch(std::vector<T> v, T elem) {
    for (int i = 0; i < v.size(); i++) {
        if (v[i] == elem) {
            return i;
        }
    }
    return -1;
}

int main() {
    // Example usage:
    std::vector<int> intVec = {1, 2, 3, 4, 5};
    std::cout << "Index of 3 in int vector: " << iterativeSearch(intVec, 3) << std::endl;

    std::vector<double> doubleVec = {1.1, 2.2, 3.3, 4.4, 5.5};
    std::cout << "Index of 3.3 in double vector: " << iterativeSearch(doubleVec, 3.3) << std::endl;

    return 0;
}

```


### Changes Made

1. **Template Introduction**: The function now begins with `template<typename T>`. This allows the function to accept different data types specified at compile time.
2. **Parameter and Variable Types**: Both the vector and the element to search for are now of type `T`. This makes the function flexible to work with any data type that supports comparison via `==`.


**Type Safety**: Templates provide a way to write functions that can operate on different data types while maintaining type safety.

**Code Reuse**: Instead of writing multiple versions of the same function for each data type (like one for `int` and one for `double`), you write the function logic once. The compiler then takes care of generating the appropriate versions of the function.