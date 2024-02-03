```C 
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

enum ConversionType {
    InchesToCentimeters,
    CentimetersToInches,
    OuncesToGrams,
    GramsToOunces,
    MilesToKilometers,
    KilometersToMiles,
    CelsiusToFahrenheit
};

// Function for the user greeting. Nothing in, nothing out.
void userGreeting() {
    printf("\033[1;32m"
           R"(
   .____       _____ __________   ____________   ._._. 
|    |     /  _  \\______   \ /_   \_____  \  | | | 
|    |    /  /_\  \|    |  _/  |   | _(__  <  | | | 
|    |___/    |    \    |   \  |   |/       \  \|\| 
|_______ \____|__  /______  /  |___/______  /  ____ 
        \/       \/       \/              \/   \/\/ 
    )"
           "\033[0m\n");

    printf("Hello and welcome to this program!\n");
    printf("\033[1;32m---------------------------------------------------\033[0m\n");
    printf("\033[1;93mEssentially, this program will allow you to do conversions in multiple fields\033[1;32m\n");
    printf("---------------------------------------------------\n");
}

// Function to get the conversion type and error check it. Returns the converted type.
enum ConversionType getConversionType() {
    char message[10];  // Assuming a short message

    printf("\033[1;32mPlease input the following to use this program for conversion.\033[0m\n");
    printf("\033[1;32m'I' Will convert Inches to Centimeters.\033[0m\n");
    printf("\033[1;32m'C' Will convert Centimeters to Inches.\033[0m\n");
    printf("\033[1;32m'O' Will convert Ounces to Grams.\033[0m\n");
    printf("\033[1;32m'G' Will convert from Grams to Ounces.\033[0m\n");
    printf("\033[1;32m'M' Will convert from Miles to Kilometers.\033[0m\n");
    printf("\033[1;32m'K' Will convert Kilometers to miles.\033[0m\n");
    printf("\033[1;32m'T' Will convert Celsius to Fahrenheit.\033[0m\n");
    printf("Type here: ");

    fgets(message, sizeof(message), stdin);

    // Remove the newline character at the end
    size_t len = strlen(message);
    if (len > 0 && message[len - 1] == '\n') {
        message[len - 1] = '\0';
    }

    if (strcmp(message, "I") == 0 || strcmp(message, "i") == 0) {
        return InchesToCentimeters;
    } else if (strcmp(message, "C") == 0 || strcmp(message, "c") == 0) {
        return CentimetersToInches;
    } else if (strcmp(message, "O") == 0 || strcmp(message, "o") == 0) {
        return OuncesToGrams;
    } else if (strcmp(message, "G") == 0 || strcmp(message, "g") == 0) {
        return GramsToOunces;
    } else if (strcmp(message, "M") == 0 || strcmp(message, "m") == 0) {
        return MilesToKilometers;
    } else if (strcmp(message, "K") == 0 || strcmp(message, "k") == 0) {
        return KilometersToMiles;
    } else if (strcmp(message, "T") == 0 || strcmp(message, "t") == 0) {
        return CelsiusToFahrenheit;
    }

    printf("\033[1;32m---------------------------------------------------\033[0m\n");
    printf("I'm sorry, I did not understand the value. Please type the correct value.\n");
    return -1;
}

// Function to get user input and perform the conversion. Prints the result.
void calculateAndDisplay(enum ConversionType conversionType) {
    double math;

    if (conversionType == CelsiusToFahrenheit) {
        // Implement the Celsius to Fahrenheit conversion here
    } else {
        printf("\033[1;36m---------------------------------------------------\033[0m\n");
        double number;
        printf("\nPlease enter an integer: ");
        scanf("%lf", &number);

        switch (conversionType) {
            case InchesToCentimeters:
                // Implement the Inches to Centimeters conversion here
                math = number * 2.54;
                printf("\n%.2lf\nInches  Equals\n%.2lf\nCentimeters\n", number, math);
                break;
            case CentimetersToInches:
                // Implement the Centimeters to Inches conversion here
                math = number * 0.3937;
                printf("\n%.2lf\nCentimeters  Equals\n%.2lf\nInches\n", number, math);
                break;
            case OuncesToGrams:
                // Implement the Ounces to Grams conversion here
                math = number * 28.34952;
                printf("\n%.2lf\nOunces  Equals\n%.2lf\nGrams\n", number, math);
                break;
            case GramsToOunces:
                // Implement the Grams to Ounces conversion here
                math = number / 28.34952;
                printf("\n%.2lf\nGrams  Equals\n%.2lf\nOunces\n", number, math);
                break;
            case MilesToKilometers:
                // Implement the Miles to Kilometers conversion here
                math = number * 1.609344;
                printf("\n%.2lf\nMiles  Equals\n%.2lf\nKilometers\n", number, math);
                break;
            case KilometersToMiles:
                // Implement the Kilometers to Miles conversion here
                math = number * 0.621371;
                printf("\n%.2lf\nKilometers  Equals\n%.2lf\nMiles\n", number, math);
                break;
            default:
                fprintf(stderr, "\033[1;31mInvalid conversion type\033[0m\n");
                return;
        }

        printf("\033[1;36m---------------------------------------------------\033[0m\n");
    }
}

// Function to ask the user if they want to continue. Returns True or False.
bool askToContinue() {
    printf("\033[1;32m---------------------------------------------------\033[0m\n");

    char answer;
    printf("Would you like to use this program again [Y/N]: ");
    scanf(" %c", &answer);

    if (answer == 'Y' || answer == 'y') {
        return true;
    } else if (answer == 'N' || answer == 'n') {
        printf("\033[1

```

- This is the Lab 13 in C we understand some but we cant do this in just our brain just yet we should work on that level of programming later 