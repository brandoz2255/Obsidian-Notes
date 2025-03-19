```C++
#include <iostream>
#include <iomanip>
#include <limits>

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
    std::cout << "\033[1;32m"
              << R"(
   .____       _____ __________   ____________   ._._. 
|    |     /  _  \\______   \ /_   \_____  \  | | | 
|    |    /  /_\  \|    |  _/  |   | _(__  <  | | | 
|    |___/    |    \    |   \  |   |/       \  \|\| 
|_______ \____|__  /______  /  |___/______  /  ____ 
        \/       \/       \/              \/   \/\/ 
    )" << "\033[0m" << std::endl;

    std::cout << "Hello and welcome to this program!" << std::endl;
    std::cout << "\033[1;32m---------------------------------------------------\033[0m" << std::endl;
    std::cout << "\033[1;93mEssentially, this program will allow you to do conversions in multiple fields\033[1;32m"
              << std::endl;
    std::cout << "---------------------------------------------------" << std::endl;
}

// Function to get the conversion type and error check it. Returns the converted type.
ConversionType getConversionType() {
    std::string message;
    std::cout << "\033[1;32mPlease input the following to use this program for conversion.\033[0m" << std::endl;
    std::cout << "\033[1;32m'I' Will convert Inches to Centimeters.\033[0m" << std::endl;
    std::cout << "\033[1;32m'C' Will convert Centimeters to Inches.\033[0m" << std::endl;
    std::cout << "\033[1;32m'O' Will convert Ounces to Grams.\033[0m" << std::endl;
    std::cout << "\033[1;32m'G' Will convert from Grams to Ounces.\033[0m" << std::endl;
    std::cout << "\033[1;32m'M' Will convert from Miles to Kilometers.\033[0m" << std::endl;
    std::cout << "\033[1;32m'K' Will convert Kilometers to miles.\033[0m" << std::endl;
    std::cout << "\033[1;32m'T' Will convert Celsius to Fahrenheit.\033[0m" << std::endl;
    std::cout << "Type here: ";
    std::cin >> message;

    if (message == "I" || message == "i") {
        return InchesToCentimeters;
    } else if (message == "C" || message == "c") {
        return CentimetersToInches;
    } else if (message == "O" || message == "o") {
        return OuncesToGrams;
    } else if (message == "G" || message == "g") {
        return GramsToOunces;
    } else if (message == "M" || message == "m") {
        return MilesToKilometers;
    } else if (message == "K" || message == "k") {
        return KilometersToMiles;
    } else if (message == "T" || message == "t") {
        return CelsiusToFahrenheit;
    }

    std::cout << "\033[1;32m---------------------------------------------------\033[0m" << std::endl;
    std::cout << "I'm sorry, I did not understand the value. Please type the correct value." << std::endl;
    return static_cast<ConversionType>(-1);
}

// Function to get user input and perform the conversion. Prints the result.
void calculateAndDisplay(ConversionType conversionType) {
    if (conversionType == CelsiusToFahrenheit) {
        // Implement the Celsius to Fahrenheit conversion here
    } else {
        std::cout << "\033[1;36m---------------------------------------------------\033[0m" << std::endl;
        double number;
        std::cout << "\nPlease enter an integer: ";
        std::cin >> number;

        switch (conversionType) {
            case InchesToCentimeters:
                // Implement the Inches to Centimeters conversion here
                break;
            case CentimetersToInches:
                // Implement the Centimeters to Inches conversion here
                break;
            case OuncesToGrams:
                // Implement the Ounces to Grams conversion here
                break;
            case GramsToOunces:
                // Implement the Grams to Ounces conversion here
                break;
            case MilesToKilometers:
                // Implement the Miles to Kilometers conversion here
                break;
            case KilometersToMiles:
                // Implement the Kilometers to Miles conversion here
                break;
            default:
                std::cerr << "\033[1;31mInvalid conversion type\033[0m" << std::endl;
                return;
        }

        std::cout << "\033[1;36m---------------------------------------------------\033[0m" << std::endl;
    }
}

// Function to ask the user if they want to continue. Returns True or False.
bool askToContinue() {
    std::cout << "\033[1;32m---------------------------------------------------\033[0m" << std::endl;

    char answer;
    std::cout << "Would you like to use this program again [Y/N]: ";
    std::cin >> answer;

    if (answer == 'Y' || answer == 'y') {
        return true;
    } else if (answer == 'N' || answer == 'n') {
        std::cout << "\033[1;32m-----------------------OK--------------------------\033[0m" << std::endl;
        std::cout << "\033[1;32m---------------------------------------------------\033[0m" << std::endl;
        return false;
    } else {
        std::cout << "\033[1;32m---------------------------------------------------\033[0m" << std::endl;
        return false;
    }
}

// Function for the user exit option. Nothing in, nothing out.
void exitMessage() {
    std::cout << "\033[1;34m---------------------------------------------------\033[0m" << std::endl;
    std::cout << "\033[1;34m---------thanks for using my program!!-----------\033[0m" << std::endl;
    std::cout << "\033[1;34m---------------------------------------------------\033[0m" << std::endl;
}

// Main section of the code
int main() {
    // Main program variable
    bool runMainProgram = true;

    // Main program loop
    while (runMainProgram) {
        // Greet the user
        userGreeting();

        // Get conversion type
        ConversionType conversionTypeMain = getConversionType();
        if (conversionTypeMain != static_cast<ConversionType>(-1)) {
            // Calculate and display result
            calculateAndDisplay(conversionTypeMain);

            // Ask user to continue
            runMainProgram = askToContinue();
        }
    }

    // Exit message
    exitMessage();

    return 0;
}

```

