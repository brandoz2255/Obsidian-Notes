```JS 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Conversion Program</title>
    <style>
        
        /* Body background color and font family */
        body {
            background-color: #3daeae; /* Cyan color */
            font-family: Arial, sans-serif;
            margin: 0; /* Remove default margin */
            padding: 20px; /* Add some padding for better spacing */
        }

        /* Styling for the output container */
        #output {
            background-color: #2e96ea; /* White background for contrast */
            padding: 10px;
            margin-bottom: 20px;
            animation: fadeIn 0.865s ease; /*uses the element animation*/
        }
        /* New keyframes for fading in with translation */
        @keyframes fadeInWithTranslation {
            from {
                opacity: 0;
                transform: translateY(20px); /* moves the element down */
            }
            to {
                opacity: 1;
                transform: translateY(0); /* moves the element back to the normal position */
            }
        }
        

        #conversionType {
            animation: fadeInWithTranslation 0.5s ease; /* or animation: fadeIn 0.5s ease; */
        }


        /* Animation for fading in */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translate(20px); /* moves the element down*/ 
            }
            to {
                opacity: 1;
                transform: translate(0); /* moves the element down to the normal positiion*/
            }
        }

        /* Form styling */
        #conversionForm {
            background-color: #0eeeeef6; /* Light Cyan color */
            padding: 10px;
            margin-bottom: 20px;
            animation: fadeIn 0.5s ease; /* Use the fadeIn animation */
        }

        /* Label styling */
        label {
            display: block; /* Make labels block elements for better spacing */
            margin-bottom: 5px;
        }

        /* Input styling */
        input {
            padding: 5px;
            margin-bottom: 10px;
        }

        /* Button styling */
        button {
            background-color: #199df0; /* Teal color */
            color: #6a0808; /* White text */
            padding: 10px;
            border: none;
            cursor: pointer;
        }

        /* Button hover effect */
        button:hover {
            background-color: #006666; /* Darker teal color on hover */
        }
    </style>
</head>
<body>
    <div id="output"></div>
    <form id="conversionForm">
        <label>Please select a conversion type:</label>
        <select id="conversionType">
            <option value="InchesToCentimeters">Inches to Centimeters</option>
            <option value="CentimetersToInches">Centimeters to Inches</option>
            <option value="OuncesToGrams">Ounces to Grams</option>
            <option value="GramsToOunces">Grams to Ounces</option>
            <option value="MilesToKilometers">Miles to Kilometers</option>
            <option value="KilometersToMiles">Kilometers to Miles</option>
            <option value="CelsiusToFahrenheit">Celsius to Fahrenheit</option>
        </select>
        <br>
        <label>Please enter a number:</label>
        <input type="number" id="userInput" step="any">
        <br>
        <button type="button" onclick="calculateAndDisplay()">Convert</button>
    </form>
    <button onclick="askToContinue()">Continue?</button>

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

        function userGreeting() {
            writeToOutput("Hello and welcome to this program!");
            writeToOutput("Essentially, this program will allow you to do conversions in multiple fields");
        }

        function writeToOutput(message) {
            document.getElementById("output").innerHTML += message + "<br>";
        }

        function getConversionType() {
            const conversionTypeSelect = document.getElementById("conversionType");
            const selectedOption = conversionTypeSelect.value;

            switch (selectedOption) {
                case 'InchesToCentimeters':
                    return ConversionType.InchesToCentimeters;
                case 'CentimetersToInches':
                    return ConversionType.CentimetersToInches;
                case 'OuncesToGrams':
                    return ConversionType.OuncesToGrams;
                case 'GramsToOunces':
                    return ConversionType.GramsToOunces;
                case 'MilesToKilometers':
                    return ConversionType.MilesToKilometers;
                case 'KilometersToMiles':
                    return ConversionType.KilometersToMiles;
                case 'CelsiusToFahrenheit':
                    return ConversionType.CelsiusToFahrenheit;
                default:
                    writeToOutput("Invalid conversion type.");
                    return null;
            }
        }

        function calculateAndDisplay() {
            const conversionType = getConversionType();
            const userInput = parseFloat(document.getElementById("userInput").value);

            if (isNaN(userInput)) {
                writeToOutput("Invalid input. Please enter a valid number.");
                return;
            }

            let result;

            switch (conversionType) {
                case ConversionType.InchesToCentimeters:
                    result = userInput * 2.54;
                    writeToOutput(`${userInput} Inches Equals ${result} Centimeters`);
                    break;
                case ConversionType.CentimetersToInches:
                    result = userInput * 0.3937;
                    writeToOutput(`${userInput} Centimeters Equals ${result} Inches`);
                    break;
                case ConversionType.OuncesToGrams:
                    result = userInput * 28.34952;
                    writeToOutput(`${userInput} Ounces Equals ${result} Grams`);
                    break;
                case ConversionType.GramsToOunces:
                    result = userInput / 28.34952;
                    writeToOutput(`${userInput} Grams Equals ${result} Ounces`);
                    break;
                case ConversionType.MilesToKilometers:
                    result = userInput * 1.609344;
                    writeToOutput(`${userInput} Miles Equals ${result} Kilometers`);
                    break;
                case ConversionType.KilometersToMiles:
                    result = userInput * 0.621371;
                    writeToOutput(`${userInput} Kilometers Equals ${result} Miles`);
                    break;
                case ConversionType.CelsiusToFahrenheit:
                    // Implement the Celsius to Fahrenheit conversion here
                    break;
                default:
                    writeToOutput("Invalid conversion type.");
                    break;
            }
        }

        function askToContinue() {
            const continueProgram = confirm("Would you like to use this program again?");
            if (!continueProgram) {
                writeToOutput("OK. Goodbye!");
            }
        }

        function runProgram() {
            userGreeting();
        }

        runProgram();
    </script>
</body>
</html>

```

- There is a difference here one thing to ignore in this snippet is the css we will talk about this in another note same goes for the HTML 
- However in terms of html the JS job in html websites is that html is used to handle the data gathering in a program unlike how we used C++ and Python in the past where we make a CLI program and ask the user for stuff so that the program can do things 
- in the web development thats all handled by by HTML when we use the get information on the JS it blocks the user from using the site until it asnwered from the JS side then html makes the user intereaction 

## HTML

How this works basically is that HTML is used to interact with the user and the JS is specifically used to handle the data and everything else the user can do in the site like literally the hard work of the site is in JS where HTML handles the data gathering and displaying the site to the browser. 

### CSS 
Where CSS comes in a pretty easy to read code and easy to understand this code uses actual English and not insane abbreviations like other code 

- This code handles the look of the site where without the CSS code structure the website looks likes plain gray and black interaction intense coding of the CSS code will make the website look amazing adding animations and cool little gimmicks on how the html user interaction looks 