Creating a new repo is like setting up the stage for your show. Here's the script:

1. **Initialize a New Git Repo:**
    `git init`
    
    This sets up a new Git repository in your current directory.
    
- **Add All Files:**
    
- `git add .`
    
    This stages all your files for the initial commit.
    
- **Commit the Initial Changes:**
    
- `git commit -m "Initial commit"`
    
    This commits your files to the local repository.
    
- **Create a New Repo on GitHub:**
    
    - Go to GitHub and create a new repository.
    - Copy the URL of your new repo.
- **Link Local Repo to GitHub Repo:**
    
- `git remote add origin <your_repo_url>`
    
    This links your local repo to the one on GitHub.
    
- **Push Initial Changes to GitHub:**
    

1. `git push -u origin main`
    
    This sends your local files to the GitHub repo.
    

Voilà! You've just premiered your new repo. If you encounter any glitches in the opening act, I'm here to help you with the backstage drama


or ...
```shell
echo "# augmented_pc" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/brandoz2255/augmented_pc.git
git push -u origin main
```

this also helps 