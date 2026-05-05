The bitches graph i created with the help of phind ai 

``` Python
# Import the necessary libraries
import matplotlib.pyplot as plt 
import matplotlib.animation as animation
import numpy as np
# Import the necessary classes for embedding a Matplotlib figure in a Tkinter window
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
# Import the necessary classes for handling images in Tkinter
from PIL.ImageTk import PhotoImage

# Import the Tkinter library, which allows us to create a graphical user interface (GUI)
import tkinter as tk 

# Create a new Tkinter root window
root = tk.Tk()

# Create a new Matplotlib figure and axes with subplots()
flg, ax = plt.subplots()

# Initialize empty lists for storing the x and y values
x = []
y = [] 

# Define the animate function, which updates the plot for each frame of the animation
def animate(i):
 # Append the current index to the x list
 x.append(i)
 # Append the sine of the current index to the y list
 y.append(np.sin(i))
 # Clear the current plot
 ax.clear()
 # Plot the x and y values
 ax.plot(x, y)
 # Set the label of the x-axis
 ax.set_xlabel("Amount of Bitches")
 # Set the label of the y-axis
 ax.set_ylabel("Bithes per second")
 # Redraw the canvas after each frame
 canvas.draw()

# Create a new FigureCanvasTkAgg object, which is a Matplotlib figure canvas that can be embedded in a Tkinter window
canvas = FigureCanvasTkAgg(flg, master=root)
# Draw the initial plot
canvas.draw()
# Pack the canvas into the root window
canvas.get_tk_widget().pack(side=tk.TOP, fill = tk.BOTH, expand=1)
# Set the title of the window containing the canvas
canvas.get_tk_widget().master.title("Bitches graph")

# Assign the animation to an attribute of the canvas
canvas.ani = animation.FuncAnimation(flg, animate, frames = range(120), interval = 100)

# Start the Tkinter event loop
root.mainloop()

```

There is a comment after each line to help us read what each line in this codes does essentially 