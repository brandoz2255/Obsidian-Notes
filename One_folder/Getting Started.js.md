For the most part 

# Fleet 

- [ ] React what is it? exactly 
	- [ ]  is how you use html within the js code is that jsx? 
	- [ ] is how you add mini "websites" in the code to make that cool looking UI and UX design? 
- [ ] Does it need this beginner html script each time? 
```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <script src="https://unpkg.com/react@17/umd/react.development.js" crossorigin></script>
    <script src="https://unpkg.com/react-dom@17/umd/react-dom.development.js" crossorigin></script>
    <title>React *</title>
</head>
<body>
    <h1>Getting Started with React</h1>
</body>
</html>
```


- [ ] we also need to add this code to it to make the React components work 
```html
    <script type="text/javascript">
        ReactDOM.render(
            React.createElement(
                "h1",
                null,
                "This is React.js speaking!"

            ),
            document.getElementById("root")
        );
     

    </script>
```

- [ ] explain what the js.script part is ddoing in the html script
	- [ ] why it works and what else can be done 
	- [ ] How the DOM render is creating an element and then attaching it to the root id why is it doing this

- [ ] *For UI and UIX design what we could do instead of having functions within functions we can set it as a variable*
	- [ ] Why is this better essentially? 
	- [ ] How does this work in the long and in more complex apps/sites

``` html
 <script type="text/javascript">
        let heading = React.createElement(
                "h1",
                null,
                "This is React.js speaking!!!"

            );

        ReactDOM.render(
            heading,
            document.getElementById("root")
        );
     

    </script>
```


- [ ] Creating an unordered list "ul" 

```html
  <script type="text/javascript">
        let ul = React.createElement(
                "ul",
                { style: { color: "blue" } },
                React.createElement("li", null, "Monday"),
                React.createElement("li", null, "Tuesday"),
                React.createElement("li", null, "Wednesday"),
                React.createElement("li", null, "More"),

            );

        ReactDOM.render(
            ul,
            document.getElementById("root")
        );
     

    </script>

```

- [ ] However this is all just simple react usage for more complex projects what is needed is using JSX 
	- [ ] explain why JSX is better for more complex projects?  
- [ ] Could've been done more professionally like this 

```js
ReactDOM.render(
	<ul>
		<li>Monday</li>
		<li>Tuesday</li>
		<li>next day</li>
		<li>etc</li>
	</ul>,
	document.getElementid("root")
)
```


- [ ] (curly braces in jsx is always calling a jsx expressio n!) | what does the curly braces do in jsx 
	- [ ] How are they used? 
	- [ ] Why do they work ? 
	- [ ] When do we use them? 

``` js
    <h1>Getting Started with React</h1>
    <script type="text/babel">
        let m = "Monday";
        let t = "Tuesday";
        let n = "next day";
        let e = "etc";

        ReactDOM.render(
            <ul style={{ color: "blue" }}>
                <li>{m}</li>
                <li>{t}</li>
                <li>{n}</li>
                <li>{e}</li>
            </ul>,
            document.getElementById("root")
        );
    </script>
```

- [ ] You could also use a function within the jsx expression
	- [ ]  example : `<li>{e.toUppercase()}</li>` which would set `e` to all caps! 
	- [ ] How is this useful? 
- [ ] What is strict mode in React ? 

```js
<StrictMode>
    <App />
</StrictMode>

```



