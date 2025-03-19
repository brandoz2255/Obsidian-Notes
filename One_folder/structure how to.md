# back end 

-  A  module with a class for all  functions 
	- Function for generating password for the username
		- Diceware method algorithm 
	- Function for generating username 
	- Function for Sql Lite 
	- Function for updating  the data base with the new username and password 
	- Function for handling user Log in/sign up 
	- Function for handling user password after logging in or creating an account 
		- proper hashing the password for user security and proper log in methods for those hashes algorithms to consider ` bcrypt or Argon2` 
		- Use a secure method for storing passwords, such as hashing with a salt. For storing in a database, you'll need to interact with the database using SQL queries or an ORM (Object-Relational Mapping) library.
			- First the user signs up and then the credentials such as username and email and password is stored in the data base then when the user logs in it can 
			- begin to create accounts using this program such as usernames and passwords and this  will manage all those usernames and passwords 
	- Function for the 2 factor authentication 
		- for the user log in 
	- Function for stating how strong the password is (will be a feature in the GUI)
	- 
- A module with the logic for those functions 
	- Logic for all the functions mentioned previously 

- A module with the main part of the back end logic 
	- The main module of the program that will handle with communication between the Front end part and the back end part this is the middle man module 


## Dependencies 

- sqlLite 
- Qt for C++ for the GUI/front end 
- Hash for password generation


## Testing 

**Unit Testing**: Start by writing unit tests for each of your functions. This includes testing password generation, username generation, database operations, and the logic for password strength estimation. Libraries like Google Test can be very helpful for this.


**Integration Testing**: After unit testing, perform integration tests to ensure that the different modules of your application work together as expected. This includes testing the flow from user login/signup to password generation and storage.


### Tips 
**Password Generation**: For generating passwords, consider using a well-established library or algorithm. For example, you mentioned using the `Diceware` method for generating usernames. For passwords, consider using a library that supports `bcrypt or Argon2` for hashing.


**Database Operations**: Since you're moving from CSV to SQLite, ensure you're familiar with SQL queries and how to interact with SQLite databases in C++. Libraries like SQLiteCpp can simplify database operations.

**Security**: When storing passwords, always hash them with a salt and use a secure hashing algorithm like bcrypt or Argon2. Never store plaintext passwords.


**Two-Factor Authentication (2FA)**: Implementing 2FA can be complex. Consider using a library or service that provides 2FA functionality, or ensure you understand the OATH Toolkit well if you're implementing it yourself.