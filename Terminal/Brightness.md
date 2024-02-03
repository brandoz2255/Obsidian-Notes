- To change the brightness in the terminal we first must utilize the `xrandr` tool in order to do this
- We can do this by checking the state first with the input command of `xrandr -q`
- This will just give you information on your connected display

``` Shell-session 
xrandr --verbose | grep -i brightness
```

