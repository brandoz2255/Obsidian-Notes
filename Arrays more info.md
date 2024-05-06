### Fleet notes

- [x] Multidimensional array ✅ 2024-05-02
	- [x] How to declare ✅ 2024-05-02
	- [x] 2D , 3D ✅ 2024-05-02
	- [x] indices ✅ 2024-05-02
	- [x] what can we do with 3D arrays ✅ 2024-05-02
- [x] Linear-izing multidimensional data ✅ 2024-05-02
	- [x] what does it mean ✅ 2024-05-02
	- [x] How does it work ✅ 2024-05-02
- [x] Passing multidimensional Arrays ✅ 2024-05-02
	- [x] Formal Parameter ✅ 2024-05-02
	- [x] Actual Parameter ✅ 2024-05-02
	- [x] Empty bracket single dimension! ✅ 2024-05-02
	- [x] Formula for multidimensional arrays? ✅ 2024-05-02
- [ ] Linearization (finding t he addresses) in 2D Arrays 
	- [ ] Formulas? 
- [ ] Memory allocation bits and bytes remember them mf! 


Indices = Index (Indices are just plural)
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

[[Baking a cake Anology]]