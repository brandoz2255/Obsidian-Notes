Write a program that inserts nodes into a forward linked list and allows the user to modify the values of these nodes. Additionally, implement a function to reverse the order of the nodes in the linked list. The program should have a `main` function, a `Node` class, and a `LinkedList` class.

Skeleton code

```C++
#include <iostream>

class Node {
public:
    int data;
    Node* next;

    Node(int data) : data(data), next(nullptr) {}
};

class LinkedList {
public:
    Node* head;

    LinkedList() : head(nullptr) {}

    void insert(int data);
    void modify(int old_value, int new_value) const;
    void reverse() const;
    void print() const;
};

int main() {
    LinkedList list;

    // Insert nodes into the linked list
    list.insert(1);
    list.insert(2);
    list.insert(3);

    // Print the linked list
    std::cout << "Original list: ";
    list.print();

    // Modify the value of a node
    list.modify(2, 4);

    // Print the linked list
    std::cout << "Modified list: ";
    list.print();

    // Reverse the linked list
    list.reverse();

    // Print the reversed linked list
    std::cout << "Reversed list: ";
    list.print();

    return 0;
}
```