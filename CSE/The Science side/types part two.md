# Floating types
These are often most ascociated with the idea of real numbers in which a number that is not whole such .2 or 1/4. However they are called floating numbers since they are only an approximation of a real number not the actual thing. 
	-It is not possible for a computer to see or visualize a real number that is why we deal with approximations since numbers are infinite and the computers hardware can have as much as its designed
	- This is why C++ has *three different* float types to handle this problem 
	- In C++ it has this rule called *precision* since the computer only has a finite amount of memory the precision off the float integer helps with its accuracy in representing the real number

- **Float** = single precision
- **double** = double precision
- **long double** = extended precision 

These are the three different float types in C++ however the thing to keep in mind is our computers capabilities if we don't know it exactly how much Float it can handle then for safety we should use double. 

# Floating point literal
The Floating literal are double by default as mentioned before for the reason however we can change it if we want to using suffixes such as f or F and for extended l or L. 

```C++
float a = 0.1F;
double b = 0.2;
long double c = 0.3L;
```

we can also use scientiffic notation in literals as well

```C++
double plancks_constant = 6.62607004e-34;
```

Remember no spaces are permitted between the significant base in this case **e** and the suffix in this case **34**.  

## Format specifiers 
Th e format specifier `%f `displays  a float with the decimal digits where the `%e `statement displays the same number but in scientific notation. Where the `%g` in this case lets the `printf` statement decide for you. In most cases as as rule of thumb its safe to say let C++ decide for you. 

- if we are using a double float we woould use the suffix l followed by the specifer 
- In the long double we would use L 
- The suffixes would be **%lg** or **%lf**or **%le** in the long double it would be the same but using L 

```C++
#include <cstdio>

int main() {

	double an = 6.0221409e23;

	printf("Avogadro's Number: %le %lf %;g\n", an, an, an);

	float hp = 9.75;

	printf("Hogwarts platform: %e %f %g\n", hp, hp, hp);

}
```

- The first line of the code runs a program called `an` and uses specifiers to print it out in a specific manner` %le `gives out the scientific notation and `%lf` gives out the decimal form and `%g `just lets C++ choose for us when we run the code we can see this happen to both variables of `hp` and `an` 

**Note**: in practice we can omit the  1 prefix on the format specifier for double sicen `printf` is in double naturally. 


# Character types
The character types in C++ are jsut types that store human readable data  such a character like in this situation. there are six different character types -->

- **char** = default type 1 byte --> ex: ASCII
- **char16_t** = used for 2 bytes --> ex UTF-16
- **char32_t** used for 4 bytes --> ex: UTF-32
- **signed char** = same as char but signed 
- **unsigned char** = same as char but unsigned
- **wchar_t** = large enough to fit the largest character --> ex: Unicode

 The default character types are called **narrow characters** where the special character types such as the ones with the `_t` statement are called **wide characters** due to their size requirements

### Character Literals
The character literals are always a single constant character with single qutations marks `''` that surround all cahracters if it is any other char type we must use suffixes 

- **L** for `wchar_t`
- **u** for `char16_t `
- **U** for `char32_t`

For example their use would be something like this `L'J'` declares a `wchar_t` for the character J. 

### Escape sequences 
An escape seqeunce is how C++ lets you get out buggs in case you use a character that already comes in the C++ language pack such as for example the quotations marks 
- if we were to put this in our code it would confuse C++ compiler so that is why we use the escape sequences here is a chart that would be helpfull 

| Escape Sequence | Description                       |
|-----------------|-----------------------------------|
| `\'`            | Single quote                      |
| `\"`            | Double quote                      |
| `\?`            | Question mark                     |
| `\\`            | Backslash                         |
| `\a`            | Audible alert (bell)              |
| `\b`            | Backspace                         |
| `\f`            | Form feed                         |
| `\n`            | Newline                           |
| `\r`            | Carriage return                   |
| `\t`            | Horizontal tab                    |
| `\v`            | Vertical tab                      |
| `\0`            | Null character                    |
| `\xhh`          | Hexadecimal escape sequence       |
| `\ooo`          | Octal escape sequence             |
| `\uhhhh`        | Unicode character (16-bit)        |
| `\Uhhhhhhhh`    | Unicode character (32-bit)        |

Thats a list of all possible escape characters in the C++ library however for unicodes we might need find some online for specific unicodes we use. 

Here is an example: 

```C++
#include <cstdio>

int main() {
    printf("This is a newline\n");
    printf("This is a tab\tcharacter\n");
    printf("This is a backslash: \\ and a double quote: \"\n");
    printf("This is a bell\a(alert)\n");

    // Unicode characters
    printf("Greek letter alpha: \u03B1\n");
    printf("Snowman: \u2603\n");

    return 0;
}

```

- One thing that has not been mentioned in the book or the videos but has been brought to my attention is commenting in C++ uses the // 

### Format specifier 
For specifing something with  characters in C++ is `%c `for just the general `char` and `%lc` for `wchar_t`\

-  For example 
```C++
#include <cstdio>

int main() {
    // Using char specifier
    char charVar = 'A';
    printf("Using char specifier: %c\n", charVar);

    // Using wchar_t specifier
    wchar_t wcharVar = L'Ω'; // Using a Unicode character for wchar_t
    wprintf(L"Using wchar_t specifier: %lc\n", wcharVar);

    return 0;
}

```

With that using the specifier `%lc` we can print the contents in `wcharVar` and the specifier in `charVar` with the `%c`.  We also used the character literal argument `L` to tell C++ its a `wchar_t`. 

[[Class Types.PT3]]