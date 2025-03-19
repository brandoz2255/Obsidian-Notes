- **Initialize Environment**:
    
    - Create and activate Python virtual environment (`venv`).
- **Develop Locally**:
    
    - Write and test code in a development folder or directly in `src` if confident.
- **Structure Code**:
    
    - Move stable code to `src` folder.
    - Write associated tests in `tests` folder.
- **Run Tests**:
    
    - Use `pytest` or `unittest` to run tests to ensure functionality and reliability.
- **Version Control**:
    
    - Use Git for version control.
    - Regularly commit and push changes to your repository.


**Build Docker Image**:

```C
docker build -t my-python-app .
```

Runs the container
```C
docker run -p 4000:5000 my-python-app
```

