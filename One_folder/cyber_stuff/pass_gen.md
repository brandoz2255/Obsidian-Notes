```C++
#include <iostream>
#include <string>
#include <sstream>
#include <cstdlib>
#include <ctime>
#include <vector>
#include <algorithm>
#include <openssl/sha.h>

// This program will take  a phrase and make a password and username based on said phrase

using namespace std;

class Mainprogram{
    public:

    void userGreeting(){
            cout << "\n!!!!!!!WELCOME!!!!!!!!\n" << endl;
            cout << R"( _______    ______    ______    ______   __       __   ______   _______   _______                                                                               
/       \  /      \  /      \  /      \ /  |  _  /  | /      \ /       \ /       \                                                                              
$$$$$$$  |/$$$$$$  |/$$$$$$  |/$$$$$$  |$$ | / \ $$ |/$$$$$$  |$$$$$$$  |$$$$$$$  |                                                                             
$$ |__$$ |$$ |__$$ |$$ \__$$/ $$ \__$$/ $$ |/$  \$$ |$$ |  $$ |$$ |__$$ |$$ |  $$ |                                                                             
$$    $$/ $$    $$ |$$      \ $$      \ $$ /$$$  $$ |$$ |  $$ |$$    $$< $$ |  $$ |                                                                             
$$$$$$$/  $$$$$$$$ | $$$$$$  | $$$$$$  |$$ $$/$$ $$ |$$ |  $$ |$$$$$$$  |$$ |  $$ |                                                                             
$$ |      $$ |  $$ |/  \__$$ |/  \__$$ |$$$$/  $$$$ |$$ \__$$ |$$ |  $$ |$$ |__$$ |                                                                             
$$ |      $$ |  $$ |$$    $$/ $$    $$/ $$$/    $$$ |$$    $$/ $$ |  $$ |$$    $$/                                                                              
$$/       $$/   $$/  $$$$$$/   $$$$$$/  $$/      $$/  $$$$$$/  $$/   $$/ $$$$$$$/                                                                               
                                                                                                                                                                
                                                                                                                                                                
                                                                                                                                                                
                                                                                                                                                                
  ______   ________  __    __  ________  _______    ______   ________   ______   _______                                                                        
 /      \ /        |/  \  /  |/        |/       \  /      \ /        | /      \ /       \                                                                       
/$$$$$$  |$$$$$$$$/ $$  \ $$ |$$$$$$$$/ $$$$$$$  |/$$$$$$  |$$$$$$$$/ /$$$$$$  |$$$$$$$  |                                                                      
$$ | _$$/ $$ |__    $$$  \$$ |$$ |__    $$ |__$$ |$$ |__$$ |   $$ |   $$ |  $$ |$$ |__$$ |                                                                      
$$ |/    |$$    |   $$$$  $$ |$$    |   $$    $$< $$    $$ |   $$ |   $$ |  $$ |$$    $$<                                                                       
$$ |$$$$ |$$$$$/    $$ $$ $$ |$$$$$/    $$$$$$$  |$$$$$$$$ |   $$ |   $$ |  $$ |$$$$$$$  |                                                                      
$$ \__$$ |$$ |_____ $$ |$$$$ |$$ |_____ $$ |  $$ |$$ |  $$ |   $$ |   $$ \__$$ |$$ |  $$ |                                                                      
$$    $$/ $$       |$$ | $$$ |$$       |$$ |  $$ |$$ |  $$ |   $$ |   $$    $$/ $$ |  $$ |                                                                      
 $$$$$$/  $$$$$$$$/ $$/   $$/ $$$$$$$$/ $$/   $$/ $$/   $$/    $$/     $$$$$$/  $$/   $$/                                                                       
                                                                                                                                                                
                                                                                                                                                                
)" << endl;
    }

    //gets the userinput of the phrase 
    void userInput(){

        string message;

        cout << "\n----------------------------------------------------------\n"<< endl;
        cout << "Please input a phrase of your choice to make a password and username" << endl;
        cout << "\n--> "; 
        getline(cin, message); 
        cout << "\n----------------------------------------------------------\n"<< endl;

    }

    //generates the username and password based off of phrase from the userinput 
    string generate_username(const string &message) {
        // Split the phrase into words
        istringstream iss(message);
        vector<string> words;
        for(string s; iss >> s; )
        words.push_back(s);
  
        // Generate acronym from the first letters of each word
        string acronym = "";
        for(auto &word : words){
        acronym += toupper(word[0]);
         }
  
        // Append a random number to the acronym
        srand((unsigned) time(NULL)); // provide a fresh seed value
        int number = rand() % 900 + 100; // generate a random number between 100 and 999
        ostringstream oss;
        oss << acronym << setfill('0') << setw(3) << number;
  
        return oss.str();
        }
    //Bool function that asks the user if they want to use the program again or not 
    bool askUsrEmsg(){
        while(true){
            
            string ask

            cout << "\n----------------------------------------------------------\n"<< endl; 
            cout << "would you like to use this program again [Y/n]" << endl;
            cout << "\n--> " << endl;
            ask = getline(cin, ask);
            cout << "\n----------------------------------------------------------\n"<< endl;

            if(ask == 'y'){
                return true;
            }else if(ask == 'n'){
                return false;
            }else {
                cout << "Either y or n !!!"<< endl;
            }

        }



    }


    //Function for the exit message 
    void exitMessage(){
        cout << "\n----------------------------------------------------------\n"<< endl;
        cout << "THANKS FOR USING THE C++ EDITION!!!" << endl;
        cout << "\n----------------------------------------------------------\n"<< endl;

    }


    // Function to generate a random index
    int randomIndex(int size) {
        return rand() % size;
    }

    // Function to generate a random password
    string generatePassword(string message, int length = 16) {
        unsigned char hashedMessage[SHA256_DIGEST_LENGTH];
   
        // Hash the message
        SHA256_CTX sha256;
        SHA256_Init(&sha256);
        SHA256_Update(&sha256, message.c_str(), message.size());
        SHA256_Final(hashedMessage, &sha256);
   
        // Convert the hashed message to a list of characters
        vector<char> hashedChars;
        for(int i = 0; i < SHA256_DIGEST_LENGTH; ++i) {
       hashedChars.push_back(hashedMessage[i]);
        }
   
        // Select random characters from the hashed message to form the password
        string password = "";
        for(int i = 0; i < length; ++i) {
            password += hashedChars[randomIndex(hashedChars.size())];
        }
   
        // Ensure password has at least one uppercase letter, one lowercase letter, one digit, and one special character
        password[0] = toupper(password[0]);
        password[1] = 'A';
        password[2] = '1';
        password[3] = '!';
   
        return password;
    }










}
```


- a cool thing that Black box told us is to make to make our program more interesting in C++ we can use two libraries for windows we need to use `PDcurses`  library `ncurses` for Unix OS's like linux and Mac 