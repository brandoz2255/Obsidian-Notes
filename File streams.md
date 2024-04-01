- File streams

- ofstream:  This is used for both reading and writing to a file allowing for the program to write data onto a file. creates a file if one does not already exist   used to write data onto a file if it doenst exist it will create one also edits an already existing one

- fstream: used to write data onto a file if it doenst exist it will create one also edits an already existing one

- ifstream: used to simply just read data from the files allows the program to read files


```C++
#include <iostream>
#include <fstream>
#include <string>

int main() {
    std::ofstream outFile("example.txt"); // Open a file for writing
    if (!outFile) {
        std::cerr << "Error opening file for writing." << std::endl;
        return 1;
    }

    outFile << "Hello, World!" << std::endl; // Write to the file
    outFile.close(); // Close the file

    std::ifstream inFile("example.txt"); // Open the same file for reading
    if (!inFile) {
        std::cerr << "Error opening file for reading." << std::endl;
        return 1;
    }

    std::string line;
    while (std::getline(inFile, line)) { // Read from the file
        std::cout << line << std::endl;
    }

    inFile.close(); // Close the file
    return 0;
}
```