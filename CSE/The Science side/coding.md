```C 
fgets(message, sizeof(message), stdin); // Read a line of input from the standard input (keyboard) and store it in the 'message' variable.

// Remove the newline character at the end
size_t len = strlen(message); // Determine the length of the string in 'message'.
if (len > 0 && message[len - 1] == '\n') { // Check if the last character of the string is a newline character.
    message[len - 1] = '\0'; // If the last character is a newline, replace it with the null terminator to truncate the string.
}

```
