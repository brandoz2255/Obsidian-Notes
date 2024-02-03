Thread safe

```C++
#include <iostream>
#include <thread>
#include <mutex>

// Shared counter variable
int counter = 0;

// Mutex for synchronization
std::mutex counterMutex;

// Function to increment the counter in a thread-safe manner
void incrementCounter(int iterations) {
    for (int i = 0; i < iterations; ++i) {
        // Lock the mutex before incrementing the counter
        std::lock_guard<std::mutex> lock(counterMutex);
        ++counter;
        // Unlock the mutex after the increment operation is done
    }
}

int main() {
    const int iterationsPerThread = 100000;

    // Create two threads to increment the counter concurrently
    std::thread thread1(incrementCounter, iterationsPerThread);
    std::thread thread2(incrementCounter, iterationsPerThread);

    // Wait for threads to finish
    thread1.join();
    thread2.join();

    // Print the final value of the counter
    std::cout << "Final counter value (thread-safe): " << counter << std::endl;

    return 0;
}

```

Not thread safe 

```C++
#include <iostream>
#include <thread>

// Shared counter variable
int counter = 0;

// Function to increment the counter
void incrementCounter(int iterations) {
    for (int i = 0; i < iterations; ++i) {
        // Not thread-safe increment operation
        ++counter;
    }
}

int main() {
    const int iterationsPerThread = 100000;

    // Create two threads to increment the counter concurrently
    std::thread thread1(incrementCounter, iterationsPerThread);
    std::thread thread2(incrementCounter, iterationsPerThread);

    // Wait for threads to finish
    thread1.join();
    thread2.join();

    // Print the final value of the counter
    std::cout << "Final counter value (not thread-safe): " << counter << std::endl;

    return 0;
}

```

- A thread is a independent sequence of instructions that is made for parallel execution 

## Dynamic Storage 
This is storage of an object that is manually manipulated with `new` and `exit`operators using them as pointers to update the storage of an object. 


```C++
#include <iostream>

int main() {
    // Allocate memory for an integer dynamically
    int* dynamicInt = new int;

    // Assign a value to the dynamically allocated integer
    *dynamicInt = 42;

    // Print the value
    std::cout << "Dynamically allocated integer: " << *dynamicInt << std::endl;

    // Deallocate the memory to prevent memory leaks
    delete dynamicInt;

    return 0; // prints 42 as Dynamically allocated integer: 
}

```

## Dynamic Arrays 
Similar to Dynamic storage uses `new` and `delete` pointers to update arrays however the new needs to be specified in `brackets` and the change occurs during runtime. 

```C++
#include <iostream>

int main() {
    // Dynamically allocate an array of integers
    int size = 5;
    int* dynamicArray = new int[size];

    // Initialize the elements of the dynamic array
    for (int i = 0; i < size; ++i) {
        dynamicArray[i] = i * 10;
    }

    // Print the elements of the dynamic array
    std::cout << "Dynamic Array: ";
    for (int i = 0; i < size; ++i) {
        std::cout << dynamicArray[i] << " ";
    }
    std::cout << std::endl;

    // Deallocate the memory used by the dynamic array
    delete[] dynamicArray;

    return 0;
}

```


## tracing Object life cycle 

```C++
#include <iostream>

class TrackedObject {
public:
    // Constructor (Object Created)
    TrackedObject(int id) : objectId(id) {
        std::cout << "Object " << objectId << " created." << std::endl;
    }

    // Destructor (Object Destroyed)
    ~TrackedObject() {
        std::cout << "Object " << objectId << " destroyed." << std::endl;
    }

    // Member function to simulate object behavior
    void performTask() {
        std::cout << "Object " << objectId << " performing task." << std::endl;
    }

private:
    int objectId;
};

int main() {
    // Stage 1: Object Creation
    TrackedObject obj1(1);

    // Stage 2: Object Behavior
    obj1.performTask();

    {
        // Stage 3: Object Creation (Local Scope)
        TrackedObject obj2(2);

        // Stage 4: Object Behavior (Local Scope)
        obj2.performTask();
    } // Stage 5: Object Destruction (End of Local Scope)

    // Stage 6: Object Destruction (End of Main Function)
    return 0;
}
```


- Memory leaks occur when you don't properly deallocate the memory failuer to do so will result in a memory leak and will cause performances issues 