- There is an issue with the given wee must fix it later but what the fuck C++ has me what!!
- Ok the issue with the code is that there is no math operation iun this code we must add it ourselves which we can of course learn how to do 
- Lets do this 
- If we make the statement in the beginning of the code such as using namespace std we dont have to mention or use std:: at every cout or other statement to print something or command something C++
- For example 

```C++ 
#include <iostream>
#include <iomanip>
#include <limits>

using namespace std;

enum ConversionType {
    InchesToCentimeters,
    CentimetersToInches,
    OuncesToGrams,
    GramsToOunces,
    MilesToKilometers,
    KilometersToMiles,
    CelsiusToFahrenheit
};

void userGreeting() {
    cout << "\033[1;32m"
         << R"(
   .____       _____ __________   ____________   ._._. 
|    |     /  _  \\______   \ /_   \_____  \  | | | 
|    |    /  /_\  \|    |  _/  |   | _(__  <  | | | 
|    |___/    |    \    |   \  |   |/       \  \|\| 
|_______ \____|__  /______  /  |___/______  /  ____ 
        \/       \/       \/              \/   \/\/ 
    )" << "\033[0m" << endl;

    cout << "Hello and welcome to this program!" << endl;
    cout << "\033[1;32m---------------------------------------------------\033[0m" << endl;
    cout << "\033[1;93mEssentially, this program will allow you to do conversions in multiple fields\033[1;32m"
         << endl;
    cout << "---------------------------------------------------" << endl;
}

ConversionType getConversionType() {
    string message;
    cout << "\033[1;32mPlease input the following to use this program for conversion.\033[0m" << endl;
    cout << "\033[1;32m'I' Will convert Inches to Centimeters.\033[0m" << endl;
    cout << "\033[1;32m'C' Will convert Centimeters to Inches.\033[0m" << endl;
    cout << "\033[1;32m'O' Will convert Ounces to Grams.\033[0m" << endl;
    cout << "\033[1;32m'G' Will convert from Grams to Ounces.\033[0m" << endl;
    cout << "\033[1;32m'M' Will convert from Miles to Kilometers.\033[0m" << endl;
    cout << "\033[1;32m'K' Will convert Kilometers to miles.\033[0m" << endl;
    cout << "\033[1;32m'T' Will convert Celsius to Fahrenheit.\033[0m" << endl;
    cout << "Type here: ";
    cin >> message;

    if (message == "I" || message == "i") {
        return InchesToCentimeters;
    } else if (message == "C" || message == "c") {
        return CentimetersToInches;
    } else if (message == "O" || message == "o") {
        return OuncesToGrams;
    } else if (message == "G" || message == "g") {
        return GramsToOunces;
    } else if (message == "M" || message == "m") {
        return MilesToKilometers;
    } else if (message == "K" || message == "k") {
        return KilometersToMiles;
    } else if (message == "T" || message == "t") {
        return CelsiusToFahrenheit;
    }

    cout << "\033[1;32m---------------------------------------------------\033[0m" << endl;
    cout << "I'm sorry, I did not understand the value. Please type the correct value." << endl;
    return static_cast<ConversionType>(-1);
}

void calculateAndDisplay(ConversionType conversionType) {
    double math;

    if (conversionType == CelsiusToFahrenheit) {
        // Implement the Celsius to Fahrenheit conversion here
    } else {
        cout << "\033[1;36m---------------------------------------------------\033[0m" << endl;
        double number;
        cout << "\nPlease enter an integer: ";
        cin >> number;

        switch (conversionType) {
            case InchesToCentimeters:
                math = number * 2.54;
                cout << "\n" << number << "\nInches  Equals\n" << math << "\nCentimeters" << endl;
                break;
            case CentimetersToInches:
                math = number * 0.3937;
                cout << "\n" << number << "\nCentimeters  Equals\n" << math << "\nInches" << endl;
                break;
            case OuncesToGrams:
                math = number  * 28.34952;
                cout << "\n" << number << "\nOunces  Equals\n" << math << "\nGrams" << endl;
                break;
            case GramsToOunces:
                math = number / 28.34952;
                cout << "\n" << number << "\nGrams  Equals\n" << math << "\nOunces" << endl;
                break;
            case MilesToKilometers:
                math = number * 1.609344;
                cout << "\n" << number << "\nMiles  Equals\n" << math << "\nKilometers" << endl;
                break;
            case KilometersToMiles:
                math = number * 0.

```