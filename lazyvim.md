## 1. **Highlight Code and Comment Out (Ctrl+Shift+A Equivalent)**

In LazyVim, commenting out a section of code can be achieved using plugins like `nvim-ts-context-commentstring` or `Comment.nvim`. These plugins allow you to toggle comments for selected code blocks based on the file type.


- **Keybinding for Commenting:**  
    LazyVim typically comes with pre-configured keybindings. To comment out a section:
    
    - Highlight the code in **Visual Mode** (`v`).
    - Press `gc` to toggle comments for the selected block.

## 2. **Undo and Redo (Ctrl+Z Equivalent)**

In Vim (and by extension LazyVim), undo and redo are handled using:

- **Undo:** Press `u` in normal mode.
- **Redo:** Press `Ctrl+r` in normal mode.