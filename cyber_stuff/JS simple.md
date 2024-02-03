# Simple program 
Started out as a simple convserion of lab 13 the cool one to a CLI application however i Accidently mad it to a only work in a web browser so in order for it to work in a web browser we made a html file and put the JS code in there here is the JS code we messed up on 

```JS
// Simulates the enum in C++ so this is similar to what an enum is in C++
const ConversionType = {
    InchesToCentimeters: 0,
    CentimetersToInches: 1,
    OuncesToGrams: 2,
    GramsToOunces: 3,
    MilesToKilometers: 4,
    KilometersToMiles: 5,
    CelsiusToFahrenheit: 6
};

// User greeting function that displays a user greeting in JS
function userGreeting() {
    console.log("\033[1;32m");
    console.log(`
   .____      _____ __________  ____________  ._._.
 |   |    / _ \\______  \\ /_  \\_____ \\ | | |
 |   |   / /_\\ \\|   | _/ |  | _(__ < | | |
 |   |___/   |   \\   |  \\ |  |/      \\ \\|\\|
 |_______ \\____|__ /______ / |___/______ / ____
        \\/      \\/      \\/             \\/  \\\\/ 
    `);
    console.log("\033[0m");
    console.log("Hello and welcome to this program!");
    console.log("\033[1;32m---------------------------------------------------");
    console.log("\033[1;93mEssentially, this program will allow you to do conversions in multiple fields\033[1;32m");
    console.log("---------------------------------------------------");
}

// Function to get the conversion type based on user input
function getConversionType() {
    let message = prompt("\033[1;32mPlease input the following to use this program for conversion.\033[0m" +
        "\n'I' Will convert Inches to Centimeters." +
        "\n'C' Will convert Centimeters to Inches." +
        "\n'O' Will convert Ounces to Grams." +
        "\n'G' Will convert from Grams to Ounces." +
        "\n'M' Will convert from Miles to Kilometers." +
        "\n'K' Will convert Kilometers to miles." +
        "\n'T' Will convert Celsius to Fahrenheit.");

    switch (message.toLowerCase()) {
        case 'i':
            return ConversionType.InchesToCentimeters;
        case 'c':
            return ConversionType.CentimetersToInches;
        case 'o':
            return ConversionType.OuncesToGrams;
        case 'g':
            return ConversionType.GramsToOunces;
        case 'm':
            return ConversionType.MilesToKilometers;
        case 'k':
            return ConversionType.KilometersToMiles;
        case 't':
            return ConversionType.CelsiusToFahrenheit;
        default:
            alert("I'm sorry, I did not understand the value. Please type the correct value.");
            return null;
    }
}

// Function to calculate and display the conversion result
function calculateAndDisplay(conversionType) {
    if (conversionType === ConversionType.CelsiusToFahrenheit) {
        // Implement the Celsius to Fahrenheit conversion here
    } else {
        let number = parseFloat(prompt("\nPlease enter a number: "));
        let result;
        switch (conversionType) {
            case ConversionType.InchesToCentimeters:
                result = number * 2.54;
                console.log(`\n${number} Inches Equals ${result} Centimeters`);
                break;
            case ConversionType.CentimetersToInches:
                result = number * 0.3937;
                console.log(`\n${number} Centimeters Equals ${result} Inches`);
                break;
            case ConversionType.OuncesToGrams:
                result = number * 28.34952;
                console.log(`\n${number} Ounces Equals ${result} Grams`);
                break;
            case ConversionType.GramsToOunces:
                result = number / 28.34952;
                console.log(`\n${number} Grams Equals ${result} Ounces`);
                break;
            case ConversionType.MilesToKilometers:
                result = number * 1.609344;
                console.log(`\n${number} Miles Equals ${result} Kilometers`);
                break;
            case ConversionType.KilometersToMiles:
                result = number * 0.621371;
                console.log(`\n${number} Kilometers Equals ${result} Miles`);
                break;
        }
    }
}

// Function to ask the user if they want to continue the program
function askToContinue() {
    console.log("\033[1;32m---------------------------------------------------");

    let answer = prompt("Would you like to use this program again [Y/N]: ");

    if (answer.toLowerCase() === 'y') {
        return true;
    } else if (answer.toLowerCase() === 'n') {
        return false;
    } else {
        console.log("\033[1;32m--------------------------------------------------------");
        console.log("Did not understand your input. Please enter either 'n' or 'y'.");
    }
}

// Function to display an exit message
function exitMessage() {
    console.log("\033[1;32m--------------------------------------------------------");
    console.log("\033[1;32m----------------------------OK---------------------------");
    console.log("\033[1;32m--------------------------------------------------------");
}

// Main function of the code
userGreeting();
let conversionTypeMain = getConversionType();
if (conversionTypeMain !== null) {
    calculateAndDisplay(conversionTypeMain);
    let runMainProgram = askToContinue();
    while (runMainProgram) {
        userGreeting();
        conversionTypeMain = getConversionType();
        if (conversionTypeMain !== null) {
            calculateAndDisplay(conversionTypeMain);
            runMainProgram = askToContinue();
        }
    }
}
exitMessage();

```

## HTML 
As of right now we don't know anything about HTML or how it works as of right now a theory is how the web browser structures the code such as JS CSS so that the web browser it self can read it here is the HTML EX that gpt gave us for our JS code 

```HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Conversion Program</title>
</head>
<body>
    <script>
        // Your JavaScript code here
    </script>
</body>
</html>

```

- as  mentioned before we must `<script>` to tell the webbrowser that it is a JS code 

## CLI 
If we were making the CLI application as we inteded we would need to use readline function instead of the prompt() function here is the CLI example of our code

```JS
const readline = require('readline');
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// ...

function getConversionType() {
    rl.question("\033[1;32mPlease input the following to use this program for conversion.\033[0m" +
        "\n'I' Will convert Inches to Centimeters." +
        "\n'C' Will convert Centimeters to Inches." +
        "\n'O' Will convert Ounces to Grams." +
        "\n'G' Will convert from Grams to Ounces." +
        "\n'M' Will convert from Miles to Kilometers." +
        "\n'K' Will convert Kilometers to miles." +
        "\n'T' Will convert Celsius to Fahrenheit.", function (message) {
            if (message.toLowerCase() === 'i') {
                return ConversionType.InchesToCentimeters;
            } else if (message.toLowerCase() === 'c') {
                return ConversionType.CentimetersToInches;
            } else if (message.toLowerCase() === 'o') {
                return ConversionType.OuncesToGrams;
            } else if (message.toLowerCase() === 'g') {
                return ConversionType.GramsToOunces;
            } else if (message.toLowerCase() === 'm') {
                return ConversionType.MilesToKilometers;
            } else if (message.toLowerCase() === 'k') {
                return ConversionType.KilometersToMiles;
            } else if (message.toLowerCase() === 't') {
                return ConversionType.CelsiusToFahrenheit;
            } else {
                console.log("I'm sorry, I did not understand the value. Please type the correct value.");
                return null;
            }
        });
}

// ...

function askToContinue() {
    console.log("\033[1;32m---------------------------------------------------");

    rl.question("Would you like to use this program again [Y/N]: ", function (answer) {
        if (answer.toLowerCase() === 'y') {
            return true;
        } else if (answer.toLowerCase() === 'n') {
            return false;
        } else {
            console.log("\033[1;32m--------------------------------------------------------");
            console.log("Did not understand your input. Please enter either 'n' or 'y'.");
        }
        rl.close();
    });
}

// ...

// In the main program, replace `prompt` with `rl.question`

```

- This is how Node interpreter can read the JS code since the other code we made only the web browser can read it which makes sense it display prompt rather than input synonym 

### Issue 
However there is still an issue with the Web browser code here is a fixed version 

```HTML 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Conversion Program</title>
</head>
<body>
    <script>
        const ConversionType = {
            InchesToCentimeters: 0,
            CentimetersToInches: 1,
            OuncesToGrams: 2,
            GramsToOunces: 3,
            MilesToKilometers: 4,
            KilometersToMiles: 5,
            CelsiusToFahrenheit: 6
        };

        async function userGreeting() {
            console.log("\033[1;32m");
            console.log(`
           .____      _____ __________  ____________  ._._.
         |   |    / _ \\______  \\ /_  \\_____ \\ | | |
         |   |   / /_\\ \\|   | _/ |  | _(__ < | | |
         |   |___/   |   \\   |  \\ |  |/      \\ \\|\\|
         |_______ \\____|__ /______ / |___/______ / ____
                \\/      \\/      \\/             \\/  \\\\/ 
            `);
            console.log("\033[0m");
            console.log("Hello and welcome to this program!");
            console.log("\033[1;32m---------------------------------------------------");
            console.log("\033[1;93mEssentially, this program will allow you to do conversions in multiple fields\033[1;32m");
            console.log("---------------------------------------------------");
        }

        async function getConversionType() {
            return new Promise((resolve) => {
                let message = prompt("\033[1;32mPlease input the following to use this program for conversion.\033[0m" +
                    "\n'I' Will convert Inches to Centimeters." +
                    "\n'C' Will convert Centimeters to Inches." +
                    "\n'O' Will convert Ounces to Grams." +
                    "\n'G' Will convert from Grams to Ounces." +
                    "\n'M' Will convert from Miles to Kilometers." +
                    "\n'K' Will convert Kilometers to miles." +
                    "\n'T' Will convert Celsius to Fahrenheit.");

                switch (message.toLowerCase()) {
                    case 'i':
                        resolve(ConversionType.InchesToCentimeters);
                        break;
                    case 'c':
                        resolve(ConversionType.CentimetersToInches);
                        break;
                    case 'o':
                        resolve(ConversionType.OuncesToGrams);
                        break;
                    case 'g':
                        resolve(ConversionType.GramsToOunces);
                        break;
                    case 'm':
                        resolve(ConversionType.MilesToKilometers);
                        break;
                    case 'k':
                        resolve(ConversionType.KilometersToMiles);
                        break;
                    case 't':
                        resolve(ConversionType.CelsiusToFahrenheit);
                        break;
                    default:
                        alert("I'm sorry, I did not understand the value. Please type the correct value.");
                        resolve(null);
                }
            });
        }

        async function askToContinue() {
            return new Promise((resolve) => {
                console.log("\033[1;32m---------------------------------------------------");
                let answer = prompt("Would you like to use this program again [Y/N]: ");
                resolve(answer.toLowerCase() === 'y');
            });
        }

        function calculateAndDisplay(conversionType) {
            if (conversionType === ConversionType.CelsiusToFahrenheit) {
                // Implement the Celsius to Fahrenheit conversion here
            } else {
                let number = parseFloat(prompt("\nPlease enter a number: "));
                let result;
                switch (conversionType) {
                    case ConversionType.InchesToCentimeters:
                        result = number * 2.54;
                        console.log(`\n${number} Inches Equals ${result} Centimeters`);
                        break;
                    case ConversionType.CentimetersToInches:
                        result = number * 0.3937;
                        console.log(`\n${number} Centimeters Equals ${result} Inches`);
                        break;
                    case ConversionType.OuncesToGrams:
                        result = number * 28.34952;
                        console.log(`\n${number} Ounces Equals ${result} Grams`);
                        break;
                    case ConversionType.GramsToOunces:
                        result = number / 28.34952;
                        console.log(`\n${number} Grams Equals ${result} Ounces`);
                        break;
                    case ConversionType.MilesToKilometers:
                        result = number * 1.609344;
                        console.log(`\n${number} Miles Equals ${result} Kilometers`);
                        break;
                    case ConversionType.KilometersToMiles:
                        result = number * 0.621371;
                        console.log(`\n${number} Kilometers Equals ${result} Miles`);
                        break;
                }
            }
        }

        async function exitMessage() {
            console.log("\033[1;32m--------------------------------------------------------");
            console.log("\033[1;32m----------------------------OK---------------------------");
            console.log("\033[1;32m--------------------------------------------------------");
        }

        async function runProgram() {
            await userGreeting();
            let conversionTypeMain = await getConversionType();

            if (conversionTypeMain !== null) {
                calculate


```

this one is the fixed one the call upon functions are have a funtion the main program 