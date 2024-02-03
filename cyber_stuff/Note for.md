The error message you're seeing suggests that you're trying to install Python packages system-wide, which is not recommended because it can lead to conflicts with the system's Python packages.

To resolve this issue, I recommend creating a virtual environment for your chatbot project. Here's how you can do it:

1. Open a terminal window in your Arch Linux system.
2. Navigate to the directory where you want to create your virtual environment.
3. Create a new virtual environment using the following command:

`python3 -m venv myenv`

Replace "myenv" with the name you want to give to your virtual environment.

4. Activate the virtual environment using the following command:

`source myenv/bin/activate`

Replace "myenv" with the name of your virtual environment.

5. Once the virtual environment is activated, you can install TensorFlow and Keras using pip3:

`pip3 install tensorflow`

`pip3 install keras`

6. To deactivate the virtual environment when you're done, use the following command:

`deactivate`

By using a virtual environment, you can isolate your project's dependencies from the system's Python packages and avoid conflicts.

- We could also do this for every other programming project if the library we need has conflict issues 
- We could also open VScode as usual in here as well 