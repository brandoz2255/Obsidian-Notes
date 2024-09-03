Strings as we know now is just blocks of characters or simple text that is contained in either a variable or just simply printed out 

- However the difference is the C programming language requires that each string has a null which is just how we tell C++ that we are done with this line 
- That it ends on the null line so that it doesn't combine two lines 
- We can store strings in an array of character types 

### String literals
- When using the C style of strings in C or C++ we msut put them quotation marks as we know already 
- In C the string supports unicode as well just like character types 
- However in order to do so we must provide the appropiate prefix before doing so for example 
``
```C++
char english[] = "A book holds a house of gold.";
char16_t = chinese[] = u"/u4e66/u4e2d/u81ea/u6709/u9ec4/u91d1/u5c4b";
```

- with this format we can print the string in English and Chinese  so when we use something other than plain text we must the appropriate format specifier
 
### Format specifers 
-  For a narrow string in C++ the format specifier is %s we can incorporate into our code like this -->

``` c++ 
#include <cstdio>

int main() {
	char house[] = "a house of gold.";
	printf("A book holds %s\n", house);


}
```

- However depending on the Unicode or using Unicode in general is really complicated we need to ensure that the correct code is used 
- If we need to use the Unicode as string literals we can use `<cwcchar>` header 
- Also we don't need to have the entire chunk of plain text in one string we can have consecutive multiple strings because the compiler will connect them regardless unless specified not to -->

```C++
#include <cstdio>

int main() {
	char house[] = "a"
	"house" 
	"of" "gold";

	printf("A book holds %s\n", house);


}
```

- So we could also print a string disconnected like this since the compiler will just connect it 

# ASCII 
We finally got what this stands for essentially it is the **American Standard Code for Information Interchange** 

-  Essentially just means that each decimal and hexadecimal has or is assigned to a specific character in the alphabet for a printed character 
- We have delt with this in most of the password hashes in the red team section of our notes especially the password cracking section 

| Value | Symbol | Description           | Decimal | Hexadecimal |
|-------|--------|-----------------------|---------|-------------|
| 0     | NUL    | Null                  | 0       | 00          |
| 1     | SOH    | Start of Heading      | 1       | 01          |
| 2     | STX    | Start of Text         | 2       | 02          |
| 3     | ETX    | End of Text           | 3       | 03          |
| 4     | EOT    | End of Transmission   | 4       | 04          |
| 5     | ENQ    | Enquiry               | 5       | 05          |
| 6     | ACK    | Acknowledge           | 6       | 06          |
| 7     | BEL    | Bell                  | 7       | 07          |
| 8     | BS     | Backspace             | 8       | 08          |
| 9     | HT     | Horizontal Tab        | 9       | 09          |
| 10    | LF     | Line Feed (newline)   | 10      | 0A          |
| 11    | VT     | Vertical Tab          | 11      | 0B          |
| 12    | FF     | Form Feed             | 12      | 0C          |
| 13    | CR     | Carriage Return       | 13      | 0D          |
| 14    | SO     | Shift Out             | 14      | 0E          |
| 15    | SI     | Shift In              | 15      | 0F          |
| 16    | DLE    | Data Link Escape      | 16      | 10          |
| 17    | DC1    | Device Control 1      | 17      | 11          |
| 18    | DC2    | Device Control 2      | 18      | 12          |
| 19    | DC3    | Device Control 3      | 19      | 13          |
| 20    | DC4    | Device Control 4      | 20      | 14          |
| 21    | NAK    | Negative Acknowledge  | 21      | 15          |
| 22    | SYN    | Synchronous Idle      | 22      | 16          |
| 23    | ETB    | End of Transmission Block | 23   | 17          |
| 24    | CAN    | Cancel                | 24      | 18          |
| 25    | EM     | End of Medium         | 25      | 19          |
| 26    | SUB    | Substitute            | 26      | 1A          |
| 27    | ESC    | Escape                | 27      | 1B          |
| 28    | FS     | File Separator        | 28      | 1C          |
| 29    | GS     | Group Separator       | 29      | 1D          |
| 30    | RS     | Record Separator      | 30      | 1E          |
| 31    | US     | Unit Separator        | 31      | 1F          |
| 32    | (Space)| Space                 | 32      | 20          |
| 33    | !      | Exclamation Mark      | 33      | 21          |
| 34    | "      | Quotation Mark        | 34      | 22          |
| 35    | #      | Number Sign           | 35      | 23          |
| ...   | ...    | ...                   | ...     | ...         |
| 127   | DEL    | Delete                | 127     | 7F          |

- This is the table for ACSII 0-31 are the control code characters there is alot of information on the history and why its used today on page 47-50 

```C++
#include <cstdio>

int main() {
    // Print lowercase alphabet
    printf("Lowercase Alphabet: ");
    for (char ch = 'a'; ch <= 'z'; ++ch) {
        printf("%c", ch);
    }
    printf("\n");

    // Print uppercase alphabet
    printf("Uppercase Alphabet: ");
    for (char ch = 'A'; ch <= 'Z'; ++ch) {
        printf("%c", ch);
    }
    printf("\n");

    return 0;
}

```

- This how we would print out two strings using the ASCII table of the alphabet one in lowercase and the other in upper without using variables using variables is in **page 48-49** is much more complicated 

[[User defined types]]



