- Since we need loggined into the admin  portal, we need to attempt to turn this access into code execution and ultimately gain reverse shell access to the webserver
- We know that metasploit will likely work for this but lets gain access tot he admin portal for other avenues of attack looking around for a bit, we see the following pages:

- `Page`	 [Contents]
- `Publish`	[making a new post, video post, quote post, or new page. It could be interesting.]
- `Comments`	[shows no published comments]
- `Manage`	[Allows us to manage posts, pages, and categories. We can edit and delete categories, not overly interesting.]
- `Settings`	[Scrolling to the bottom confirms that the vulnerable version 4.0.3 is in use. Several settings are available, but none seem valuable to us.]
- `Themes`	[This Allows us to install a new theme from a pre-selected list.]
- `Plugins`	[Allows us to configure, install, or uninstall plugins. The My image plugin allows us to upload an image file. Could this be abused to upload PHP code potentially?]

- 
