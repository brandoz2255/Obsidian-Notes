``` C++
#include <QApplication>
#include <QWidget>
#include <QPushButton>

int main(int argc, char *argv[]) {
    // Create a QApplication object to manage the application's control flow and settings
    QApplication app(argc, argv);

    // Create the main application window (QWidget)
    QWidget window;
    // Set the position (x, y) and size (width, height) of the window
    window.setGeometry(100, 100, 300, 200);
    // Set the title of the window
    window.setWindowTitle("Simple GUI");

    // Create a QPushButton (button) with the label "Click me!" associated with the main window
    QPushButton button("Click me!", &window);
    // Set the position (x, y) and size (width, height) of the button within the window
    button.setGeometry(10, 10, 80, 30);

    // Connect the button's clicked signal to the application's quit slot
    QObject::connect(&button, SIGNAL(clicked()), &app, SLOT(quit()));

    // Show the main window
    window.show();

    // Start the application's event loop and return the exit code when the application exits
    return app.exec();
}

```

- This is an example of how to code a GUI with C++ we look at this more later. 