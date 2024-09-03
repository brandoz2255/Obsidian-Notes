A forward linked list is a data strucutre t hat allows for mulptiple sequences to be linked together using pointers 

-  This allows for a sequence type of data as in each node that is contained in a class or in the code can be linked to together and then printing out each term 

```C++
#include <iostream>
using namespace std;

class Node {
public:
    int data;
    Node* next;
};

class LinkedList {
public:
    Node* head;

    LinkedList() {
        head = NULL;
    }

    void addElement(int value) {
        Node* newNode = new Node();
        newNode->data = value;
        newNode->next = NULL;

        if(head == NULL) {
            head = newNode;
        } else {
            Node* temp = head;
            while(temp->next != NULL) {
                temp = temp->next;
            }
            temp->next = newNode;
        }
    }

    void display() {
        if(head == NULL) {
            cout << "Linked List is empty." << endl;
        } else {
            Node* temp = head;
            while(temp != NULL) {
                cout << temp->data << " ";
                temp = temp->next;
            }
            cout << endl;
        }
    }
};

int main() {
    LinkedList list;
    list.addElement(1);
    list.addElement(2);
    list.addElement(3);
    list.display();
    return 0;
}
```

## This pointers
- This pinters are generally used with a method name that collides with a variable name this can be easily avoided to use but the syntax is `this ->`  
- its a pointer method that helps with calling upon a function within a class adding the this nect to pointer adds for esaier readablity simliar to the init method just ease of read 

# Const
A const in C/C++ is a way that compiler wont mess with what you have the const attacched to. 

- Essentially works as a lock in which that doesn't allow future code to modfiy what is attached to the const its a security feature
- Stands for `constant` and means as in "**I promise not to modify**"

### const argument 
-  this works the same as the const however its just what is called when it is uesd for a function does not allow modifications to the function
```C++
class MyClass {
public:
    int x;

    void printX() const {
        cout << x << endl;
    }
};
```

## Const method
- The same thing but on the method level within a class 
- Generally speaking we can add a const to alot of statements in C++

## Member initializers
- It how we can intialize members of a class into a constructor doing this i the name of the member followed by the braces `{}` 

```C++
class MyClass {
public:
    int x;
    string name;

    // This is a constructor with a member initializer list
    MyClass(int a, string b) : x(a), name(b) {
    }
};
```

# Auto type deduciton baby
- Just as we explained before with the member initiliazers adding t he auto argument to it allows C++ to just do it on its own meaning we wont need the braces 

```C++
#include <iostream>
#include <vector>

int main() {
    std::vector<int> vec = {1, 2, 3, 4, 5};

    // auto type deduction
    for (auto elem : vec) {
        std::cout << elem << " ";
    }

    return 0;
}
```

- We could also use auto with reference types 

```C++
#include <iostream>
#include <vector>

int main() {
    std::vector<int> vec = {1, 2, 3, 4, 5};

    // auto type deduction with reference type
    for (auto& elem : vec) {
        std::cout << elem << " ";
    }

    return 0;
}
```


