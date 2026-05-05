To address the issues you are encountering, we can follow these steps:

1. For the first warning, backslashes should not be separated by spaces in C++. To fix this, simply remove the space after each backslash.
    
2. The second warning suggests that you are trying to compare an `int` with a function that returns a string. To fix this, you should check the value returned by the function and compare it with an `int`.
    
3. For the error about `userInput` not being declared, you should define this function.
    
4. For the error about `hashed_message` not being declared, you should declare and define this variable.
    
5. For the error about `askUserEmsg` not being declared, you should define this function.
    
6. Finally, the error about the break statement not being within a loop or switch indicates that there is a mismatch in your loops and switch statements. To fix this, you should carefully check your loop and switch syntax to ensure that they are correctly nested.
    

Make sure to update your question with the updated code as you make progress.

This is what black box told me we should add this to our program tomorrow 



Replace hash message and update generate password 

``` C++ 
std::string scramble(const std::string& str) {
   std::string result = str;
   std::random_shuffle(result.begin(), result.end());
   return result;
}

std::string generate_password(const std::string& message) {
   srand(time(0)); // Initialize random seed

   std::istringstream iss(message);
   std::vector<std::string> words;
   std::string temp;
   while (getline(iss, temp, ' ')) {
       words.push_back(temp);
   }

   std::string acronym;
   for (const auto& word : words) {
       acronym += toupper(word[0]);
   }

   int number = rand() % 900 + 100; // Generate random three-digit number

   return scramble(acronym + std::to_string(number));
}

```

- Some more things to remember as move some functions to public and have them called upon appropriately as the exit message and greeting one 