## Cpp
- we already know most of what the first video has to offer especially in this first lesson 
- whenever we need to run a progam in c++ we need to build up the program in a way that the computer can understand it and so that it may compile the program and effectively run it 
- the code is build then we just run the file which just executes the instructions to run the program
- The example that is provided in the space in the video is as follows

```C++
#include <iostream>

using namespace std;

int main()
{
	cout<<"Hello world" << endl;
	return 0;
}
```

- This is very basic we have made better in other OS mainly Kali so this jsut states the helloworld statement 
- the `#include` statement is a librabries which C languages like C++ derive off of it takes the librarie from `<iostream>` to allow the instrucitions have made to be compiled and run 
- the using namespace essentially jsut uses the space below to type the instructions in way the computer can understand
- one thing to remember is that `endl` just a statement that tells the computer to end reading that line of instructions 
- Also another thing to remember is that the `return 0;` is jsut telling the computer to end the program
## Second challenge: Shape
- essentially the next challenge we are going to do in this lesson is write out a shape that we can see or something 
- We basically just make a pretty simple shape using the `cout` statement  
- what this dude does is he copy the lines of code used to make the hello world and he modified it to draw out the shape he wanted with the dash keys and underscore look
```C++
#include <iostream>

using namespace std;

int main()
{
	cout<<"   / |" << endl;
	cout<<"  /  |" << endl;
	cout<<" /   |" << endl;
	cout<<"/____|    " << endl;
	return 0; 
}
```

- This is essentially how he managed to make this shape usign the C++ code using the `cout` statements to allign the cahracters in a certain way to draw out a shape 
- Heres is a sample of us doing it our selves 
```C++
#include <iostream>

  

using namespace std;

int main()

{

cout<< " _________" << endl;

cout<< " / _ _ | " << endl;

cout<< "| -- -- |" << endl;

cout<< "| |____/ |" << endl;

cout<< " | _________ / " << endl;

return 0;

}
```


- the `main()` is a statement called a function remember for cross reference that in the pyhton would just be `def main ` instead
- it just contains a block of code that instructs the computer to do something 

## Variables 
- using a variable in c++ we are gonna deal with alot diffeent types of data and information 
- so it would be tought to deal with all these different types of information 
- this is where the variables come in and essentially make it easier to store information in a type of container which essentailly is teh variable
- it makes it alot easier for us to manage and maintain that data 
- ![[Screenshot from 2023-11-10 17-09-34 2.png]]
- this is a basic story in the C++ code 
- if we would like to change the name of the character in the story we would just need to manually change it so we could change it and name him `john` 
-  However lets also say we want to change his age we would then again have to manually go into the code and change the age ourselves lets say `35`
- There is a problem the problem is how annoying that we have to change the characters names and age each time we would want to change its description 
- The problem becomes bigger if lets say the story was longer like more 300 lines than changing it manually would be annoying 
- We can of course fix this issue with ==variables==
- When we create a variable in C++ we need to give the code a bit more detail such as what type of information this variable stores and the type of data
- The first type of data that can be stored is called string which is usually just plain text
- examplel 
```C++
string characterName = "John";
```

- this stores the data string `John` in the variable `characterName` 
- However we also need to store the age of the character such as in integer which is different than a string it stores data only for whole numbers

```C++
int charactersAge;
characterAge = 35;
```

Now we can use these variables in our story which makes it so much easier

```C++
#include <iostream>

using namespace std;
int main()
{
	string characterName = "John";
	int characterAge;
	characterAge = 35;
	cout << "there once was a man named " << characterName << endl;
	cout << "he was "<< characterAge <<" years old" << endl;
	cout << "he liked the name " << characterName << endl;
	cout << "he was did not like being "<< characterAge << endl;
}
```

- In C++ the `<<` in the first line of character name basically is directing the computer to put what is store in the variable within that string of text the same happens with all the other variables 
- However in the second line is more special since we need  to put it in between in order to do that we `<< characterAge <<` used two `<<` symbols to instruct C++ thats where we want it 



```C++
#include <iostream>

using namespace std;
int main()
{
	string characterName = "Tom";
	int characterAge;
	characterAge = 35;
	cout << "there once was a man named " << characterName << endl;
	cout << "he was "<< characterAge <<" years old" << endl;
	cout << "he liked the name " << characterName << endl;
	cout << "he was did not like being "<< characterAge << endl;
}
```

- Lets say if we wanted to change the characters name we would only have to modify the variable and then it would modify the rest 
- we could also modify the value halfway through the story
- All we would need to do is add this argument halfway through the code 

```C++
characterName = "Mike";
cout << "he like the name " <<characterName << endl;
cout << "he did not like being " << characterAge << endl;

```

[[perm.vid_1 1]]
