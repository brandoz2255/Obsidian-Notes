- First step is to gain a foot hold
- Obvously the first thing we need  to do is nmap scan the machiine to look at what it is and what exploits we can find
- One option given by GPT is gobuster However it does depend on the machine but is an option 
```CLI
gobuster dir -u http://<target_ip> -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt

```

A list of cool shortcutss to make life easier 

Target machine is `10.129.144.142`


## Nmap
stuf 

`nmap -sC -sV -oA initial_scan <target_ip>`

- `-sC`: Runs default scripts.
- `-sV`: Version detection.
- `-oA`: Outputs in all formats (Nmap, XML, Grepable).


### Basic Navigation

- **`Ctrl + A`**: Move the cursor to the beginning of the line.
- **`Ctrl + E`**: Move the cursor to the end of the line.
- **`Ctrl + U`**: Clear from the cursor to the beginning of the line.
- **`Ctrl + K`**: Clear from the cursor to the end of the line.
- **`Ctrl + W`**: Delete the word before the cursor.
- **`Ctrl + Y`**: Paste the last thing that was cut.
- **`Alt + B`**: Move the cursor back one word.
- **`Alt + F`**: Move the cursor forward one word.
- **`Ctrl + L`**: Clear the screen (same as the `clear` command).

### Editing

- **`Ctrl + H`**: Delete the character before the cursor (same as Backspace).
- **`Ctrl + D`**: Delete the character under the cursor.
- **`Ctrl + T`**: Transpose (swap) the character under the cursor with the previous character.
- **`Alt + T`**: Transpose the current word with the previous word.
- **`Ctrl + _`**: Undo the last action.

### History

- **`Ctrl + R`**: Search through the command history.
- **`Ctrl + G`**: Exit history search mode.
- **`Up Arrow`**: Show the previous command.
- **`Down Arrow`**: Show the next command.
- **`!!`**: Repeat the last command.
- **`!n`**: Repeat the nth command in history.
- **`!string`**: Repeat the last command that starts with `string`.

### Process Management

- **`Ctrl + C`**: Terminate the current process.
- **`Ctrl + Z`**: Suspend the current process.
- **`fg`**: Resume the suspended process in the foreground.
- **`bg`**: Resume the suspended process in the background.

### File and Directory Management

- **`Tab`**: Autocomplete file and directory names.
- **`Ctrl + X + E`**: Open the current command line in your default editor (usually Vim or Nano)
