* *Inputs can be used to save the string that was typed into the input variable
* [.Lower()][] **converts whats in front of the the dot to lowercase ***example*** **like an input
* [.replace] [] **replaces anything within the string**
* It can also be printed when you print the name of the input variable 
* in some situations writing a prompt thats longer than a line will be needed in this case you can assign a prompt to a variable and pass that variable to the input function
* [Example]
```Python Session
Prompt = "if you share your name we can personalize the messages you see"
Prompt += "\nWhat is your first name? "
name = input(prompt)
print(f"\nHello,{name}!")
```

^^This is example of how to build a multiline string. 
- The first line assigns the [prompt] variable to the written **string** then [+=] takes the string that was assigned and adds the new string onto the end
- The [int()] functions allows use of numbers to be used after input and [float] function allows decimal 
 