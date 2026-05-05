- A void statement in C++ is basically just what it means but to an extent in short its just a statement that contains lines of code to do an action but doesn't return any value such as true or false

- EX: In other words think of the Function in a C++ program as the cheif and the code within the function all the cheifs instructions to make the dish and then it sends it out the customer(the user to see). A void on the other hand is the exact same thing but it doesn't return any value such as it made the dish but doesn't give it to the customer

here is our code for example

``` C++
#include <iostream>
#include <iomanip>

class TemperatureConverter {
public:
    void userGreeting() {
        std::cout << "Hello welcome!\n";
        std::cout << "\nThis program will convert degrees Celsius to degrees Fahrenheit.\n";
    }

    bool askAgain() {
        while (true) {
            std::cout << "\nWould you like to run this program again:\n";
            std::cout << "------------------------------------------\n";
            char userInput;
            std::cout << "If so, please enter either [y/n]: ";
            std::cin >> userInput;

            if (userInput == 'y' || userInput == 'Y') {
                return true;
            } else if (userInput == 'n' || userInput == 'N') {
                std::cout << "----------------------------------------\n";
                std::cout << "Ok then, have a nice day!\n";
                return false;
            } else {
                std::cout << "-----------------------------------------\n";
                std::cout << "Did not compute, please try again!\n";
            }
        }
    }

    void convertAndDisplay() {
        // Get user input and assign to a variable (float data type)
        double celsius;
        std::cout << "\nPlease enter the temperature in degrees Celsius; you may use decimals: ";
        std::cin >> celsius;

        // Perform the temperature conversion and assign the result to a variable
        double fahrenheit = (celsius * 9 / 5) + 32;

        // Display the results with one decimal point
        std::cout << "\n" << std::fixed << std::setprecision(1) << celsius
                  << " degrees Celsius is equal to " << fahrenheit << " degrees Fahrenheit.\n";
    }

    void main() {
        userGreeting();

        while (true) {
            convertAndDisplay();

            // Goes through what happens in the askAgain function to determine the status of the main program
            if (!askAgain()) {
                break;
            }
        }
    }
};

int main() {
    TemperatureConverter temperatureConverter;
    temperatureConverter.main();
    return 0;
}

```

- This is based off of our original python program which we will add later 