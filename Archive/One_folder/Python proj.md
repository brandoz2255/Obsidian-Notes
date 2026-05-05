with Jasper 

**Note: OOP*/-*/***/*

## USER INTERFACE:

1. Standardized CLI interface that utilizes familiar POSIX - like command line arguments utilizing flags dictating the options. Need to be able to mix the command flags together without using a separate -. 
    

1. Ex: -a -l -al
    
2. Suggested: regular expressions
    
3. OPTIONAL: enable long string version of flags such as --Force
    

3. Don't allow the mixture of certain flags that will cause conflicts. (error out) 
    

1. All errors should be returned with a value of 1 
    

## General Rules/formatting

1. Use Logging for everything, ensure everything is properly logged 
    

1. See: [https://docs.python.org/3/howto/logging.html](https://docs.python.org/3/howto/logging.html)
    

3. Don’t store any Passwords or keys in plaintext!!!. 
    
4. Use Try except, for anything that has the possibility to throw an error e.g anything that is not in our hands.
    
5. Always Comment, please 
    

1. e.g Docstrings for every class
    

7. Descriptive Variables
    
8. Modular
    
9. Detect if there even is a capture portal, if not throw an error. (done thru selenium if possible if not we do it ourselves)
    

## Features

1. -l Option/Flag that will return the html of the resolved web page/capture portal as well as its subsidiaries if there are any links, by spidering. This will default to a spider depth of 3. These will be formatted in a nested dictionary, where the key is the links url. 
    

1. Will return an error if no capture portal
    

3.  -q Quick mode will return the names of the input fields from the first page that is resolved along with corresponding numbers. 
    
4.  No args = TUI with blessed 
    
5. -p profile mode, will look for a profile file that corresponds to the capture portal and if found will prompt for either the ubikey to be inserted, the password of the user, or both.
    

  

5. User-Defined Profiles that determine specific logon behaviors for the capture portals of specific networks. Profiles will contain set variables equivalent to the following in an encrypted SQlite file: 
    

1. This whole this is encrypted with either:
    

1. a password
    
2. A ubi-key (with rsa key)
    
3. or both 
    

  

The insides of the unencrypted file will be in the following format: 

```

URL/IP address corresponding to the capture portal, Html object id -> encrypted user defined string(password or username)

Html ob. . . etc. 

```
 

  

|                 |                    |                |     |
| --------------- | ------------------ | -------------- | --- |
| SSID of network | Capture Portal URL | HTML object ID |     |
|                 |                    |                |     |
|                 |                    |                |     |
|                 |                    |                |     |
|                 |                    |                |     |
|                 |                    |                |     |
|                 |                    |                |     |

  
  

6. Custom Config file that specifies options such as but not limited to:
    

	1. Custom Selenium Browser options
    
	1. Profile file location
    

	1. URL/IP address corresponding to the profile
    
	1. Encryption Schema for profile files
    

	1. Spider Depth for -l option**