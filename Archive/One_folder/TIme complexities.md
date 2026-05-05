# Important Searching Algorithms

- **Binary Search**: Binary search is a highly efficient algorithm used for finding an element's position in a sorted array. It works by repeatedly dividing the search interval in half. 
	- If the value of the search key is less than the item in the middle of the interval, the algorithm continues the search on the lower half. 
	- Otherwise, it continues on the upper half. This process continues until the value is found or the interval is empty.
	- If the target is less than the middle element, the search continues in the left half of the list; if it's greater, the search continues in the right half. This process is repeated until the target element is found or the list is exhausted [1](https://www.studysmarter.co.uk/explanations/computer-science/algorithms-in-computer-science/binary-search/)[1](https://www.studysmarter.co.uk/explanations/computer-science/algorithms-in-computer-science/binary-search/).

```C++
#include <iostream>
using namespace std;

int binarySearch(int array[], int low, int high, int number_to_search_for) {
    while (low <= high) {
        int mid = low + (high - low) / 2;

        if (number_to_search_for == array[mid]) {
            return mid; // Element found
        }

        if (number_to_search_for > array[mid]) {
            low = mid + 1; // Search the right half
        } else {
            high = mid - 1; // Search the left half
        }
    }

    return -1; // Element not found
}

int main(void) {
    int arrayOfNums[] = {2, 4, 7, 9, 10, 13, 20};
    int n = sizeof(arrayOfNums) / sizeof(arrayOfNums[0]);
    int result = binarySearch(arrayOfNums, 0, n - 1, 13);

    if (result == -1) {
        cout << "Element doesn't exist in the array";
    } else {
        cout << "The index of the element is " << result;
    }

    return 0;
}

```

- `binarySearch` that takes an array `array[]`, the indices `low` and `high` defining the search interval within the array, and the `number_to_search_for` which is the value you're looking for.
- calculates the middle index `mid` and compares the value at this index with the search key
- If the search key is greater, it narrows the search to the right half of the array by setting `low` to `mid + 1`. 
- If the search key is less, it narrows the search to the left half by setting `high` to `mid - 1`. This process repeats until the element is found or the search interval is empty, in which case it returns -1.
- The `main` function demonstrates how to use the `binarySearch` function. It defines an array `arrayOfNums[]` and a number to search for `13`.
- It then calls `binarySearch` with these parameters and prints the result. If the element is found, it prints the index of the element; otherwise, it prints a message indicating that the element was not found [3](https://www.freecodecamp.org/news/binary-search-in-c-algorithm-example/).

Important for binary search:
```C++

        if (number_to_search_for > array[mid]) {
            low = mid + 1; // Search the right half
        } else {
            high = mid - 1; // Search the left half
        }
    }

```


- **Linear Search**: Linear search is a simple searching algorithm that checks each element in a list sequentially until the desired element is found or the end of the list is reached.
	- It is not the most efficient search algorithm for large datasets but is straightforward to implement and understand.
	- However, for larger datasets or when performance is a critical factor, more efficient search algorithms like binary search or hash tables should be considered [4](https://www.codingdrills.com/tutorial/introduction-to-searching-algorithms/linear-search-cpp)[5](https://dotnettutorials.net/lesson/linear-search-in-cpp/).
```C++
#include <iostream>
using namespace std;

int linearSearch(int arr[], int n, int key) {
    for(int i = 0; i < n; i++) {
        if(arr[i] == key) {
            return i; // return the index of the found element
        }
    }
    return -1; // return -1 if the element is not found
}

int main() {
    int arr[] = {5, 8, 2, 10, 3};
    int n = sizeof(arr) / sizeof(arr[0]);
    int key = 10;

    int result = linearSearch(arr, n, key);
    if (result == -1) {
        cout << "Element not found in the array.";
    } else {
        cout << "Element found at index " << result << ".";
    }
    return 0;
}

```
- v test 


# Time Complexity 
#Big_O_notation 
- **Time complexity Big O notation**:  Time complexity in computer science refers to the computational complexity that describes the amount of computational time taken by an algorithm to run, as a function of the size of the input to the program.
	- It is a measure of the time taken by an algorithm to run, as the input size grows.
	- **Big O notation**: is a mathematical notation used to describe the limiting behavior of a function when the argument tends towards a particular value or infinity.
		- the time complexity of linear search is *O(n)*, where *n* is the number of elements in the list. This
		- time complexity of binary search is *O(log n)*, indicating that the algorithm divides the list in half with each step, significantly reducing the number of elements it needs to check.


## Recursion 
- **recursion**: Recursion in computer science is a technique where a function calls itself directly or indirectly until a base condition is met.
	-  Useful for breaking down problems into smaller sub problems to solve the issue 
	- In C++ The function must have a base case to prevent infinite recursion and ensure that the recursion eventually stops.
	- The **base case** is a condition that, when met, stops the recursive calls and returns a value.
```C++
#include <iostream>
using namespace std;

// Recursive function to calculate the sum of first N natural numbers
int nSum(int n) {
    // Base case: stop the recursion when n is 0
    if (n == 0) {
        return 0;
    }

    // Recursive case: add n to the sum of the first (n-1) natural numbers
    return n + nSum(n - 1);
}

int main() {
    int n = 5; // Number of natural numbers to sum

    // Call the recursive function
    int sum = nSum(n);

    cout << "Sum = " << sum;
    return 0;
}
```
- function `nSum` is defined to calculate the sum of the first N natural numbers
- The **base case** is when `n` is 0, at which point the function returns 0.
- The recursive case is where the function calls itself with `n - 1`, adding `n` to the result of this recursive call.
- This process continues until `n` reaches 0, at which point the recursion stops, and the sum of the first N natural numbers is returned.

Example of Recursion 
```C++
#include <iostream>
using namespace std;

// Recursive function to calculate the nth Fibonacci number
int fib(int n) {
    if (n <= 1) {
        return n; // Base case: F0 = 0 and F1 = 1
    }
    return fib(n - 1) + fib(n - 2); // Recursive case: Fn = Fn-1 + Fn-2
}

int main() {
    int n = 9; // Example: Calculate the 9th Fibonacci number
    cout << "The " << n << "th Fibonacci number is: " << fib(n) << endl;
    return 0;
}

```

[[recursion  more info]] : important Info !! 

[[Binary Search and Recursion and Vectors]] : as well as arrays ;) 


- recursion and relationship to something else
- "Recursively thinking":
- Recurisve operation to build a triangle 
- recursive functions 