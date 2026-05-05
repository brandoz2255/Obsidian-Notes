Given an array of integers `nums` and an integer `target`, return _indices of the two numbers such that they add up to `target`_.

You may assume that each input would have **_exactly_ one solution**, and you may not use the _same_ element twice.

You can return the answer in any order.


#### Solution 

```C++
class Solution {

public:

vector<int> twoSum(vector<int>& nums, int target) {

unordered_map<int, int> num_to_index;

  

for (int i = 0; i < nums.size(); ++i) {

int complement = target - nums[i];

if (num_to_index.find(complement) != num_to_index.end()) {

return {num_to_index[complement], i};

}

num_to_index[nums[i]] = i;

}

return {};

}

};
```



#### Documentation 

1. **`vector<int> twoSum(vector<int>& nums, int target)`**:
    
    - **`vector<int>& nums`**: This is a reference to a vector of integers, representing the list of numbers.
    - **`int target`**: This is the target sum we are trying to find by adding two numbers from the list.
2. **`unordered_map<int, int> num_to_index;`**:
    
    - **`unordered_map<int, int>`**: This is a hash map (or dictionary) that maps an integer (the number from the list) to its index.
    - **`num_to_index`**: This is the name of our hash map.
3. **`for (int i = 0; i < nums.size(); ++i)`**:
    
    - **`for` loop**: This loop iterates over each element in the `nums` vector.
    - **`i < nums.size()`**: This condition ensures the loop runs from 0 to the last index of the `nums` vector. `nums.size()` returns the number of elements in the `nums` vector.
        - **`nums.size()`**: This function returns the size of the `nums` vector, i.e., the number of elements it contains. It's useful to avoid hardcoding the length of the array and allows

the loop to adjust automatically if the size of the `nums` vector changes.

4. **`int complement = target - nums[i];`**:
    
    - **`complement`**: This variable stores the value that, when added to `nums[i]`, equals the target. Essentially, `complement` is the number we are looking for in the hash map to form the desired sum with `nums[i]`.
5. **`if (num_to_index.find(complement) != num_to_index.end())`**:
    
    - **`num_to_index.find(complement)`**: This checks if `complement` exists in the hash map.
    - **`!= num_to_index.end()`**: If the `complement` is found in the hash map, the iterator returned by `find` is not equal to `end`, meaning the `complement` exists in the map.
6. **`return {num_to_index[complement], i};`**:
    
    - **Return Statement**: If the `complement` is found in the map, return the indices of `complement` and the current number `nums[i]` as a pair of integers. The `num_to_index[complement]` gives the index of the `complement`, and `i` is the current index.
7. **`num_to_index[nums[i]] = i;`**:
    
    - **Add to Hash Map**: If the `complement` is not found, add the current number `nums[i]` and its index `i` to the hash map.
8. **`return {};`**:
    
    - **Default Return**: This return statement is included as a safety measure, but the problem guarantees that there will always be a solution, so this line theoretically never executes.

### Tips to Remember:

- **Understanding `nums.size()`**: This function is crucial because it gives the number of elements in the vector, allowing the loop to iterate over all elements. It's different from arrays where you might use `sizeof` or a constant value. In C++, `vector.size()` is the standard way to get the number of elements in a vector.
- **Hash Map Usage**: Using a hash map allows for efficient lookup of the complement, making the solution run in linear time O(n)O(n)O(n).
- **Complement Calculation**: Calculating the `complement` helps you determine what number you need to find in the hash map to complete the pair.